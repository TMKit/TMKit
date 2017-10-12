//
//  TMOperationQueue.m
//  Pods
//
//  Created by Teemo on 12/10/2017.
//

#import "TMOperationQueue.h"
#import <pthread.h>

@class TMOperation;

@interface NSNumber (TMOperationQueue) <TMOperationReference>

@end

@interface TMOperationQueue () {
    pthread_mutex_t _lock;
    //increments with every operation to allow cancelation
    NSUInteger _operationReferenceCount;
    NSUInteger _maxConcurrentOperations;
    
    dispatch_group_t _group;
    
    dispatch_queue_t _serialQueue;
    BOOL _serialQueueBusy;
    
    dispatch_semaphore_t _concurrentSemaphore;
    dispatch_queue_t _concurrentQueue;
    dispatch_queue_t _semaphoreQueue;
    
    NSMutableOrderedSet<TMOperation *> *_queuedOperations;
    NSMutableOrderedSet<TMOperation *> *_lowPriorityOperations;
    NSMutableOrderedSet<TMOperation *> *_defaultPriorityOperations;
    NSMutableOrderedSet<TMOperation *> *_highPriorityOperations;
    
    NSMapTable<id<TMOperationReference>, TMOperation *> *_referenceToOperations;
    NSMapTable<NSString *, TMOperation *> *_identifierToOperations;
}

@end

@interface TMOperation : NSObject

@property (nonatomic, strong) TMOperationBlock block;
@property (nonatomic, strong) id <TMOperationReference> reference;
@property (nonatomic, assign) TMOperationQueuePriority priority;
@property (nonatomic, strong) NSMutableArray<dispatch_block_t> *completions;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) id data;

+ (instancetype)operationWithBlock:(TMOperationBlock)block reference:(id <TMOperationReference>)reference priority:(TMOperationQueuePriority)priority identifier:(nullable NSString *)identifier data:(nullable id)data completion:(nullable dispatch_block_t)completion;

- (void)addCompletion:(nullable dispatch_block_t)completion;

@end

@implementation TMOperation

+ (instancetype)operationWithBlock:(TMOperationBlock)block reference:(id<TMOperationReference>)reference priority:(TMOperationQueuePriority)priority identifier:(NSString *)identifier data:(id)data completion:(dispatch_block_t)completion
{
    TMOperation *operation = [[self alloc] init];
    operation.block = block;
    operation.reference = reference;
    operation.priority = priority;
    operation.identifier = identifier;
    operation.data = data;
    [operation addCompletion:completion];
    
    return operation;
}

- (void)addCompletion:(dispatch_block_t)completion
{
    if (completion == nil) {
        return;
    }
    if (_completions == nil) {
        _completions = [NSMutableArray array];
    }
    [_completions addObject:completion];
}

@end

@implementation TMOperationQueue

- (instancetype)initWithMaxConcurrentOperations:(NSUInteger)maxConcurrentOperations
{
    return [self initWithMaxConcurrentOperations:maxConcurrentOperations concurrentQueue:dispatch_queue_create("TMOperationQueue Concurrent Queue", DISPATCH_QUEUE_CONCURRENT)];
}

- (instancetype)initWithMaxConcurrentOperations:(NSUInteger)maxConcurrentOperations concurrentQueue:(dispatch_queue_t)concurrentQueue
{
    if (self = [super init]) {
        NSAssert(maxConcurrentOperations > 0, @"Max concurrent operations must be greater than 0.");
        _maxConcurrentOperations = maxConcurrentOperations;
        _operationReferenceCount = 0;
        
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        //mutex must be recursive to allow scheduling of operations from within operations
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
        pthread_mutex_init(&_lock, &attr);
        
        _group = dispatch_group_create();
        
        _serialQueue = dispatch_queue_create("TMOperationQueue Serial Queue", DISPATCH_QUEUE_SERIAL);
        
        _concurrentQueue = concurrentQueue;
        
        //Create a queue with max - 1 because this plus the serial queue add up to max.
        _concurrentSemaphore = dispatch_semaphore_create(_maxConcurrentOperations - 1);
        _semaphoreQueue = dispatch_queue_create("TMOperationQueue Serial Semaphore Queue", DISPATCH_QUEUE_SERIAL);
        
        _queuedOperations = [[NSMutableOrderedSet alloc] init];
        _lowPriorityOperations = [[NSMutableOrderedSet alloc] init];
        _defaultPriorityOperations = [[NSMutableOrderedSet alloc] init];
        _highPriorityOperations = [[NSMutableOrderedSet alloc] init];
        
        _referenceToOperations = [NSMapTable weakToWeakObjectsMapTable];
        _identifierToOperations = [NSMapTable weakToWeakObjectsMapTable];
    }
    return self;
}

- (void)dealloc
{
    pthread_mutex_destroy(&_lock);
}

