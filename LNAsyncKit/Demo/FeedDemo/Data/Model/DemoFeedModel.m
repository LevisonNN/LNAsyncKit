//
//  DemoFeedModel.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "DemoFeedModel.h"

@interface DemoFeedModel ()

@end

@implementation DemoFeedModel

- (nonnull id<NSObject>)diffIdentifier
{
    return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object
{
    return (self == object)?YES:NO;
}


+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"result" : @"DemoFeedItemModel"};
}

- (NSArray<NSObject<DemoAsyncFeedItemDisplayProtocol> *> *)demoAsyncFeedItemArray
{
    return self.result;
}

- (NSArray<NSObject<DemoDefaultFeedItemDisplayProtocol> *> *)demoDefaultFeedItemArray
{
    return self.result;
}


@end
