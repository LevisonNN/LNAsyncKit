//
//  LNAsyncElement.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 * Description of a view, but return image instead.
 **/

@interface LNAsyncElement : NSObject

@property (nonatomic, copy) UIColor *backgroundColor;
@property (nonatomic, assign) CGRect frame;

@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, copy) UIColor *borderColor;

- (void)addSubElement:(LNAsyncElement *)element;
- (void)removeSubElement:(LNAsyncElement *)element;

- (NSArray<LNAsyncElement *> *)getSubElements;
- (LNAsyncElement *)getSuperElement;

@property (nonatomic, strong, nullable) UIImage *renderResult;
//private!
- (void)_renderWithContext:(CGContextRef)context;

- (void)_preSetWithContext:(CGContextRef)context;
- (void)_completeWithContext:(CGContextRef)context;

@end

@interface LNAsyncElement (Render)

//Override
- (void)renderSelfWithContext:(CGContextRef)context;

@end

NS_ASSUME_NONNULL_END

