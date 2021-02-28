//
//  DemoDefaultFeedDisplayProtocol.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DemoDefaultFeedItemDisplayProtocol <NSObject>

- (NSString *)demoDefaultFeedItemTitle;
- (NSString *)demoDefaultFeedItemDate;
- (NSString *)demoDefaultFeedItemImageUrl;
- (NSString *)demoDefaultFeedItemJumpPath;

@end

@protocol DemoDefaultFeedDisplayProtocol <NSObject>

- (NSArray<NSObject<DemoDefaultFeedItemDisplayProtocol> *> *)demoDefaultFeedItemArray;

@end

NS_ASSUME_NONNULL_END

