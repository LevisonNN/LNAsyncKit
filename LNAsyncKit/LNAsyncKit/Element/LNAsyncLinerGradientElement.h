//
//  LNAsyncLinerGradientElement.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncElement.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger ,LNAsyncLinerGradientElementDirection)
{
    LNAsyncLinerGradientElementVertical,
    LNAsyncLinerGradientElementHorizontal
};

@interface LNAsyncLinerGradientElement : LNAsyncElement

@property (nonatomic, assign) LNAsyncLinerGradientElementDirection direction;

@property (nonatomic, copy) NSArray<UIColor *> *gradientColorArray;

@property (nonatomic, copy) NSArray<NSNumber *> *gradientPercentPoints;

@end

NS_ASSUME_NONNULL_END

