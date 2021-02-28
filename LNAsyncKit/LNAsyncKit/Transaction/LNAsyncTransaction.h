//
//  LNAsyncTransaction.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNAsyncOperation.h"

#define LNAsyncTransactionAssertMainThread NSAssert([[NSThread currentThread] isMainThread],@"Main thread only!")

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LNAsyncTransactionState)
{
    LNAsyncTransactionStateOpen,
    LNAsyncTransactionStateCommitted,
    LNAsyncTransactionStateCanceled,
    LNAsyncTransactionStateCompleted,
};

@class LNAsyncTransaction;

typedef id _Nullable (^LNAsyncTransactionBlock)(void);
typedef void(^ LNAsyncTransactionOperationCompleteBlock)(id _Nullable value, BOOL canceled);

typedef void(^ LNAsyncTransactionCompleteBlock)(LNAsyncTransaction *completedTransaction, BOOL canceled);

@interface LNAsyncTransaction : NSObject

@property(nonatomic, assign) LNAsyncTransactionState state;

@property (nonatomic, copy, readonly) LNAsyncTransactionCompleteBlock completionBlock;
- (instancetype)initWithCompletionBlock:(nullable LNAsyncTransactionCompleteBlock)completionBlock;



- (void)addOperationWithBlock:(LNAsyncTransactionBlock)block
                     priority:(NSInteger)priority
                        queue:(dispatch_queue_t)queue
                   completion:(nullable LNAsyncTransactionOperationCompleteBlock)completion;

- (void)commit;

- (void)cancel;

@end

NS_ASSUME_NONNULL_END