+ (instancetype)sharedOperationQueue
{
    static TMOperationQueue *sharedOperationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOperationQueue = [[TMOperationQueue alloc] initWithMaxConcurrentOperations:MAX([[NSProcessInfo processInfo] activeProcessorCount], 2)];
    });
    return sharedOperationQueue;
}

- (id <TMOperationReference>)nextOperationReference
{
    [self lock];
    id <TMOperationReference> reference = [NSNumber numberWithUnsignedInteger:++_operationReferenceCount];
    [self unlock];
    return reference;
}

// Deprecatedb
- (id <TMOperationReference>)addOperation:(dispatch_block_t)block
{
    return [self scheduleOperation:block];
}

- (id <TMOperationReference>)scheduleOperation:(dispatch_block_t)block
{
    return [self scheduleOperation:block withPriority:TMOperationQueuePriorityDefault];
}



- (id <TMOperationReference>)scheduleOperation:(dispatch_block_t)block withPriority:(TMOperationQueuePriority)priority
{
    TMOperation *operation = [TMOperation operationWithBlock:^(id data) { block(); }
                                                     reference:[self nextOperationReference]
                                                      priority:priority
                                                    identifier:nil
                                                          data:nil
                                                    completion:nil];
    [self lock];
    [self locked_addOperation:operation];
    [self unlock];
    
    [self scheduleNextOperations:NO];
    
    return operation.reference;
}





- (void)locked_addOperation:(TMOperation *)operation
{
    NSMutableOrderedSet *queue = [self operationQueueWithPriority:operation.priority];
    
    dispatch_group_enter(_group);
    [queue addObject:operation];
    [_queuedOperations addObject:operation];
    [_referenceToOperations setObject:operation forKey:operation.reference];
    if (operation.identifier != nil) {
        [_identifierToOperations setObject:operation forKey:operation.identifier];
    }
}

- (void)cancelAllOperations
{
    [self lock];
    for (TMOperation *operation in [[_referenceToOperations copy] objectEnumerator]) {
        [self locked_cancelOperation:operation.reference];
    }
    [self unlock];
}


- (BOOL)cancelOperation:(id <TMOperationReference>)operationReference
{
    [self lock];
    BOOL success = [self locked_cancelOperation:operationReference];
    [self unlock];
    return success;
}

- (NSUInteger)maxConcurrentOperations
{
    [self lock];
    NSUInteger maxConcurrentOperations = _maxConcurrentOperations;
    [self unlock];
    return maxConcurrentOperations;
}

- (void)setMaxConcurrentOperations:(NSUInteger)maxConcurrentOperations
{
    NSAssert(maxConcurrentOperations > 0, @"Max concurrent operations must be greater than 0.");
    [self lock];
    __block NSInteger difference = maxConcurrentOperations - _maxConcurrentOperations;
    _maxConcurrentOperations = maxConcurrentOperations;
    [self unlock];
    
    if (difference == 0) {
        return;
    }
    
    dispatch_async(_semaphoreQueue, ^{
        while (difference != 0) {
            if (difference > 0) {
                dispatch_semaphore_signal(_concurrentSemaphore);
                difference--;
            } else {
                dispatch_semaphore_wait(_concurrentSemaphore, DISPATCH_TIME_FOREVER);
                difference++;
            }
        }
    });
}

// Deprecated
- (id<TMOperationReference>)addOperation:(TMOperationBlock)block
                             withPriority:(TMOperationQueuePriority)priority
                               identifier:(NSString *)identifier
                           coalescingData:(id)coalescingData
                      dataCoalescingBlock:(TMOperationDataCoalescingBlock)dataCoalescingBlock
                               completion:(dispatch_block_t)completion
{
    return [self scheduleOperation:block
                      withPriority:priority
                        identifier:identifier
                    coalescingData:coalescingData
               dataCoalescingBlock:dataCoalescingBlock
                        completion:completion];
}

- (id<TMOperationReference>)scheduleOperation:(TMOperationBlock)block
                                  withPriority:(TMOperationQueuePriority)priority
                                    identifier:(NSString *)identifier
                                coalescingData:(id)coalescingData
                           dataCoalescingBlock:(TMOperationDataCoalescingBlock)dataCoalescingBlock
                                    completion:(dispatch_block_t)completion
{
    id<TMOperationReference> reference = nil;
    BOOL isNewOperation = NO;
    
    [self lock];
    TMOperation *operation = nil;
    if (identifier != nil && (operation = [_identifierToOperations objectForKey:identifier]) != nil) {
        // There is an exisiting operation with the provided identifier, let's coalesce these operations
        if (dataCoalescingBlock != nil) {
            operation.data = dataCoalescingBlock(operation.data, coalescingData);
        }
        
        [operation addCompletion:completion];
    } else {
        isNewOperation = YES;
        operation = [TMOperation operationWithBlock:block
                                           reference:[self nextOperationReference]
                                            priority:priority
                                          identifier:identifier
                                                data:coalescingData
                                          completion:completion];
        [self locked_addOperation:operation];
    }
    reference = operation.reference;
    [self unlock];
    
    if (isNewOperation) {
        [self scheduleNextOperations:NO];
    }
    
    return reference;
}








