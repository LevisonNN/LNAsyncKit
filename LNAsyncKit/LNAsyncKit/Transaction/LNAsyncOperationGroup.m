//
//  LNAsyncOperationGroup.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncOperationGroup.h"
#import "LNAsyncOperationQueue.h"
#import <UIKit/UIKit.h>

@interface LNAsyncOperationNotify : NSObject

@property(nonatomic, strong) dispatch_queue_t queue;
@property(nonatomic, copy) dispatch_block_t block;

@end

@implementation LNAsyncOperationNotify

@end

@interface LNAsyncOperationGroup ()

@property (atomic, assign) NSInteger pendingOperationCount;
@property (atomic, assign) NSInteger threadCount;
@property (nonatomic, strong) LNAsyncOperationQueue *operationQueue;
@property (nonatomic, strong) NSMutableOrderedSet<LNAsyncOperationNotify *> *notifyMSet;

@end

@implementation LNAsyncOperationGroup

- (void)schedulePriority:(NSInteger)priority
                   queue:(dispatch_queue_t)queue
                   block:(dispatch_block_t)block
{
    LNAsyncOperation *operation = [[LNAsyncOperation alloc] init];
    operation.priority = priority;
    operation.group = self;
    operation.block = block;
    
    [self.operationQueue push:operation];
    
    self.pendingOperationCount ++;
    
    NSUInteger maxThreads = [NSProcessInfo processInfo].activeProcessorCount * 2;
    if ([[NSRunLoop mainRunLoop].currentMode isEqualToString:UITrackingRunLoopMode])
      --maxThreads;
    
    __weak LNAsyncOperationGroup *weakSelf = self;
    if (self.threadCount < maxThreads) {
        BOOL respectPriority = self.threadCount > 0;
        self.threadCount++;
        dispatch_async(queue, ^{
            __strong LNAsyncOperationGroup *strongSelf = weakSelf;
            while (!self.operationQueue.isEmpty) {
                LNAsyncOperation *operation = [strongSelf.operationQueue popRespectPriority:respectPriority];
                if (operation.block) {
                    operation.block();
                }
                [strongSelf leave];
                operation.block = nil;
            }
            self.threadCount --;
        
            if (self.threadCount == 0) {
                NSCAssert([self.operationQueue isEmpty], @"Not empty, but stopped?");
            }
      });
    }
}

- (void)leave
{
    self.pendingOperationCount --;
    if (self.pendingOperationCount == 0) {
        //notify
        NSArray *notifyArr = @[];
        @synchronized (self.notifyMSet) {
            notifyArr = [NSArray arrayWithArray:self.notifyMSet.array];
            [self.notifyMSet removeAllObjects];
        }
        for (LNAsyncOperationNotify *notify in notifyArr) {
            dispatch_async(notify.queue, notify.block);
        }
    }
}

- (void)notifyQueue:(dispatch_queue_t)queue
              block:(dispatch_block_t)block
{
    if (self.pendingOperationCount == 0) {
        dispatch_async(queue, block);
    } else {
        LNAsyncOperationNotify *notify = [[LNAsyncOperationNotify alloc] init];
        notify.block = block;
        notify.queue = queue;
        
        @synchronized (self.notifyMSet) {
            [self.notifyMSet addObject:notify];
        }
    }
}

- (LNAsyncOperationQueue *)operationQueue
{
    if (!_operationQueue) {
        _operationQueue = [[LNAsyncOperationQueue alloc] init];
    }
    return _operationQueue;
}

- (NSMutableOrderedSet<LNAsyncOperationNotify *> *)notifyMSet
{
    if (!_notifyMSet) {
        _notifyMSet = [[NSMutableOrderedSet alloc] init];
    }
    return _notifyMSet;
}


@end


