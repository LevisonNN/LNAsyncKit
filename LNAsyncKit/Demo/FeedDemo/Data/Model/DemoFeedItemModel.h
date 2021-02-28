//
//  DemoFeedItemModel.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoFeedItemModel.h"
#import <YYModel.h>
#import "DemoAsyncFeedDisplayProtocol.h"
#import "DemoDefaultFeedDisplayProtocol.h"
#import <UIKit/UIKit.h>
#import "DemoAsyncFeedDisplayLayoutObj.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^DemoFeedItemModelLoadRenderImageCompletionBlock) (BOOL isCanceled, UIImage * _Nullable resultImage);

typedef NS_ENUM (NSInteger, DemoFeedItemModelStatus) {
    DemoFeedItemModelStatusNone = 0,
    DemoFeedItemModelStatusPreload,
    DemoFeedItemModelStatusDisplay,
    DemoFeedItemModelStatusVisible,
};

@interface DemoFeedItemModel : NSObject <YYModel, DemoAsyncFeedItemDisplayProtocol, DemoDefaultFeedItemDisplayProtocol>

@property (nonatomic, copy) NSString *path;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *passtime;

@property (nonatomic, assign) DemoFeedItemModelStatus status;

@property (nonatomic, strong) DemoAsyncFeedDisplayLayoutObj *layoutObj;

@end

NS_ASSUME_NONNULL_END
