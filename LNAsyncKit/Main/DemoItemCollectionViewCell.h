//
//  DemoItemCollectionViewCell.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoItemObject.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kDemoItemCollectionViewCell;

@interface DemoItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) DemoItemObject *obj;

@end


NS_ASSUME_NONNULL_END
