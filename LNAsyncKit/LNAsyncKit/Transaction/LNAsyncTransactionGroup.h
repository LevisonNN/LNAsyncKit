//
//  LNAsyncTransactionGroup.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNAsyncTransaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNAsyncTransactionGroup : NSObject

@property (class, nonatomic, readonly) LNAsyncTransactionGroup *mainTransactionGroup;

- (void)addTransaction:(LNAsyncTransaction *)transaction;

@end

NS_ASSUME_NONNULL_END
