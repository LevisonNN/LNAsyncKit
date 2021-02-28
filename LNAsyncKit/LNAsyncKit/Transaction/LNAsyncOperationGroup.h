//
//  LNAsyncOperationGroup.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LNAsyncOperationGroup : NSObject

- (void)schedulePriority:(NSInteger)priority
                   queue:(dispatch_queue_t)queue
                   block:(dispatch_block_t)block;

- (void)notifyQueue:(dispatch_queue_t)queue
              block:(dispatch_block_t)block;


@end

NS_ASSUME_NONNULL_END
