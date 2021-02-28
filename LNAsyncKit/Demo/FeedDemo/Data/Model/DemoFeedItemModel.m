//
//  DemoFeedItemModel.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "DemoFeedItemModel.h"
#import <SDWebImage.h>
#import "LNAsyncKit.h"

@interface DemoFeedItemModel ()

@property (nonatomic, weak) UIImage *originalImage;
@property (nonatomic, weak) SDWebImageCombinedOperation *originalImageOperation;

@property (nonatomic, weak) UIImage *renderResultImage;
@property (nonatomic, strong) LNAsyncTransaction *renderResultImageTransaction;

@property (nonatomic, copy) DemoFeedItemModelLoadRenderImageCompletionBlock completionNotiBlock;

@property (nonatomic, assign) NSInteger renderCount;

@end

@implementation DemoFeedItemModel

- (void)setStatus:(DemoFeedItemModelStatus)status
{
    if (status > _status) {
        _status = status;
    }
    [self checkCurrentStatus];
}

- (void)demoAsyncFeedItemLoadRenderImage:(DemoAsyncFeedDisplayImageCompletionBlock)completion
{
    if (self.completionNotiBlock) {
        self.completionNotiBlock(YES, nil);
        self.completionNotiBlock = nil;
    }
    
    UIImage *cacheImage = [[LNAsyncRenderCache shareInstance] renderImageForKey:[self getRenderImageKey]];
    if (cacheImage) {
        self.renderResultImage = cacheImage;
    }
    
    self.completionNotiBlock = completion;
    if (self.renderResultImage && completion) {
        completion(NO, self.renderResultImage);
    } else {
        self.status = LNAsyncInterfaceStatusVisible;
    }
}

- (void)checkCurrentStatus
{
    if (self.status >= DemoFeedItemModelStatusPreload) {
        //需要预加载图片
        //如果一个Model有两张以上的图片，使用dispatch_group下载好一起渲染
        if ((!self.originalImageOperation.loaderOperation) && (!self.originalImageOperation) ) {
            self.originalImageOperation = nil;
        }
        
        if (!self.originalImage && (!self.originalImageOperation)) {
            __weak DemoFeedItemModel *weakSelf = self;
            self.originalImageOperation = [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:weakSelf.image]
                                                                                      options:SDWebImageAvoidDecodeImage
                                                                                     progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            }
                                                                                    completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                if (image) {
                    weakSelf.originalImage = image;
                    [weakSelf checkCurrentStatus];
                }
                weakSelf.originalImageOperation = nil;
            }];
            return;
        }
    }
    
    if (self.status >= DemoFeedItemModelStatusDisplay) {
        if (self.originalImage && (!self.renderResultImage) && (!self.renderResultImageTransaction)) {
            LNAsyncElement *contentElement = [self rebuildElements];
            self.renderResultImageTransaction = [[LNAsyncTransaction alloc] init];
            __weak DemoFeedItemModel *weakSelf = self;
            [self.renderResultImageTransaction addOperationWithBlock:^id _Nullable{
                [LNAsyncRenderer traversalElement:contentElement];
                return contentElement.renderResult;
            } priority:0 queue:[LNAsyncRenderer globalRenderQueue] completion:^(id  _Nullable value, BOOL canceled) {
                if ([value isKindOfClass:UIImage.class] && (!canceled)) {
                    UIImage *image = value;
                    weakSelf.renderResultImage = image;
                    NSString *renderImageKey = [weakSelf getRenderImageKey];
                    [[LNAsyncRenderCache shareInstance] saveRenderImage:image forKey:renderImageKey];
                    if (weakSelf.completionNotiBlock) {
                        weakSelf.completionNotiBlock(NO, image);
                        weakSelf.completionNotiBlock = nil;
                    }
                    weakSelf.renderResultImageTransaction = nil;
                }
                if (!canceled) {
                    weakSelf.renderCount ++ ;
                    NSLog(@"渲染次数:%ld", weakSelf.renderCount);
                }
            }];
            [self.renderResultImageTransaction commit];
        }
    }
}

