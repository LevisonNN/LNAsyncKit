//
//  LNAsyncInterfaceStatusExtend.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncInterfaceStatusExtend.h"

@implementation LNAsyncInterfaceStatusExtend

+ (BOOL)interfaceStateIncludesVisible:(LNAsyncInterfaceStatus)interfaceState
{
    return ((interfaceState & LNAsyncInterfaceStatusVisible) == LNAsyncInterfaceStatusVisible);
}

+ (BOOL)interfaceStateIncludesDisplay:(LNAsyncInterfaceStatus)interfaceState
{
    return ((interfaceState & LNAsyncInterfaceStatusDisplay) == LNAsyncInterfaceStatusDisplay);
}

+ (BOOL)interfaceStateIncludesPreload:(LNAsyncInterfaceStatus)interfaceState
{
    return ((interfaceState & LNAsyncInterfaceStatusPreload) == LNAsyncInterfaceStatusPreload);
}

@end

