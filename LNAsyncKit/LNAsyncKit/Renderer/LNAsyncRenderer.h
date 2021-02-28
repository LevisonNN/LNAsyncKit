//
//  LNAsyncRenderer.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNAsyncElement.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNAsyncRenderer : NSObject

//DFS
+ (void)traversalElement:(LNAsyncElement *)element;

+ (dispatch_queue_t)globalRenderQueue;

@end

NS_ASSUME_NONNULL_END
