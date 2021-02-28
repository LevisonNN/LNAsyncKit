//
//  LNAsyncRenderCache.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LNAsyncRenderCache : NSObject

+ (instancetype)shareInstance;

- (void)saveRenderImage:(UIImage *)image forKey:(NSString *)key;

- (UIImage *)renderImageForKey:(NSString *)key;

- (void)clear;

@end

NS_ASSUME_NONNULL_END
