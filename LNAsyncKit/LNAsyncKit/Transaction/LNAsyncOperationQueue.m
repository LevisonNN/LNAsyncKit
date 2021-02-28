//
//  LNAsyncOperationQueue.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncOperationQueue.h"

@interface LNAsyncOperationQueue ()
//Regardless of priority
@property (nonatomic, strong) NSMutableOrderedSet<LNAsyncOperation *> *mOrderedSet;

//Consider priority
@property (nonatomic, strong) NSMutableOrderedSet<LNAsyncOperation *> *priorityMOrderedSet;

@end

@implementation LNAsyncOperationQueue

- (void)push:(LNAsyncOperation *)operation
{
    @synchronized (self) {
        if (operation && [operation isKindOfClass:LNAsyncOperation.class]) {
            [self.mOrderedSet addObject:operation];
            NSUInteger newIndex = [self.priorityMOrderedSet indexOfObject:operation
                                                            inSortedRange:(NSRange){0, [self.priorityMOrderedSet count]}
                                                                  options:NSBinarySearchingInsertionIndex|NSBinarySearchingLastEqual usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                LNAsyncOperation *operation1 = obj1;
                LNAsyncOperation *operation2 = obj2;
                if ([operation1 priority] < [operation2 priority]) {
                    return NSOrderedAscending;
                } else if ([operation1 priority] > [operation2 priority]) {
                    return NSOrderedDescending;
                } else {
                    return NSOrderedSame;
                }
            }];
            [self.priorityMOrderedSet insertObject:operation atIndex:newIndex];
        }
    }
}

- (LNAsyncOperation *)popRespectPriority:(BOOL)respectPriority
{
    @synchronized (self) {
        if (respectPriority) {
            LNAsyncOperation *operation = [self.priorityMOrderedSet firstObject];
            if (operation) {
                [self.priorityMOrderedSet removeObject:operation];
                [self.mOrderedSet removeObject:operation];
            }
            return operation;
        } else {
            LNAsyncOperation *operation = [self.mOrderedSet firstObject];
            if (operation) {
                [self.priorityMOrderedSet removeObject:operation];
                [self.mOrderedSet removeObject:operation];
            }
            return operation;
        }
    }
}

- (BOOL)isEmpty
{
    @synchronized (self) {
        return self.mOrderedSet.count <= 0;
    }
}

- (void)clear
{
    @synchronized (self) {
        [self.mOrderedSet removeAllObjects];
        [self.priorityMOrderedSet removeAllObjects];
    }
}

- (NSMutableOrderedSet<LNAsyncOperation *> *)mOrderedSet
{
    if (!_mOrderedSet) {
        _mOrderedSet = [[NSMutableOrderedSet alloc] init];
    }
    return _mOrderedSet;
}

- (NSMutableOrderedSet<LNAsyncOperation *> *)priorityMOrderedSet
{
    if (!_priorityMOrderedSet) {
        _priorityMOrderedSet = [[NSMutableOrderedSet alloc] init];
    }
    return _priorityMOrderedSet;
}
@end
