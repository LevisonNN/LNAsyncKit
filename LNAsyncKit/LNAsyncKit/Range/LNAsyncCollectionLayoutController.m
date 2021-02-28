//
//  LNAsyncCollectionLayoutController.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncCollectionLayoutController.h"

@interface LNAsyncCollectionLayoutController ()

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation LNAsyncCollectionLayoutController

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    self = [super init];
    if (self) {
        _collectionView = collectionView;
    }
    return self;
}

- (NSArray<NSIndexPath *> *)IndexPathsForScrolling:(LNAsyncScrollDirection)scrollDirection
                                         rangeMode:(LNAsyncLayoutRangeMode)rangeMode
                                         rangeType:(LNAsyncLayoutRangeType)rangeType
{
    LNAsyncRangeTuningParameters *tuningParameters = [self tuningParametersForRangeMode:rangeMode rangeType:rangeType];
    CGRect rangeBounds = [self rangeBoundsWithScrollDirection:scrollDirection rangeTuningParameters:tuningParameters];
    return [self IndexPathsWithinRangeBounds:rangeBounds];
}

- (NSArray <NSIndexPath *> *)IndexPathsWithinRangeBounds:(CGRect)rangeBounds
{
    NSArray *layoutAttributes = [_collectionView.collectionViewLayout layoutAttributesForElementsInRect:rangeBounds];
    NSMutableArray<NSIndexPath *> *indexPathsMutableArray = [NSMutableArray arrayWithCapacity:layoutAttributes.count];
  
    for (UICollectionViewLayoutAttributes *la in layoutAttributes) {
        if (CATransform3DIsIdentity(la.transform3D) && CGRectIntersectsRect(la.frame, rangeBounds) == NO) {
            continue;
        }
        if (la.indexPath) {
            [indexPathsMutableArray addObject:la.indexPath];
        }
    }
    return [NSArray arrayWithArray:indexPathsMutableArray];
}

- (CGRect)rangeBoundsWithScrollDirection:(LNAsyncScrollDirection)scrollDirection
                   rangeTuningParameters:(LNAsyncRangeTuningParameters *)tuningParameters
{
    CGRect rect = _collectionView.bounds;
    //TODO:这里要想办法拓展一个可以判断上下滑还是左右滑的属性,
    return [[self class] expandToRangeWithOriginalRect:rect tuningParameters:tuningParameters scrollableDirections:LNAsyncScrollDirectionVerticalDirections scrollDirection:scrollDirection];
}

@end


