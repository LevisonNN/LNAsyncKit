//
//  LNAsyncMemoryInfo.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncMemoryInfo.h"

@interface LNAsyncMemoryInfo ()

@property (nonatomic, assign) long long totalMemorySize;

@property (nonatomic, assign) long long unitMB;
@property (nonatomic, assign) long long unitGB;

@end

@implementation LNAsyncMemoryInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _unitMB = 1048576;//1024 * 1024
        _unitGB = 1073741824;//1024 * 1024 * 1024
        _totalMemorySize = [self getTotalMemory];
        _memorySpaceType = [self getMemorySpaceType:_totalMemorySize];
    }
    return self;
}

+ (instancetype)shareInstance
{
    static LNAsyncMemoryInfo *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shareInstance == nil) {
             shareInstance = [[LNAsyncMemoryInfo alloc] init];
        }
    });
    return shareInstance;
}

- (LNAsyncMemorySpaceType)getMemorySpaceType:(long long)memorySize
{
    if (memorySize > 3500 * self.unitMB) {
        return LNAsyncMemorySpaceLarge;
    }
    if (memorySize > 1500 * self.unitMB) {
        return LNAsyncMemorySpaceMiddle;
    }
    if (memorySize > 750 * self.unitMB) {
        return LNAsyncMemorySpaceSmall;
    }
    if (memorySize > 75 * self.unitMB) {
        return LNAsyncMemorySpaceTiny;
    }
    //75MB?
    return LNAsyncMemorySpaceSmall;
}

- (long long)getTotalMemory
{
    return [NSProcessInfo processInfo].physicalMemory;
}



@end

