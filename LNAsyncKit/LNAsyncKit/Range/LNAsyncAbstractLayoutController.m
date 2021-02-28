//
//  LNAsyncAbstractLayoutController.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncAbstractLayoutController.h"

@implementation LNAsyncRangeTuningParameters

+ (instancetype)parametersWithLeadingBuffer:(CGFloat)leadingBuffer
                             trailingBuffer:(CGFloat)trailingBuffer
{
    LNAsyncRangeTuningParameters *parameters = [[LNAsyncRangeTuningParameters alloc] init];
    parameters.leadingBufferScreenfuls = leadingBuffer;
    parameters.trailingBufferScreenfuls = trailingBuffer;
    return parameters;
}

@end

@interface LNAsyncAbstractLayoutController ()

@property (nonatomic, strong) NSMutableArray<NSMutableArray <LNAsyncRangeTuningParameters *> *> * tuningParameters;

@end

@implementation LNAsyncAbstractLayoutController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tuningParameters = [[self class] defaultTuningParameters];
    }
    return self;
}

+ (NSMutableArray<NSMutableArray <LNAsyncRangeTuningParameters *> *> *)defaultTuningParameters
{
    NSMutableArray<NSMutableArray <LNAsyncRangeTuningParameters *> *> *defaultMArr = [NSMutableArray arrayWithCapacity:LNAsyncLayoutRangeModeCount];
    for (int i = 0; i < LNAsyncLayoutRangeModeCount; i++) {
        NSMutableArray <LNAsyncRangeTuningParameters *> * typeMArr = [NSMutableArray arrayWithCapacity:LNAsyncLayoutRangeTypeCount];
        for (int j = 0; j < LNAsyncLayoutRangeTypeCount; j++) {
            switch (i) {
                case LNAsyncLayoutRangeModeVisibleOnly: {
                    switch (j) {
                        case LNAsyncLayoutRangeTypeDisplay: {
                            typeMArr[j] = [LNAsyncRangeTuningParameters parametersWithLeadingBuffer:0 trailingBuffer:0];
                        } break;
                        default: {
                            typeMArr[j] = [LNAsyncRangeTuningParameters parametersWithLeadingBuffer:0 trailingBuffer:0];
                        } break;
                    }
                }break;
                case LNAsyncLayoutRangeModeLowMemory: {
                    switch (j) {
                        case LNAsyncLayoutRangeTypeDisplay: {
                            typeMArr[j] = [LNAsyncRangeTuningParameters parametersWithLeadingBuffer:0 trailingBuffer:0];
                        } break;
                        default: {
                            typeMArr[j] = [LNAsyncRangeTuningParameters parametersWithLeadingBuffer:0 trailingBuffer:0];
                        } break;
                    }
                }break;
                case LNAsyncLayoutRangeModeMinimum: {
                    switch (j) {
                        case LNAsyncLayoutRangeTypeDisplay: {
                            typeMArr[j] = [LNAsyncRangeTuningParameters parametersWithLeadingBuffer:0.25 trailingBuffer:0.25];
                        } break;
                        default: {
                            typeMArr[j] = [LNAsyncRangeTuningParameters parametersWithLeadingBuffer:0.5 trailingBuffer:0.25];
                        } break;
                    }
                }break;
                default: { //Full
                    switch (j) {
                        case LNAsyncLayoutRangeTypeDisplay: {
                            typeMArr[j] = [LNAsyncRangeTuningParameters parametersWithLeadingBuffer:1 trailingBuffer:0.5];
                        } break;
                        default: {
                            typeMArr[j] = [LNAsyncRangeTuningParameters parametersWithLeadingBuffer:2.5 trailingBuffer:1];
                        } break;
                    }
                }
                    break;
            }
        }
        defaultMArr[i] = typeMArr;
    }
    return defaultMArr;
}

+ (LNAsyncDirectionalScreenfulBuffer)screenfulBufferHorizontal:(LNAsyncScrollDirection)scrollDirection
                                                 tuningParameters:(LNAsyncRangeTuningParameters *)tuningParameters
{
    LNAsyncDirectionalScreenfulBuffer horizontalBuffer = {0, 0};
    BOOL movingRight = LNAsyncScrollDirectionContainsRight(scrollDirection);
    
    horizontalBuffer.positiveDirection = movingRight ? tuningParameters.leadingBufferScreenfuls:
                                                       tuningParameters.trailingBufferScreenfuls;
    
    horizontalBuffer.negativeDirection = movingRight ? tuningParameters.trailingBufferScreenfuls:
                                                       tuningParameters.leadingBufferScreenfuls;
    
    return horizontalBuffer;
}

