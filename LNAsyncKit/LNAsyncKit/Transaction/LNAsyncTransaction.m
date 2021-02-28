//
//  LNAsyncTransaction.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncTransaction.h"
#import "LNAsyncOperationGroup.h"

@interface LNAsyncTransactionOperation : NSObject

- (instancetype)initWithOperationCompletionBlock:(LNAsyncTransactionOperationCompleteBlock)operationCompletionBlock;

@property (nonatomic, copy) LNAsyncTransactionOperationCompleteBlock operationCompletionBlock;
@property id value;

@end

@implementation LNAsyncTransactionOperation

- (instancetype)initWithOperationCompletionBlock:(LNAsyncTransactionOperationCompleteBlock)operationCompletionBlock
{
    self = [super init];
    if (self) {
        self.operationCompletionBlock = operationCompletionBlock;
    }
    return self;
}

- (void)callAndReleaseCompletionBlock:(BOOL)canceled;
{
    LNAsyncTransactionAssertMainThread;
    if (_operationCompletionBlock) {
        _operationCompletionBlock(self.value, canceled);
        _operationCompletionBlock = nil;
    }
}

@end

@interface LNAsyncTransaction ()

@property (nonatomic, strong) LNAsyncOperationGroup *group;
@property (nonatomic, strong) NSMutableArray <LNAsyncTransactionOperation *> *operationMArr;
@property (nonatomic, copy) LNAsyncTransactionCompleteBlock completionBlock;

@end

@implementation LNAsyncTransaction

- (instancetype)initWithCompletionBlock:(LNAsyncTransactionCompleteBlock)completionBlock
{
    self = [super init];
    if (self) {
        self.completionBlock = completionBlock;
    }
    return self;
}

- (void)ensurePropertyInit
{
    if (!_group) {
        _group = [[LNAsyncOperationGroup alloc] init];
    }
    
    if (!_operationMArr) {
        _operationMArr = [[NSMutableArray alloc] init];
    }
}


- (void)addOperationWithBlock:(LNAsyncTransactionBlock)block
                     priority:(NSInteger)priority
                        queue:(dispatch_queue_t)queue
                   completion:(nullable LNAsyncTransactionOperationCompleteBlock)completion
{
    LNAsyncTransactionAssertMainThread;
    NSAssert(self.state == LNAsyncTransactionStateOpen, @"Open first!");

    [self ensurePropertyInit];

    LNAsyncTransactionOperation *operation = [[LNAsyncTransactionOperation alloc] initWithOperationCompletionBlock:completion];
    [self.operationMArr addObject:operation];
    [self.group schedulePriority:priority queue:queue block:^{
        @autoreleasepool {
          if (self.state != LNAsyncTransactionStateCanceled) {
              operation.value = block();
          }
        }
    }];
}

- (void)cancel
{
    LNAsyncTransactionAssertMainThread;
    NSAssert(self.state != LNAsyncTransactionStateOpen, @"Commited or canceled.");
    self.state = LNAsyncTransactionStateCanceled;
}

- (void)commit
{
    LNAsyncTransactionAssertMainThread;
    NSAssert(self.state == LNAsyncTransactionStateOpen, @"Once only.");
    self.state = LNAsyncTransactionStateCommitted;
    if ([self.operationMArr count] == 0) {
        if (_completionBlock) {
            _completionBlock(self, NO);
        }
        
    } else {
        NSAssert(_group != NULL, @"Create first.");
        [self.group notifyQueue:dispatch_get_main_queue() block:^{
            [self completeTransaction];
        }];
    }
}

- (void)completeTransaction
{
    LNAsyncTransactionAssertMainThread;
    LNAsyncTransactionState state = self.state;
    if (state != LNAsyncTransactionStateCompleted) {
        BOOL isCanceled = (state == LNAsyncTransactionStateCanceled);
        for (LNAsyncTransactionOperation *operation in self.operationMArr) {
            [operation callAndReleaseCompletionBlock:isCanceled];
            
        }
    self.state = LNAsyncTransactionStateCompleted;

    if (_completionBlock) {
      _completionBlock(self, isCanceled);
    }
  }
}

@end

