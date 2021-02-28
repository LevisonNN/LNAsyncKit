//
//  DemoDefaultFeedCell.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoDefaultFeedDisplayProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoDefaultFeedCell : UICollectionViewCell

- (void)setModel:(NSObject<DemoDefaultFeedItemDisplayProtocol> *)model;

@end

NS_ASSUME_NONNULL_END
