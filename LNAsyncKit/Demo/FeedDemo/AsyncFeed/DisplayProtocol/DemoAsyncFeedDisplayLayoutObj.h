//
//  DemoAsyncFeedDisplayLayoutObj.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoAsyncFeedDisplayLayoutObjInput : NSObject

//custom
@property (nonatomic, assign) CGFloat hwScale;
@property (nonatomic, assign) NSString *contextString;

@end

@interface DemoAsyncFeedDisplayLayoutObj : NSObject

// input
- (instancetype)initWithInput:(DemoAsyncFeedDisplayLayoutObjInput *)input;

//output

- (CGFloat)outputCellWidth;

- (CGFloat)outputCoverImageX;
- (CGFloat)outputCoverImageY;
- (CGFloat)outputCoverImageWidth;
- (CGFloat)outputCoverImageHeight;

- (CGFloat)outputGradientX;
- (CGFloat)outputGradientY;
- (CGFloat)outputGradientHeight;
- (CGFloat)outputGradientWidth;

- (CGFloat)outputDateTextFont;
- (CGFloat)outputDateTextX;
- (CGFloat)outputDateTextY;
- (CGFloat)outputDateTextWidth;
- (CGFloat)outputDateTextHeight;

- (CGFloat)outputContextTextFont;
- (CGFloat)outputContextX;
- (CGFloat)outputContextY;
- (CGFloat)outputContextWidth;
- (CGFloat)outputContextHeight;

- (CGFloat)outputCellHeight;

@end

NS_ASSUME_NONNULL_END

