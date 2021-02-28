//
//  LNAsyncOperationQueue.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNAsyncOperation.h"

NS_ASSUME_NONNULL_BEGIN

/* *
* Thread-safe.
*/

@interface LNAsyncOperationQueue : NSObject

@property (nonatomic, strong, readonly) NSMutableOrderedSet<LNAsyncOperation *> *mOrderedSet;
@property (nonatomic, strong, readonly) NSMutableOrderedSet<LNAsyncOperation *> *priorityMOrderedSet;

- (void)push:(LNAsyncOperation *)operation;
- (LNAsyncOperation *)popRespectPriority:(BOOL)respectPriority;

- (void)clear;
- (BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END

