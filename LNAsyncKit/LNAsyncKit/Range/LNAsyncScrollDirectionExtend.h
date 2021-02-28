//
//  LNAsyncScrollDirectionExtend.h
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define LNAsyncScrollDirectionContainsVerticalDirection(scrollDirection) [LNAsyncScrollDirectionExtend containsVerticalDirection:scrollDirection]
#define LNAsyncScrollDirectionContainsHorizontalDirection(scrollDirection) [LNAsyncScrollDirectionExtend containsHorizontalDirection:scrollDirection]
#define LNAsyncScrollDirectionContainsRight(scrollDirection) [LNAsyncScrollDirectionExtend containsRight:scrollDirection]
#define LNAsyncScrollDirectionContainsLeft(scrollDirection) [LNAsyncScrollDirectionExtend containsLeft:scrollDirection]
#define LNAsyncScrollDirectionContainsUp(scrollDirection) [LNAsyncScrollDirectionExtend containsUp:scrollDirection]
#define LNAsyncScrollDirectionContainsDown(scrollDirection) [LNAsyncScrollDirectionExtend containsDown:scrollDirection]
#define LNAsyncScrollDirectionInvertHorizontally(scrollDirection) [LNAsyncScrollDirectionExtend invertHorizontally:scrollDirection]
#define LNAsyncScrollDirectionInvertVertically(scrollDirection) [LNAsyncScrollDirectionExtend invertVertically:scrollDirection]


typedef NS_ENUM (NSInteger, LNAsyncScrollDirection)
{
    LNAsyncScrollDirectionNone  = 0,
    LNAsyncScrollDirectionRight = 1 << 0,
    LNAsyncScrollDirectionLeft  = 1 << 1,
    LNAsyncScrollDirectionUp    = 1 << 2,
    LNAsyncScrollDirectionDown  = 1 << 3
};

extern LNAsyncScrollDirection const LNAsyncScrollDirectionHorizontalDirections;
extern LNAsyncScrollDirection const LNAsyncScrollDirectionVerticalDirections;

@interface LNAsyncScrollDirectionExtend : NSObject

+ (BOOL)containsVerticalDirection:(LNAsyncScrollDirection)scrollDirection;
+ (BOOL)containsHorizontalDirection:(LNAsyncScrollDirection)scrollDirection;
+ (BOOL)containsRight:(LNAsyncScrollDirection)scrollDirection;
+ (BOOL)containsLeft:(LNAsyncScrollDirection)scrollDirection;
+ (BOOL)containsDown:(LNAsyncScrollDirection)scrollDirection;
+ (BOOL)containsUp:(LNAsyncScrollDirection)scrollDirection;

+ (LNAsyncScrollDirection)invertHorizontally:(LNAsyncScrollDirection)scrollDirection;
+ (LNAsyncScrollDirection)invertVertically:(LNAsyncScrollDirection)scrollDirection;

@end


NS_ASSUME_NONNULL_END

