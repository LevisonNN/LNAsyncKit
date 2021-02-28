//
//  LNAsyncScrollDirectionExtend.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncScrollDirectionExtend.h"

LNAsyncScrollDirection const LNAsyncScrollDirectionHorizontalDirections = LNAsyncScrollDirectionLeft | LNAsyncScrollDirectionRight;
LNAsyncScrollDirection const LNAsyncScrollDirectionVerticalDirections = LNAsyncScrollDirectionUp | LNAsyncScrollDirectionDown;

@implementation LNAsyncScrollDirectionExtend

+ (BOOL)containsVerticalDirection:(LNAsyncScrollDirection)scrollDirection
{
    return (scrollDirection & LNAsyncScrollDirectionVerticalDirections) != 0;
}

+ (BOOL)containsHorizontalDirection:(LNAsyncScrollDirection)scrollDirection
{
    return (scrollDirection & LNAsyncScrollDirectionHorizontalDirections) != 0;
}

+ (BOOL)containsRight:(LNAsyncScrollDirection)scrollDirection
{
    return (scrollDirection & LNAsyncScrollDirectionRight) != 0;
}

+ (BOOL)containsLeft:(LNAsyncScrollDirection)scrollDirection
{
    return (scrollDirection & LNAsyncScrollDirectionLeft) != 0;
}

+ (BOOL)containsDown:(LNAsyncScrollDirection)scrollDirection
{
    return (scrollDirection & LNAsyncScrollDirectionDown) != 0;
}

+ (BOOL)containsUp:(LNAsyncScrollDirection)scrollDirection
{
    return (scrollDirection & LNAsyncScrollDirectionUp) != 0;
}

+ (LNAsyncScrollDirection)invertHorizontally:(LNAsyncScrollDirection)scrollDirection
{
    if (scrollDirection == LNAsyncScrollDirectionRight) {
      return LNAsyncScrollDirectionLeft;
    } else if (scrollDirection == LNAsyncScrollDirectionLeft) {
      return LNAsyncScrollDirectionRight;
    }
    return scrollDirection;
}

+ (LNAsyncScrollDirection)invertVertically:(LNAsyncScrollDirection)scrollDirection
{
    if (scrollDirection == LNAsyncScrollDirectionUp) {
      return LNAsyncScrollDirectionDown;
    } else if (scrollDirection == LNAsyncScrollDirectionDown) {
      return LNAsyncScrollDirectionUp;
    }
    return scrollDirection;
}

@end


