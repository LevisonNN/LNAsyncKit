//
//  DemoItemObject.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger, DemoItemType)
{
    DemoItemFeedDefault,
    DemoItemFeedAsync,
    DemoItemBiliCell,
};

@interface DemoItemObject : NSObject

@property (nonatomic, assign) DemoItemType type;

@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END

