//
//  LNAsyncElement.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncElement.h"

@interface LNAsyncElement ()

@property (nonatomic, weak) LNAsyncElement *superElement;
@property (nonatomic, strong) NSMutableOrderedSet <LNAsyncElement *> *subElementsMOrderedSet;

@end

@implementation LNAsyncElement

- (void)addSubElement:(LNAsyncElement *)element
{
    if (![self.subElementsMOrderedSet containsObject:element]) {
        element.superElement = self;
        [self.subElementsMOrderedSet addObject:element];
    }
}

- (void)removeSubElement:(LNAsyncElement *)element
{
    if ([self.subElementsMOrderedSet containsObject:element]) {
        if (element.superElement == self) {
            element.superElement = nil;
        }
        [self.subElementsMOrderedSet removeObject:element];
    }
}

- (NSArray<LNAsyncElement *> *)getSubElements
{
    return self.subElementsMOrderedSet.array;
}

- (LNAsyncElement *)getSuperElement
{
    return self.superElement;
}

- (void)_renderWithContext:(CGContextRef)context
{
    [self _preSetWithContext:context];
    [self renderSelfWithContext:context];
    for (LNAsyncElement *element in self.getSubElements) {
        [element.renderResult drawInRect:element.frame];
    }
    [self _completeWithContext:context];
}

- (void)_preSetWithContext:(CGContextRef)context
{
    CGPathRef cornerRect = [self getCurrentBorderPath];
    CGContextAddPath(context, cornerRect);
    CGContextClip(context);
    
    if (self.backgroundColor) {
        CGContextAddPath(context, cornerRect);
        CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
        CGContextFillPath(context);
    }
}

- (void)_completeWithContext:(CGContextRef)context
{
    CGPathRef cornerRect = [self getCurrentBorderPath];
    
    if (self.borderWidth > 0.01f && self.borderColor) {
        //Outside part will be clipped
        CGContextAddPath(context, cornerRect);
        CGContextSetLineWidth(context, self.borderWidth * 2.f);
        CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
        CGContextStrokePath(context);
    }
}

- (NSMutableOrderedSet<LNAsyncElement *> *)subElementsMOrderedSet
{
    if (!_subElementsMOrderedSet) {
        _subElementsMOrderedSet = [[NSMutableOrderedSet alloc] init];
    }
    return _subElementsMOrderedSet;
}

- (CGPathRef)getCurrentBorderPath
{
    CGPathRef cornerRect;
    if (self.cornerRadius > 0.01f) {
        cornerRect = CGPathCreateWithRoundedRect(CGRectMake(0.f, 0.f, self.frame.size.width ,self.frame.size.height), self.cornerRadius, self.cornerRadius, nil);
    } else if (self.frame.size.height == self.frame.size.width && fabs(self.cornerRadius*2 - self.frame.size.width) < 0.01) {
        cornerRect = CGPathCreateWithEllipseInRect(CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height), nil);
    } else {
        cornerRect = CGPathCreateWithRect(CGRectMake(0.f, 0.f, self.frame.size.width ,self.frame.size.height), nil);
    }
    return cornerRect;
}

@end

@implementation LNAsyncElement (Render)

- (void)renderSelfWithContext:(CGContextRef)context
{
    
}

@end

