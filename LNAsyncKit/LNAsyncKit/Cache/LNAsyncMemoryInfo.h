//
//  LNAsyncMemoryInfo.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger, LNAsyncMemorySpaceType)
{
    LNAsyncMemorySpaceTiny = 0,
    LNAsyncMemorySpaceSmall,
    LNAsyncMemorySpaceMiddle,
    LNAsyncMemorySpaceLarge,
};

@interface LNAsyncMemoryInfo : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, assign, readonly) long long totalMemorySize;
@property (nonatomic, assign, readonly) LNAsyncMemorySpaceType memorySpaceType;

@end

NS_ASSUME_NONNULL_END

