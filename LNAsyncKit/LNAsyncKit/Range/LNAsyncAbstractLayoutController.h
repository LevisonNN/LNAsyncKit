//
//  LNAsyncAbstractLayoutController.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LNAsyncScrollDirectionExtend.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger, LNAsyncLayoutRangeType)
{
    LNAsyncLayoutRangeTypeDisplay = 0,
    LNAsyncLayoutRangeTypePreload,
};

static NSInteger const LNAsyncLayoutRangeTypeCount = 2;

typedef NS_ENUM(char, LNAsyncLayoutRangeMode) {
  LNAsyncLayoutRangeModeUnspecified = -1,
  LNAsyncLayoutRangeModeMinimum = 0,
  LNAsyncLayoutRangeModeFull,
  LNAsyncLayoutRangeModeVisibleOnly,
  LNAsyncLayoutRangeModeLowMemory
};

static NSInteger const LNAsyncLayoutRangeModeCount = 4;

typedef struct {
  CGFloat positiveDirection;
  CGFloat negativeDirection;
} LNAsyncDirectionalScreenfulBuffer;


@interface LNAsyncRangeTuningParameters : NSObject

@property (nonatomic, assign) CGFloat leadingBufferScreenfuls;
@property (nonatomic, assign) CGFloat trailingBufferScreenfuls;

+ (instancetype)parametersWithLeadingBuffer:(CGFloat)leadingBuffer
                             trailingBuffer:(CGFloat)trailingBuffer;

@end

@protocol LNAsyncLayoutController

- (void)setTuningParameters:(LNAsyncRangeTuningParameters *)tuningParameters
               forRangeMode:(LNAsyncLayoutRangeMode)rangeMode
                  rangeType:(LNAsyncLayoutRangeType)rangeType;

- (LNAsyncRangeTuningParameters *)tuningParametersForRangeMode:(LNAsyncLayoutRangeMode)rangeMode
                                                      rangeType:(LNAsyncLayoutRangeType)rangeType;


- (NSArray<NSIndexPath *> *)IndexPathsForScrolling:(LNAsyncScrollDirection)scrollDirection
                                         rangeMode:(LNAsyncLayoutRangeMode)rangeMode
                                         rangeType:(LNAsyncLayoutRangeType)rangeType;

@end

@interface LNAsyncAbstractLayoutController : NSObject<LNAsyncLayoutController>

+ (LNAsyncDirectionalScreenfulBuffer)screenfulBufferHorizontal:(LNAsyncScrollDirection)scrollDirection
                                                 tuningParameters:(LNAsyncRangeTuningParameters *)tuningParameters;
+ (LNAsyncDirectionalScreenfulBuffer)screenfulBufferVertical:(LNAsyncScrollDirection)scrollDirection
                                               tuningParameters:(LNAsyncRangeTuningParameters *)tuningParameters;
+ (CGRect)expandHorizontally:(CGRect)originalRect
                      buffer:(LNAsyncDirectionalScreenfulBuffer)buffer;
+ (CGRect)expandVertically:(CGRect)originalRect
                    buffer:(LNAsyncDirectionalScreenfulBuffer)buffer;

+ (CGRect)expandToRangeWithOriginalRect:(CGRect)originalRect
                       tuningParameters:(LNAsyncRangeTuningParameters *)tuningParameters
                   scrollableDirections:(LNAsyncScrollDirection)scrollableDirections
                        scrollDirection:(LNAsyncScrollDirection)scrollDirection;

@end

@interface LNAsyncAbstractLayoutController (Unavailable)

@end

NS_ASSUME_NONNULL_END

