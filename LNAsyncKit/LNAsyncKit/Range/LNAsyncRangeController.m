//
//  LNAsyncRangeController.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncRangeController.h"

@implementation LNAsyncRange

@end

@interface LNAsyncRangeController ()
{
    BOOL _needsRangeUpdate;
    id<LNAsyncLayoutController> _layoutController;
    NSSet<NSIndexPath *> *_allPreviousIndexPaths;
    
}

@property (nonatomic, assign) LNAsyncLayoutRangeMode rangeMode;

@end

@implementation LNAsyncRangeController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //TODO:初始不应该是Full
        self.rangeMode = LNAsyncLayoutRangeModeFull;
    }
    return self;
}

- (void)setNeedsUpdate
{
    if (!_needsRangeUpdate) {
      _needsRangeUpdate = YES;
      __weak __typeof__(self) weakSelf = self;
      dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf updateIfNeeded];
      });
    }
}
- (void)updateIfNeeded
{
    if (_needsRangeUpdate) {
      [self updateRanges];
    }
}

- (void)updateRanges
{
    _needsRangeUpdate = NO;
    NSDate *startDate = [NSDate date];
    [self _updateVisibleNodeIndexPaths];
    NSDate *endDate = [NSDate date];
    NSTimeInterval timeDuring = endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970;
    if (timeDuring > 0.0167f) {
        NSLog(@"Warn:LNAsyncKit->updateRange lagggggggggggg.");
    }
}


- (LNAsyncInterfaceStatus)selfInterfaceStatus
{
    LNAsyncInterfaceStatus interfaceStatus = LNAsyncInterfaceStatusNone;
    
    if (_dataSource) {
        interfaceStatus = [_dataSource interfaceStateForRangeController:self];
    }
    
    return interfaceStatus;
}
#pragma -mark setter

- (void)setLayoutController:(id<LNAsyncLayoutController>)layoutController
{
    _layoutController = layoutController;
    if (layoutController && _dataSource) {
      [self updateIfNeeded];
    }
}

#pragma -mark private

- (void)_updateVisibleNodeIndexPaths
{
    if (!self.dataSource) {
        return;
    }
    
    NSArray <NSIndexPath *> *visibleIndexPathsArray = [self.dataSource visibleIndexPathForRangeController:self];
    if (visibleIndexPathsArray.count == 0) {
        return;
    }
    
    LNAsyncLayoutRangeMode rangeMode = self.rangeMode;
    
    NSArray <NSIndexPath *> *displayIndexPathsArray = nil;
    NSArray <NSIndexPath *> *preloadIndexPathsArray = nil;
    
    LNAsyncScrollDirection scrollDirection = [_dataSource scrollDirectionForRangeController:self];
    
    displayIndexPathsArray = [_layoutController IndexPathsForScrolling:scrollDirection rangeMode:rangeMode rangeType:LNAsyncLayoutRangeTypeDisplay];
    preloadIndexPathsArray = [_layoutController IndexPathsForScrolling:scrollDirection rangeMode:rangeMode rangeType:LNAsyncLayoutRangeTypePreload];
    
    NSSet<NSIndexPath *> *visibleIndexPathsSet = [NSSet setWithArray:visibleIndexPathsArray];
    NSSet<NSIndexPath *> *displayIndexPathsSet = [NSSet setWithArray:displayIndexPathsArray];
    NSSet<NSIndexPath *> *preloadIndexPathsSet = [NSSet setWithArray:preloadIndexPathsArray];
    
    NSMutableOrderedSet<NSIndexPath *> *allIndexPaths = [[NSMutableOrderedSet alloc] initWithSet:visibleIndexPathsSet];
    [allIndexPaths unionSet:displayIndexPathsSet];
    [allIndexPaths unionSet:preloadIndexPathsSet];
 
    if (self.delegate) {
        LNAsyncRange *range = [[LNAsyncRange alloc] init];
        range.visibleIndexPaths = visibleIndexPathsSet.allObjects;
        range.displayIndexPaths = displayIndexPathsSet.allObjects;
        range.preloadIndexPaths = preloadIndexPathsSet.allObjects;
        range.allIndexPaths = allIndexPaths.array;
        [self.delegate rangeController:self didUpdateRange:range];
    }
}

@end

