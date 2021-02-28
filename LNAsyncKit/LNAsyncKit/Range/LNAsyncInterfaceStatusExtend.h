//
//  LNAsyncInterfaceStatusExtend.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define LNAsyncInterfaceStateIncludesVisible(interfaceStatus) [LNAsyncInterfaceStatusExtend interfaceStateIncludesVisible:interfaceStatus]
#define LNAsyncInterfaceStateIncludesDisplay(interfaceStatus) [LNAsyncInterfaceStatusExtend interfaceStateIncludesDisplay:interfaceStatus]
#define LNAsyncInterfaceStateIncludesPreload(interfaceStatus) [LNAsyncInterfaceStatusExtend interfaceStateIncludesPreload:interfaceStatus]

typedef NS_ENUM (NSInteger, LNAsyncInterfaceStatus)
{
    LNAsyncInterfaceStatusNone = 0,
    LNAsyncInterfaceStatusPreload = 1 << 0,
    LNAsyncInterfaceStatusDisplay = 1 << 1,
    LNAsyncInterfaceStatusVisible = 1 << 2,
};


@interface LNAsyncInterfaceStatusExtend : NSObject

+ (BOOL)interfaceStateIncludesVisible:(LNAsyncInterfaceStatus)interfaceState;
+ (BOOL)interfaceStateIncludesDisplay:(LNAsyncInterfaceStatus)interfaceState;
+ (BOOL)interfaceStateIncludesPreload:(LNAsyncInterfaceStatus)interfaceState;

@end


NS_ASSUME_NONNULL_END

