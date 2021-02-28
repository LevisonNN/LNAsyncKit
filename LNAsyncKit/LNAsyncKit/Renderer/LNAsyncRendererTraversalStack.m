//
//  LNAsyncRendererTraversalStack.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//  Copyright © 2021 Levison. All rights reserved.
//

#import "LNAsyncRendererTraversalStack.h"

@interface LNAsyncRendererTraversalStack ()

@property (nonatomic, strong) NSMutableOrderedSet <LNAsyncElement *> *orderedMSet;

@end

@implementation LNAsyncRendererTraversalStack

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)pushElement:(LNAsyncElement *)element
{
    if (element) {
        [self.orderedMSet addObject:element];
    }
}

- (void)pushElements:(NSArray<LNAsyncElement *> *)elements
{
    if (elements) {
        [self.orderedMSet addObjectsFromArray:elements];
    }
}

- (LNAsyncElement *)pop
{
    if (![self isEmpty]) {
        LNAsyncElement *topElement = self.orderedMSet.lastObject;
        [self.orderedMSet removeObject:topElement];
        return topElement;
    }
    return nil;
}

- (LNAsyncElement *)top
{
    return self.orderedMSet.lastObject;
}

- (NSInteger)deepth
{
    return self.orderedMSet.count;
}

- (BOOL)isEmpty
{
    return self.orderedMSet.count <= 0;
}

- (void)clear
{
    [self.orderedMSet removeAllObjects];
}

- (NSMutableOrderedSet<LNAsyncElement *> *)orderedMSet
{
    if (!_orderedMSet) {
        _orderedMSet = [[NSMutableOrderedSet alloc] init];
    }
    return _orderedMSet;
}

@end
