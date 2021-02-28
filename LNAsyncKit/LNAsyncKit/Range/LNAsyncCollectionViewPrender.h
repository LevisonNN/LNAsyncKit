//
//  LNAsyncCollectionViewPrender.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNAsyncRangeController.h"

NS_ASSUME_NONNULL_BEGIN

@class LNAsyncCollectionViewPrender;

@protocol LNAsyncCollectionViewPrenderDelegate <NSObject>

- (void)asyncCollectionViewPrender:(LNAsyncCollectionViewPrender *)prender didUpdateRange:(LNAsyncRange *)range;

@end

@interface LNAsyncCollectionViewPrender : NSObject

@property (nonatomic, weak) NSObject<LNAsyncCollectionViewPrenderDelegate> *delegate;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

- (void)setNeedsUpdate;

- (void)startObserveCollectionView;
- (void)stopObserveCollectionView;

@end

NS_ASSUME_NONNULL_END

