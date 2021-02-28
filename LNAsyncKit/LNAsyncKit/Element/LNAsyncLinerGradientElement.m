//
//  LNAsyncLinerGradientElement.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncLinerGradientElement.h"

@interface LNAsyncLinerGradientElement ()

@end

@implementation LNAsyncLinerGradientElement

- (void)renderSelfWithContext:(CGContextRef)context
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[self.gradientPercentPoints.count];
    for (int i = 0; i < self.gradientPercentPoints.count; i++) {
        locations[i] = [self.gradientPercentPoints objectAtIndex:i].floatValue;
    }
    
    NSMutableArray *colorMArr = [[NSMutableArray alloc] init];
    for (UIColor *color in self.gradientColorArray) {
        [colorMArr addObject:(__bridge id)color.CGColor];
    }
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)[NSArray arrayWithArray:colorMArr], locations);
    switch (self.direction) {
        case LNAsyncLinerGradientElementHorizontal: {
            CGContextDrawLinearGradient(context, gradient, CGPointMake(0.f, 0.f) , CGPointMake(self.frame.size.width, 0.f), 0);
        } break;
        default: {
            CGContextDrawLinearGradient(context, gradient, CGPointMake(0.f, 0.f) , CGPointMake(0.f, self.frame.size.height), 0);
        } break;
    }

}

@end

