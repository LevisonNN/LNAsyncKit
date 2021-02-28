//
//  LNAsyncRangeController.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNAsyncAbstractLayoutController.h"
#import "LNAsyncScrollDirectionExtend.h"
#import "LNAsyncInterfaceStatusExtend.h"

NS_ASSUME_NONNULL_BEGIN

@class LNAsyncRangeController;

@interface LNAsyncRange : NSObject

@property (nonatomic, copy) NSArray <NSIndexPath *> *visibleIndexPaths;
@property (nonatomic, copy) NSArray <NSIndexPath *> *displayIndexPaths;
@property (nonatomic, copy) NSArray <NSIndexPath *> *preloadIndexPaths;

@property (nonatomic, copy) NSArray <NSIndexPath *> *allIndexPaths;

@end

@class LNAsyncRangeController;

@protocol LNAsyncRangeDelegate
- (void)rangeController:(LNAsyncRangeController *)rangeController didUpdateRange:(LNAsyncRange *)range;
@end

@protocol LNAsyncRangeDataSource

@required
- (nullable NSArray<NSIndexPath *> *)visibleIndexPathForRangeController:(LNAsyncRangeController *)rangeController;
- (LNAsyncScrollDirection)scrollDirectionForRangeController:(LNAsyncRangeController *)rangeController;
- (LNAsyncInterfaceStatus)interfaceStateForRangeController:(LNAsyncRangeController *)rangeController;

@end

@interface LNAsyncRangeController : NSObject

@property (nonatomic, weak) id <LNAsyncRangeDataSource> dataSource;
@property (nonatomic, weak) id <LNAsyncRangeDelegate> delegate;
@property (nonatomic, strong) id <LNAsyncLayoutController> layoutController;

- (void)setNeedsUpdate;
- (void)updateIfNeeded;

@end

NS_ASSUME_NONNULL_END