+ (LNAsyncDirectionalScreenfulBuffer)screenfulBufferVertical:(LNAsyncScrollDirection)scrollDirection
                                               tuningParameters:(LNAsyncRangeTuningParameters *)tuningParameters
{
    LNAsyncDirectionalScreenfulBuffer verticalBuffer = {0, 0};
    BOOL movingDown = LNAsyncScrollDirectionContainsDown(scrollDirection);
    
    verticalBuffer.positiveDirection = movingDown ? tuningParameters.leadingBufferScreenfuls
                                                  : tuningParameters.trailingBufferScreenfuls;
    verticalBuffer.negativeDirection = movingDown ? tuningParameters.trailingBufferScreenfuls
                                                  : tuningParameters.leadingBufferScreenfuls;
    return verticalBuffer;
}

+ (CGRect)expandHorizontally:(CGRect)originalRect
                      buffer:(LNAsyncDirectionalScreenfulBuffer)buffer
{
    CGFloat negativeDirectionWidth = buffer.negativeDirection * originalRect.size.width;
    CGFloat positiveDirectionWidth = buffer.positiveDirection * originalRect.size.width;
    originalRect.size.width = negativeDirectionWidth + originalRect.size.width + positiveDirectionWidth;
    originalRect.origin.x -= negativeDirectionWidth;
    return originalRect;
}

+ (CGRect)expandVertically:(CGRect)originalRect
                    buffer:(LNAsyncDirectionalScreenfulBuffer)buffer
{
    CGFloat negativeDirectionHeight = buffer.negativeDirection * originalRect.size.height;
    CGFloat positiveDirectionHeight = buffer.positiveDirection * originalRect.size.height;
    originalRect.size.height = negativeDirectionHeight + originalRect.size.height + positiveDirectionHeight;
    originalRect.origin.y -= negativeDirectionHeight;
    return originalRect;
}

+ (CGRect)expandToRangeWithOriginalRect:(CGRect)originalRect
                       tuningParameters:(LNAsyncRangeTuningParameters *)tuningParameters
                   scrollableDirections:(LNAsyncScrollDirection)scrollableDirections
                        scrollDirection:(LNAsyncScrollDirection)scrollDirection
{
    if (LNAsyncScrollDirectionContainsHorizontalDirection(scrollableDirections)) {
        LNAsyncDirectionalScreenfulBuffer horizontalBuffer = [self screenfulBufferHorizontal:scrollDirection tuningParameters:tuningParameters];
        originalRect = [self expandHorizontally:originalRect buffer:horizontalBuffer];
    }
    if (LNAsyncScrollDirectionContainsVerticalDirection(scrollableDirections)) {
        LNAsyncDirectionalScreenfulBuffer verticalBuffer = [self screenfulBufferVertical:scrollDirection tuningParameters:tuningParameters];
        originalRect = [self expandVertically:originalRect buffer:verticalBuffer];
    }
    return originalRect;
}


- (void)setTuningParameters:(LNAsyncRangeTuningParameters *)tuningParameters
               forRangeMode:(LNAsyncLayoutRangeMode)rangeMode
                  rangeType:(LNAsyncLayoutRangeType)rangeType
{
    NSAssert(rangeMode >= 0 && rangeMode < LNAsyncLayoutRangeModeCount && rangeType >= 0 && rangeType < LNAsyncLayoutRangeTypeCount, @"LNAsync range error.");
    self.tuningParameters[rangeMode][rangeType] = tuningParameters;
}

- (LNAsyncRangeTuningParameters *)tuningParametersForRangeMode:(LNAsyncLayoutRangeMode)rangeMode
                                                      rangeType:(LNAsyncLayoutRangeType)rangeType
{
    NSAssert(rangeMode >= 0 && rangeMode < LNAsyncLayoutRangeModeCount && rangeType >= 0 && rangeType < LNAsyncLayoutRangeTypeCount, @"LNAsync range error.");
    return self.tuningParameters[rangeMode][rangeType];
}

- (NSArray<NSIndexPath *> *)IndexPathsForScrolling:(LNAsyncScrollDirection)scrollDirection
                                                 rangeMode:(LNAsyncLayoutRangeMode)rangeMode
                                                 rangeType:(LNAsyncLayoutRangeType)rangeType
{
    NSAssert(NO, @"LNAsync range error.");
    return nil;
}


@end