#pragma mark - private methods

- (BOOL)locked_cancelOperation:(id <TMOperationReference>)operationReference
{
    BOOL success = NO;
    TMOperation *operation = [_referenceToOperations objectForKey:operationReference];
    if (operation) {
        NSMutableOrderedSet *queue = [self operationQueueWithPriority:operation.priority];
        if ([queue containsObject:operation]) {
            success = YES;
            [queue removeObject:operation];
            [_queuedOperations removeObject:operation];
            dispatch_group_leave(_group);
        }
    }
    return success;
}

- (void)setOperationPriority:(TMOperationQueuePriority)priority withReference:(id <TMOperationReference>)operationReference
{
    [self lock];
    TMOperation *operation = [_referenceToOperations objectForKey:operationReference];
    if (operation && operation.priority != priority) {
        NSMutableOrderedSet *oldQueue = [self operationQueueWithPriority:operation.priority];
        [oldQueue removeObject:operation];
        
        operation.priority = priority;
        
        NSMutableOrderedSet *queue = [self operationQueueWithPriority:priority];
        [queue addObject:operation];
    }
    [self unlock];
}

/**
 Schedule next operations schedules the next operation by queue order onto the serial queue if
 it's available and one operation by priority order onto the concurrent queue.
 */
- (void)scheduleNextOperations:(BOOL)onlyCheckSerial
{
    [self lock];
    
    //get next available operation in order, ignoring priority and run it on the serial queue
    if (_serialQueueBusy == NO) {
        TMOperation *operation = [self locked_nextOperationByQueue];
        if (operation) {
            _serialQueueBusy = YES;
            dispatch_async(_serialQueue, ^{
                operation.block(operation.data);
                for (dispatch_block_t completion in operation.completions) {
                    completion();
                }
                dispatch_group_leave(_group);
                
                [self lock];
                _serialQueueBusy = NO;
                [self unlock];
                
                //see if there are any other operations
                [self scheduleNextOperations:YES];
            });
        }
    }
    
    NSInteger maxConcurrentOperations = _maxConcurrentOperations;
    
    [self unlock];
    
    if (onlyCheckSerial) {
        return;
    }
    
    //if only one concurrent operation is set, let's just use the serial queue for executing it
    if (maxConcurrentOperations < 2) {
        return;
    }
    
    dispatch_async(_semaphoreQueue, ^{
        dispatch_semaphore_wait(_concurrentSemaphore, DISPATCH_TIME_FOREVER);
        [self lock];
        TMOperation *operation = [self locked_nextOperationByPriority];
        [self unlock];
        
        if (operation) {
            dispatch_async(_concurrentQueue, ^{
                operation.block(operation.data);
                for (dispatch_block_t completion in operation.completions) {
                    completion();
                }
                dispatch_group_leave(_group);
                dispatch_semaphore_signal(_concurrentSemaphore);
            });
        } else {
            dispatch_semaphore_signal(_concurrentSemaphore);
        }
    });
}

- (NSMutableOrderedSet *)operationQueueWithPriority:(TMOperationQueuePriority)priority
{
    switch (priority) {
        case TMOperationQueuePriorityLow:
            return _lowPriorityOperations;
            
        case TMOperationQueuePriorityDefault:
            return _defaultPriorityOperations;
            
        case TMOperationQueuePriorityHigh:
            return _highPriorityOperations;
            
        default:
            NSAssert(NO, @"Invalid priority set");
            return _defaultPriorityOperations;
    }
}

//Call with lock held
- (TMOperation *)locked_nextOperationByPriority
{
    TMOperation *operation = [_highPriorityOperations firstObject];
    if (operation == nil) {
        operation = [_defaultPriorityOperations firstObject];
    }
    if (operation == nil) {
        operation = [_lowPriorityOperations firstObject];
    }
    if (operation) {
        [self locked_removeOperation:operation];
    }
    return operation;
}

//Call with lock held
- (TMOperation *)locked_nextOperationByQueue
{
    TMOperation *operation = [_queuedOperations firstObject];
    [self locked_removeOperation:operation];
    return operation;
}

- (void)waitUntilAllOperationsAreFinished
{
    [self scheduleNextOperations:NO];
    dispatch_group_wait(_group, DISPATCH_TIME_FOREVER);
}

//Call with lock held
- (void)locked_removeOperation:(TMOperation *)operation
{
    if (operation) {
        NSMutableOrderedSet *priorityQueue = [self operationQueueWithPriority:operation.priority];
        [priorityQueue removeObject:operation];
        [_queuedOperations removeObject:operation];
    }
}

- (void)lock
{
    pthread_mutex_lock(&_lock);
}

- (void)unlock
{
    pthread_mutex_unlock(&_lock);
}

@end

