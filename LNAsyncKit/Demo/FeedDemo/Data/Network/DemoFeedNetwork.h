//
//  DemoFeedNetwork.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoFeedModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^DemoFeedNetworkCompletionBlock)(BOOL success, DemoFeedModel *model, NSError *error);

@interface DemoFeedNetwork : NSObject

- (void)loadFeedDataPage:(NSInteger)page completion:(DemoFeedNetworkCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
