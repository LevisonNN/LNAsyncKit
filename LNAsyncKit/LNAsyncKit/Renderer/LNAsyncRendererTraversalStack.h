//
//  LNAsyncRendererTraversalStack.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNAsyncElement.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNAsyncRendererTraversalStack : NSObject

- (void)pushElement:(LNAsyncElement *)element;
- (void)pushElements:(NSArray <LNAsyncElement *> *)elements;
- (LNAsyncElement *)pop;
- (LNAsyncElement *)top;

- (NSInteger)deepth;
- (BOOL)isEmpty;
- (void)clear;

@end

NS_ASSUME_NONNULL_END

