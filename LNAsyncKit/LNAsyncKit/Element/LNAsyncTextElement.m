//
//  LNAsyncTextElement.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncTextElement.h"

@interface LNAsyncTextElement ()

@end

@implementation LNAsyncTextElement

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textAligment = NSTextAlignmentLeft;
        self.lineBreakMode = NSLineBreakByTruncatingTail;
        self.verticalAlignment = LNAsyncTextElementVerticalAlignmentCenter;
        self.font = [UIFont systemFontOfSize:12.f];
        self.textColor = [UIColor blackColor];
    }
    return self;
}

- (void)renderSelfWithContext:(CGContextRef)context
{
    if (self.text) {
        NSDictionary *attributes = self.attributes;
        if (!attributes) {
            NSMutableDictionary *mAttributes = [NSMutableDictionary dictionaryWithDictionary:self.attributes];
            
            //paragraph
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.lineBreakMode = self.lineBreakMode;
            paragraph.alignment = self.textAligment;
            [mAttributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
            
            //font
            if (self.font) {
                [mAttributes setObject:self.font forKey:NSFontAttributeName];
            }
            
            //color
            if (self.textColor) {
                [mAttributes setObject:self.textColor forKey:NSForegroundColorAttributeName];
            }
            
            //
            
            attributes = [NSDictionary dictionaryWithDictionary:mAttributes];
        }
        

        CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)
                                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           attributes:attributes
                                              context:nil];
        
        CGFloat startY = 0.f;
        CGFloat height = self.frame.size.height;
        if (rect.size.height < self.frame.size.height) {
            height = rect.size.height;
            switch (self.verticalAlignment) {
                case LNAsyncTextElementVerticalAlignmentCenter: {
                    startY = (self.frame.size.height - rect.size.height)/2.f;
                } break;
                case LNAsyncTextElementVerticalAlignmentBottom: {
                    startY = self.frame.size.height - rect.size.height;
                } break;
                default: {

                } break;
            }
        }
        
        [self.text drawWithRect:CGRectMake(0, startY, self.frame.size.width, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    }
}

@end

