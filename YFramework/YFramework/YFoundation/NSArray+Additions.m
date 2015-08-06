//
//  NSArray+Additions.m
//  YFramework
//
//  Created by liufz on 15/6/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "NSArray+Additions.h"

@implementation NSArray (Additions)

- (id)objectOfClass:(Class)theClass
{
    NSUInteger index = [self indexOfObjectPassingTest:^BOOL (id obj, NSUInteger idx, BOOL *stop) {
        return [obj isKindOfClass:theClass];
    }];
    return (index != NSNotFound) ? [self objectAtIndex:index] : nil;
}

- (id)objectWithTag:(NSInteger)tag
{
    for (id obj in self)
    {
        if ([obj tag] == tag)
        {
            return obj;
        }
    }
    return nil;
}

- (NSArray*)subarrayWithIndexes:(NSIndexSet*)indexes
{
    NSMutableArray *targetArray = [NSMutableArray array];
    NSUInteger count = [self count];
    NSUInteger index = [indexes firstIndex];
    
    while (index != NSNotFound)
    {
        if (index < count) [targetArray addObject:[self objectAtIndex:index]];
        index = [indexes indexGreaterThanIndex:index];
    }
    
    return targetArray;
}

- (NSArray*)sortByObjectTag
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id objA, id objB){
        return(
               ([objA tag] < [objB tag]) ? NSOrderedAscending  :
               ([objA tag] > [objB tag]) ? NSOrderedDescending :
               NSOrderedSame);
    }];
}

- (NSArray*)sortByObjectRestorationId
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id objA, id objB){
        return(
               ([[objA restorationIdentifier] intValue] < [[objB restorationIdentifier] intValue]) ? NSOrderedAscending  :
               ([[objA restorationIdentifier] intValue] > [[objB restorationIdentifier] intValue]) ? NSOrderedDescending :
               NSOrderedSame);
    }];
}

- (NSArray*)sortByUIViewOriginX
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id objA, id objB){
        return(
               ([objA frame].origin.x < [objB frame].origin.x) ? NSOrderedAscending  :
               ([objA frame].origin.x > [objB frame].origin.x) ? NSOrderedDescending :
               NSOrderedSame);
    }];
}

- (NSArray*)sortByUIViewOriginY
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id objA, id objB){
        return(
               ([objA frame].origin.y < [objB frame].origin.y) ? NSOrderedAscending  :
               ([objA frame].origin.y > [objB frame].origin.y) ? NSOrderedDescending :
               NSOrderedSame);
    }];
}

@end
