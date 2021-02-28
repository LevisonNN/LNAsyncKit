//
//  LNAsyncRenderer.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncRenderer.h"
#import "LNAsyncRendererTraversalStack.h"

@interface LNAsyncRenderer ()

@end

@implementation LNAsyncRenderer

+ (void)traversalElement:(LNAsyncElement *)element
{
    if (!element) {
        return;
    }
    LNAsyncRendererTraversalStack *stack = [[LNAsyncRendererTraversalStack alloc] init];
    [stack pushElements:@[element]];
    
    NSMutableSet <LNAsyncElement *> *repeatDetectMSet = [[NSMutableSet alloc] init];
    while (!stack.isEmpty) {
        LNAsyncElement *topElement = [stack top];
        if (topElement.getSubElements.count > 0 && (![repeatDetectMSet containsObject:topElement])) {
            [repeatDetectMSet addObject:topElement];
            [stack pushElements:topElement.getSubElements.reverseObjectEnumerator.allObjects];
        } else {
            [stack pop];
            [self renderElement:topElement];
            for (LNAsyncElement *subElement in topElement.getSubElements) {
                subElement.renderResult = nil;
            }
        }
    }
}

+ (UIImage *)renderElement:(LNAsyncElement *)element
{
    if (element.frame.size.height == 0 || element.frame.size.width == 0) {
        return nil;
    }
    
    UIImage *resultImage = nil;
    
    if (@available(iOS 10.0, *)) {
        UIGraphicsImageRendererFormat *format = [UIGraphicsImageRendererFormat defaultFormat];
        format.scale = [UIScreen mainScreen].scale;
        resultImage = [[[UIGraphicsImageRenderer alloc] initWithSize:element.frame.size format:format] imageWithActions:^(UIGraphicsImageRendererContext *rendererContext) {
            [element _renderWithContext:rendererContext.CGContext];
        }];
    } else {
         UIGraphicsBeginImageContextWithOptions(element.frame.size, NO, [UIScreen mainScreen].scale);
         [element _renderWithContext:UIGraphicsGetCurrentContext()];
         resultImage = UIGraphicsGetImageFromCurrentImageContext();
         UIGraphicsEndImageContext();
    }
    element.renderResult = resultImage;
    return resultImage;
}

+ (dispatch_queue_t)globalRenderQueue
{
    static dispatch_queue_t globalRenderQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      globalRenderQueue = dispatch_queue_create("LNAsyncRender.GlobalRenderQueue", DISPATCH_QUEUE_CONCURRENT);
      dispatch_set_target_queue(globalRenderQueue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0));
    });
    return globalRenderQueue;
}

@end


