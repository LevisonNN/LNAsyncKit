//
//  LNAsyncTransactionGroup.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncTransactionGroup.h"

@interface LNAsyncTransactionGroup ()

@property (nonatomic, strong) NSMutableSet <LNAsyncTransaction *> *transactions;

@end

@implementation LNAsyncTransactionGroup
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (LNAsyncTransactionGroup *)mainTransactionGroup
{
    static LNAsyncTransactionGroup *mainTransactionGroup;
    LNAsyncTransactionAssertMainThread;
    if (mainTransactionGroup == nil) {
      mainTransactionGroup = [[LNAsyncTransactionGroup alloc] init];
      [mainTransactionGroup registerMainRunloopObserver];
    }
    return mainTransactionGroup;
}

- (void)registerMainRunloopObserver
{
    LNAsyncTransactionAssertMainThread;
    static CFRunLoopObserverRef observer;
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFOptionFlags activities = (kCFRunLoopBeforeWaiting |
                              kCFRunLoopExit);

    observer = CFRunLoopObserverCreateWithHandler(NULL,
                                                activities,
                                                YES,
                                                INT_MAX,
                                                ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        LNAsyncTransactionAssertMainThread;
                                                  [self commit];
                                                });
    CFRunLoopAddObserver(runLoop, observer, kCFRunLoopCommonModes);
    CFRelease(observer);
}

- (void)addTransaction:(LNAsyncTransaction *)transaction
{
    LNAsyncTransactionAssertMainThread;
    if (transaction) {
        [self.transactions addObject:transaction];
    }
}

- (void)commit
{
    LNAsyncTransactionAssertMainThread;
    if ([self.transactions count] > 0) {
        NSArray *transactionArr = [NSArray arrayWithArray:self.transactions.allObjects];
        [self.transactions removeAllObjects];
        for (LNAsyncTransaction *transaction in transactionArr) {
            [transaction commit];
        }
    }
}

- (NSMutableSet<LNAsyncTransaction *> *)transactions
{
    if (!_transactions) {
        _transactions = [[NSMutableSet alloc] init];
    }
    return _transactions;
}

@end
