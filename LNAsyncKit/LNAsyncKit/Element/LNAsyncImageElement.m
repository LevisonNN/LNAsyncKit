//
//  LNAsyncImageElement.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncImageElement.h"

@interface LNAsyncImageElement ()

@end

@implementation LNAsyncImageElement

- (void)renderSelfWithContext:(CGContextRef)context
{
    if (self.image) {
        [self.image drawInRect:[self.class rectWithImageSize:self.image.size targetRect:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height) fillMode:self.fillMode]];
    }
}

+ (CGRect)rectWithImageSize:(CGSize)imageSize
                 targetRect:(CGRect)targetRect
                   fillMode:(LNAsyncImageFillMode)fillMode
{
    if (imageSize.width < 0.1f || imageSize.height < 0.1f || targetRect.size.width < 0.1f || targetRect.size.height < 0.1f) {
        //eat shit~
        return targetRect;
    }
    
    CGPoint center = CGPointMake(CGRectGetMidX(targetRect), CGRectGetMidY(targetRect));
    
    switch (fillMode) {
        case LNAsyncImageScaleAspactFill: {
            //big
            if (targetRect.size.height/targetRect.size.width > imageSize.height/imageSize.width) {
                CGFloat resultHeight = targetRect.size.height;
                CGFloat resultWidth = resultHeight * (imageSize.width/imageSize.height);
                return CGRectMake(center.x - resultWidth/2.f, center.y - resultHeight/2.f, resultWidth, resultHeight);
            } else {
                CGFloat resultWidth = targetRect.size.width;
                CGFloat resultHeight = resultWidth * (imageSize.height/imageSize.width);
                return CGRectMake(center.x - resultWidth/2.f, center.y - resultHeight/2.f, resultWidth, resultHeight);
            }
        } break;
        case LNAsyncImageScaleAspectFit: {
            //small
            if (targetRect.size.height/targetRect.size.width < imageSize.height/imageSize.width) {
                CGFloat resultHeight = targetRect.size.height;
                CGFloat resultWidth = resultHeight * (imageSize.width/imageSize.height);
                return CGRectMake(center.x - resultWidth/2.f, center.y - resultHeight/2.f, resultWidth, resultHeight);
            } else {
                CGFloat resultWidth = targetRect.size.width;
                CGFloat resultHeight = resultWidth * (imageSize.height/imageSize.width);
                return CGRectMake(center.x - resultWidth/2.f, center.y - resultHeight/2.f, resultWidth, resultHeight);
            }
        } break;
        case LNAsyncImageScaleToFill:
        default:{
            return targetRect;
        } break;
    }
}

@end


