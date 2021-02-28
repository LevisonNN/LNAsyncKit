//
//  DemoAsyncFeedDisplayLayoutObj.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "DemoAsyncFeedDisplayLayoutObj.h"

@implementation DemoAsyncFeedDisplayLayoutObjInput


@end

@interface DemoAsyncFeedDisplayLayoutObj ()

//input
@property (nonatomic, assign) CGFloat hwScale;
@property (nonatomic, copy) NSString *contextString;


//output
@property (nonatomic, assign) CGFloat cellWidth;

@property (nonatomic, assign) CGFloat coverImageWidth;
@property (nonatomic, assign) CGFloat coverImageHeight;

@property (nonatomic, assign) CGFloat gradientY;
@property (nonatomic, assign) CGFloat gradientHeight;

@property (nonatomic, assign) CGFloat dateLabelFont;
@property (nonatomic, assign) CGFloat dateLabelX;
@property (nonatomic, assign) CGFloat dateLabelY;
@property (nonatomic, assign) CGFloat dateLabelWidth;
@property (nonatomic, assign) CGFloat dateLabelHeight;
 

@property (nonatomic, assign) CGFloat contextFont;
@property (nonatomic, assign) CGFloat contextTopPadding;
@property (nonatomic, assign) CGFloat contextLeftRightPadding;
@property (nonatomic, assign) CGFloat contextBottomPadding;
@property (nonatomic, assign) CGFloat contextX;
@property (nonatomic, assign) CGFloat contextY;
@property (nonatomic, assign) CGFloat contextWidth;
@property (nonatomic, assign) CGFloat contextHeight;

@property (nonatomic, assign) CGFloat cellHeight;

@end

@implementation DemoAsyncFeedDisplayLayoutObj

- (instancetype)initWithInput:(DemoAsyncFeedDisplayLayoutObjInput *)input
{
    self = [super init];
    if (self) {
        [self updateWithInput:input];
    }
    return self;
}

- (void)updateWithInput:(DemoAsyncFeedDisplayLayoutObjInput *)input
{
    CGFloat hwScale = input.hwScale;
    NSString *contextString = input.contextString;
    
    self.cellWidth = ([UIScreen mainScreen].bounds.size.width - 12.f * 3)/2.f;
    
    self.coverImageWidth = self.cellWidth;
    self.coverImageHeight = self.coverImageWidth * hwScale;
    
    self.gradientY = self.coverImageHeight - 30.f;
    self.gradientHeight = 30.f;
    
    self.dateLabelX = 6.f;
    self.dateLabelY = self.gradientY + 9.f;
    self.dateLabelFont = 12.f;
    self.dateLabelWidth = self.cellWidth - 6.f * 2.f;
    self.dateLabelHeight = [UIFont systemFontOfSize:self.dateLabelFont].lineHeight;
    
    
    self.contextTopPadding = 4.f;
    self.contextBottomPadding = 4.f;
    self.contextLeftRightPadding = 6.f;
    self.contextFont = 12.f;
    self.contextWidth = self.cellWidth - 6.f * 2.f;
    self.contextX = 6.f;
    self.contextY = self.coverImageHeight + self.contextTopPadding;
    NSMutableDictionary *mAttributes = [[NSMutableDictionary alloc] init];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentLeft;
    [mAttributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    [mAttributes setObject:[UIFont systemFontOfSize:self.contextFont] forKey:NSFontAttributeName];
    CGRect rect = [contextString boundingRectWithSize:CGSizeMake(self.contextWidth, CGFLOAT_MAX)
                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                attributes:[NSDictionary dictionaryWithDictionary:mAttributes]
                                                   context:nil];
    self.contextHeight = ceil(rect.size.height);
    
    self.cellHeight = self.coverImageHeight + self.contextTopPadding + self.contextHeight + self.contextBottomPadding;
    
}

- (CGFloat)outputCellWidth
{
    return self.cellWidth;
}

- (CGFloat)outputCoverImageX
{
    return 0.f;
}

- (CGFloat)outputCoverImageY
{
    return 0.f;
}

- (CGFloat)outputCoverImageWidth
{
    return self.coverImageWidth;
}
- (CGFloat)outputCoverImageHeight
{
    return self.coverImageHeight;
}

- (CGFloat)outputGradientX
{
    return 0.f;
}

- (CGFloat)outputGradientY
{
    return self.gradientY;
}

- (CGFloat)outputGradientHeight
{
    return self.gradientHeight;
}

- (CGFloat)outputGradientWidth
{
    return self.coverImageWidth;
}

- (CGFloat)outputDateTextFont
{
    return self.dateLabelFont;
}

- (CGFloat)outputDateTextX
{
    return self.dateLabelX;
}

- (CGFloat)outputDateTextY
{
    return self.dateLabelY;
}
- (CGFloat)outputDateTextWidth
{
    return self.dateLabelWidth;
}

- (CGFloat)outputDateTextHeight
{
    return self.dateLabelHeight;
}

- (CGFloat)outputContextTextFont
{
    return self.contextFont;
}

- (CGFloat)outputContextX
{
    return self.contextX;
}

- (CGFloat)outputContextY
{
    return self.contextY;
}

- (CGFloat)outputContextWidth
{
    return self.contextWidth;
}

- (CGFloat)outputContextHeight
{
    return self.contextHeight;
}

- (CGFloat)outputCellHeight
{
    return self.cellHeight;
}

@end

