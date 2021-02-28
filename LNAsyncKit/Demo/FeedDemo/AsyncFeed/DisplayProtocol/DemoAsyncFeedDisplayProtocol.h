//
//  DemoAsyncFeedDisplayProtocol.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DemoAsyncFeedDisplayLayoutObj.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^DemoAsyncFeedDisplayImageCompletionBlock) (BOOL isCanceled, UIImage * _Nullable resultImage);

@protocol DemoAsyncFeedItemDisplayProtocol <NSObject>

- (NSString *)demoAsyncFeedItemTitle;
- (NSString *)demoAsyncFeedItemDate;
- (NSString *)demoAsyncFeedItemJumpPath;

- (void)demoAsyncFeedItemLoadRenderImage:(DemoAsyncFeedDisplayImageCompletionBlock)completion;

- (DemoAsyncFeedDisplayLayoutObj *)demoAsyncFeedItemLayoutObj;

@end

@protocol DemoAsyncFeedDisplayProtocol <NSObject>

- (NSArray<NSObject<DemoAsyncFeedItemDisplayProtocol> *> *)demoAsyncFeedItemArray;

@end

NS_ASSUME_NONNULL_END

