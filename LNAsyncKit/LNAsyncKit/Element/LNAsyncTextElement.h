//
//  LNAsyncTextElement.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncElement.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LNAsyncTextElementVerticalAlignment)
{
    LNAsyncTextElementVerticalAlignmentTop = 0,
    LNAsyncTextElementVerticalAlignmentCenter,
    LNAsyncTextElementVerticalAlignmentBottom
};

@interface LNAsyncTextElement : LNAsyncElement

@property (nonatomic, copy) NSString *text;


@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, assign) NSLineBreakMode lineBreakMode;
@property (nonatomic, assign) LNAsyncTextElementVerticalAlignment verticalAlignment;//default is center
@property (nonatomic, assign) NSTextAlignment textAligment;//default is left

@property (nonatomic, copy) NSDictionary *attributes;

@end


NS_ASSUME_NONNULL_END

