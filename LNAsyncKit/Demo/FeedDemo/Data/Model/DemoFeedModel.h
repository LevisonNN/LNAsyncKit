//
//  DemoFeedModel.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoFeedItemModel.h"
#import <IGListKit.h>
#import "DemoAsyncFeedDisplayProtocol.h"
#import "DemoDefaultFeedDisplayProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface DemoFeedModel : NSObject <IGListDiffable, DemoAsyncFeedDisplayProtocol, DemoDefaultFeedDisplayProtocol>

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSArray <DemoFeedItemModel *> *result;

@end

NS_ASSUME_NONNULL_END

