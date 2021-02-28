//
//  DemoAsyncFeedCell.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "DemoAsyncFeedCell.h"
#import "LNAsyncKit.h"
#import <SDWebImage.h>

@interface DemoAsyncFeedCell ()

@property (nonatomic, weak) NSObject <DemoAsyncFeedItemDisplayProtocol> *model;

@end

@implementation DemoAsyncFeedCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setModel:(NSObject<DemoAsyncFeedItemDisplayProtocol> *)model
{
    if (model != _model) {
        _model = model;
        [self updateUI];
    }
}

- (void)updateUI
{
    self.contentView.layer.contents = nil;
    //因为是异步加载的所以这里前后需要校验是否为同一个model，可能会出现两个Model对应同一个Cell的情况；以当前的model为准设置图片。
    NSObject *model = self.model;
    __weak DemoAsyncFeedCell *weakSelf = self;
    [self.model demoAsyncFeedItemLoadRenderImage:^(BOOL isCanceled, UIImage * _Nullable resultImage) {
        if (!isCanceled && resultImage && model == weakSelf.model) {
            weakSelf.contentView.layer.contents = (__bridge id)resultImage.CGImage;
        }
    }];
}


@end
