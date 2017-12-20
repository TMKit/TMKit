//
//  TMOperationGroup.h
//  FBSnapshotTestCase
//
//  Created by Teemo on 12/10/2017.
//

#import <Foundation/Foundation.h>
#import <TMKit/TMOperationTypes.h>
#import <TMKit/TMMacroDefine.h>


@class TMOperationQueue;

NS_ASSUME_NONNULL_BEGIN

@protocol TMGroupOperationReference;

TM_SUBCLASSING_RESTRICTED
@interface TMOperationGroup : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)asyncOperationGroupWithQueue:(TMOperationQueue *)operationQueue;

- (nullable id <TMGroupOperationReference>)addOperation:(dispatch_block_t)operation;
- (nullable id <TMGroupOperationReference>)addOperation:(dispatch_block_t)operation withPriority:(TMOperationQueuePriority)priority;
- (void)start;
- (void)cancel;
- (void)setCompletion:(dispatch_block_t)completion;
- (void)waitUntilComplete;

@end

@protocol TMGroupOperationReference <NSObject>

@end

NS_ASSUME_NONNULL_END