- (LNAsyncElement *)rebuildElements
{
    
    CGFloat cellWidth = ([UIScreen mainScreen].bounds.size.width - 36.f)/2.f;
    CGFloat cellHeight = self.layoutObj.outputCellHeight;
    
    LNAsyncElement *contentElement = [[LNAsyncElement alloc] init];
    LNAsyncImageElement *coverImageElement = [[LNAsyncImageElement alloc] init];
    LNAsyncTextElement *dateElement = [[LNAsyncTextElement alloc] init];
    LNAsyncLinerGradientElement *gradientElement = [[LNAsyncLinerGradientElement alloc] init];
    LNAsyncTextElement *contextElement = [[LNAsyncTextElement alloc] init];
    
    [contentElement addSubElement:coverImageElement];
    [contentElement addSubElement:contextElement];
    [coverImageElement addSubElement:gradientElement];
    [coverImageElement addSubElement:dateElement];
    
    contentElement.frame = CGRectMake(0.f, 0.f, cellWidth, cellHeight);
    contentElement.cornerRadius = 6.f;
    contentElement.backgroundColor = [UIColor colorWithRed:236.f/256.f green:238.f/256.f blue:248.f/256.f alpha:1.f];
    
    coverImageElement.image = self.originalImage;
    coverImageElement.frame = CGRectMake(0.f, 0.f, self.layoutObj.outputCoverImageWidth, self.layoutObj.outputCoverImageHeight);
    coverImageElement.fillMode = LNAsyncImageScaleAspactFill;
    
    gradientElement.frame = CGRectMake(0.f, self.layoutObj.outputGradientY, self.layoutObj.outputGradientWidth , self.layoutObj.outputGradientHeight);
    UIColor *randomColor = [UIColor colorWithRed:(random()%128)/256.f green:(random()%128)/256.f blue:(random()%128)/256.f alpha:1.f];
    gradientElement.gradientColorArray = @[[randomColor colorWithAlphaComponent:0.f],[randomColor colorWithAlphaComponent:1.f]];
    gradientElement.gradientPercentPoints = @[@(0.f), @(1.f)];
    
    dateElement.text = self.passtime;
    dateElement.frame = CGRectMake(self.layoutObj.outputDateTextX, self.layoutObj.outputDateTextY, self.layoutObj.outputDateTextWidth, self.layoutObj.outputDateTextHeight);
    dateElement.font = [UIFont systemFontOfSize:self.layoutObj.outputDateTextFont];
    dateElement.textColor = [UIColor whiteColor];
    
    contextElement.text = self.title;
    contextElement.frame = CGRectMake(self.layoutObj.outputContextX, self.layoutObj.outputContextY, self.layoutObj.outputContextWidth, self.layoutObj.outputContextHeight);
    contextElement.textColor = [UIColor blackColor];
    contextElement.font = [UIFont systemFontOfSize:self.layoutObj.outputContextTextFont];
    contextElement.lineBreakMode = NSLineBreakByWordWrapping;
    
    return contentElement;
}

- (NSString *)getRenderImageKey
{
    return [NSString stringWithFormat:@"%@%@%@%lf", self.title, self.passtime, self.image, self.layoutObj.outputCellHeight];
}

//async
- (NSString *)demoAsyncFeedItemTitle
{
    return self.title;
}

- (NSString *)demoAsyncFeedItemDate
{
    return self.passtime;
}

- (NSString *)demoAsyncFeedItemJumpPath
{
    return self.path;
}

- (DemoAsyncFeedDisplayLayoutObj *)demoAsyncFeedItemLayoutObj
{
    return self.layoutObj;
}
//default

- (NSString *)demoDefaultFeedItemTitle
{
    return self.title;
}

- (NSString *)demoDefaultFeedItemDate
{
    return self.passtime;
}

- (NSString *)demoDefaultFeedItemImageUrl
{
    return self.image;
}

- (NSString *)demoDefaultFeedItemJumpPath
{
    return self.path;
}

@end
