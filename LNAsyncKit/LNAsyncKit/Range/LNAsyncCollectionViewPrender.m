//
//  LNAsyncCollectionViewPrender.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncCollectionViewPrender.h"
#import "LNAsyncCollectionLayoutController.h"

@interface LNAsyncCollectionViewPrender ()
<
LNAsyncRangeDelegate,
LNAsyncRangeDataSource
>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) LNAsyncCollectionLayoutController *layoutController;

@property (nonatomic, strong) LNAsyncRangeController *rangeController;

@property (nonatomic, assign) LNAsyncScrollDirection scrollDirection;

@end

@implementation LNAsyncCollectionViewPrender

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    self = [super init];
    if (self) {
        _collectionView = collectionView;
        _layoutController = [[LNAsyncCollectionLayoutController alloc] initWithCollectionView:collectionView];
        _rangeController = [[LNAsyncRangeController alloc] init];
        _rangeController.delegate = self;
        _rangeController.dataSource = self;
        _rangeController.layoutController = _layoutController;
    }
    return self;
}

- (void)setNeedsUpdate
{
    [self.rangeController setNeedsUpdate];
}

- (void)startObserveCollectionView
{
    [_collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    [self.rangeController setNeedsUpdate];
}

- (void)stopObserveCollectionView
{
    [_collectionView removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma -mark ACKPreloadRangeDataSource

- (nullable NSArray<NSIndexPath *> *)visibleIndexPathForRangeController:(LNAsyncRangeController *)rangeController
{
    if (rangeController == self.rangeController) {
        return self.collectionView.indexPathsForVisibleItems;
    }
    return nil;
}
- (LNAsyncScrollDirection)scrollDirectionForRangeController:(LNAsyncRangeController *)rangeController
{
    if (rangeController == self.rangeController) {
        return self.scrollDirection;
    }
    return LNAsyncScrollDirectionNone;
}
- (LNAsyncInterfaceStatus)interfaceStateForRangeController:(LNAsyncRangeController *)rangeController
{
    if (rangeController == self.rangeController) {
        return LNAsyncInterfaceStatusVisible;
    }
    return LNAsyncInterfaceStatusNone;
}

#pragma -mark ACKPreloadRangeDelegate

- (void)rangeController:(LNAsyncRangeController *)rangeController didUpdateRange:(LNAsyncRange *)range
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(asyncCollectionViewPrender:didUpdateRange:)]) {
        [self.delegate asyncCollectionViewPrender:self didUpdateRange:range];
    }
}

#pragma -mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"])
    {
        NSValue *oldvalue = change[NSKeyValueChangeOldKey];
        NSValue *newvalue = change[NSKeyValueChangeNewKey];
        CGFloat oldOffset_y = oldvalue.UIOffsetValue.vertical;
        CGFloat newOffset_y = newvalue.UIOffsetValue.vertical;
        CGFloat oldOffset_x = oldvalue.UIOffsetValue.horizontal;
        CGFloat newOffset_x = newvalue.UIOffsetValue.horizontal;
            
        if (newOffset_y > oldOffset_y) {
            _scrollDirection = LNAsyncScrollDirectionDown;
        } else if (newOffset_y < oldOffset_y) {
            _scrollDirection = LNAsyncScrollDirectionUp;
        } else {
            _scrollDirection = LNAsyncScrollDirectionNone;
        }
            
        if (newOffset_x > oldOffset_x) {
            _scrollDirection = _scrollDirection|LNAsyncScrollDirectionRight;
        } else if (newOffset_x < oldOffset_x) {
            _scrollDirection = _scrollDirection|LNAsyncScrollDirectionLeft;
        } else {
            _scrollDirection = _scrollDirection|LNAsyncScrollDirectionNone;
        }
    }
}

@end


