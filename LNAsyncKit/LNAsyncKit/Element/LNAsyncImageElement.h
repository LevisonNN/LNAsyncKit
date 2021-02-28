//
//  LNAsyncImageElement.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncElement.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger, LNAsyncImageFillMode)
{
    LNAsyncImageScaleToFill,
    LNAsyncImageScaleAspectFit,
    LNAsyncImageScaleAspactFill,
};

@interface LNAsyncImageElement : LNAsyncElement

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) LNAsyncImageFillMode fillMode;

@end

NS_ASSUME_NONNULL_END

