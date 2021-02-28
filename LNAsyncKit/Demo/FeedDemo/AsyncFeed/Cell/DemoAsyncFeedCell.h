//
//  DemoAsyncFeedCell.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoAsyncFeedDisplayProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoAsyncFeedCell : UICollectionViewCell

- (void)setModel:(NSObject<DemoAsyncFeedItemDisplayProtocol> *)model;

@end

NS_ASSUME_NONNULL_END
