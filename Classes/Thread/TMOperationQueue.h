//
//  TMOperationQueue.h
//  Pods
//
//  Created by Teemo on 12/10/2017.
//

#import <Foundation/Foundation.h>
#import <TMKit/TMOperationTypes.h>
#import <TMKit/TMMacroDefine.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TMOperationBlock)(id _Nullable data);
typedef _Nullable id(^TMOperationDataCoalescingBlock)(id _Nullable existingData, id _Nullable newData);

@protocol TMOperationReference;

TM_SUBCLASSING_RESTRICTED
@interface TMOperationQueue : NSObject

- (instancetype)init NS_UNAVAILABLE;

/**
 * Initializes and returns a newly allocated operation queue with the specified number of maximum concurrent operations.
 *
 * @param maxConcurrentOperations The maximum number of queued operations that can execute at the same time.
 *
 */
- (instancetype)initWithMaxConcurrentOperations:(NSUInteger)maxConcurrentOperations;

/**
 * Initializes and returns a newly allocated operation queue with the specified number of maximum concurrent operations and the concurrent queue they will be scheduled on.
 *
 * @param maxConcurrentOperations The maximum number of queued operations that can execute at the same time.
 * @param concurrentQueue The operation queue to schedule concurrent operations
 *
 */
- (instancetype)initWithMaxConcurrentOperations:(NSUInteger)maxConcurrentOperations concurrentQueue:(dispatch_queue_t)concurrentQueue NS_DESIGNATED_INITIALIZER;

/**
 * Returns the shared instance of the TMOperationQueue class.
 */
+ (instancetype)sharedOperationQueue;

/**
 * Adds the specified operation object to the receiver.
 *
 * @param operation The operation object to be added to the queue.
 *
 */
- (id <TMOperationReference>)scheduleOperation:(dispatch_block_t)operation;

/**
 * Adds the specified operation object to the receiver.
 *
 * @param operation The operation object to be added to the queue.
 * @param priority The execution priority of the operation in an operation queue.
 */
- (id <TMOperationReference>)scheduleOperation:(dispatch_block_t)operation withPriority:(TMOperationQueuePriority)priority;

/**
 * Adds the specified operation object to the receiver.
 *
 * @param operation The operation object to be added to the queue.
 * @param priority The execution priority of the operation in an operation queue.
 * @param identifier A string that identifies the operations that can be coalesced.
 * @param coalescingData The optional data consumed by this operation that needs to be updated/coalesced with data of a new operation when coalescing the two operations happens.
 * @param dataCoalescingBlock The optional block called to update/coalesce the data of this operation with data of a new operation when coalescing the two operations happens.
 * @param completion The block to execute after the operation finished.
 */
- (id <TMOperationReference>)scheduleOperation:(TMOperationBlock)operation
                                   withPriority:(TMOperationQueuePriority)priority
                                     identifier:(nullable NSString *)identifier
                                 coalescingData:(nullable id)coalescingData
                            dataCoalescingBlock:(nullable TMOperationDataCoalescingBlock)dataCoalescingBlock
                                     completion:(nullable dispatch_block_t)completion;

/**
 * The maximum number of queued operations that can execute at the same time.
 *
 * @discussion The value in this property affects only the operations that the current queue has executing at the same time. Other operation queues can also execute their maximum number of operations in parallel.
 * Reducing the number of concurrent operations does not affect any operations that are currently executing.
 *
 * Setting this value to 1 the operations will not be processed by priority as the operations will processed in a FIFO order to prevent deadlocks if operations depend on certain other operations to run in order.
 *
 */
@property (assign) NSUInteger maxConcurrentOperations;

/**
 * Marks the operation as cancelled
 */
- (BOOL)cancelOperation:(id <TMOperationReference>)operationReference;

/**
 * Cancels all queued operations
 */
- (void)cancelAllOperations;

/**
 * Blocks the current thread until all of the receiver’s queued and executing operations finish executing.
 *
 * @discussion When called, this method blocks the current thread and waits for the receiver’s current and queued
 * operations to finish executing. While the current thread is blocked, the receiver continues to launch already
 * queued operations and monitor those that are executing.
 *
 * @warning This should never be called from within an operation submitted to the TMOperationQueue as this will result
 * in a deadlock.
 */
- (void)waitUntilAllOperationsAreFinished;

/**
 * Sets the priority for a operation via it's reference
 *
 * @param priority The new priority for the operation
 * @param reference The reference for the operation
 *
 */
- (void)setOperationPriority:(TMOperationQueuePriority)priority withReference:(id <TMOperationReference>)reference;



@end

@protocol TMOperationReference <NSObject>

@end

NS_ASSUME_NONNULL_END
