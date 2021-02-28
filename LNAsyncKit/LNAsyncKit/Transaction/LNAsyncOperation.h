//
//  LNAsyncOperation.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LNAsyncOperationGroup;

@interface LNAsyncOperation : NSObject

@property (nonatomic, assign) NSInteger priority;

@property (nonatomic, weak, nullable) LNAsyncOperationGroup *group;

@property (nonatomic, strong) id value;

@property (nonatomic, copy, nullable) dispatch_block_t block;


@end

NS_ASSUME_NONNULL_END
