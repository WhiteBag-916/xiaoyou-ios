//
//  NSArray+Additions.h
//  YFramework
//
//  Created by liufz on 15/6/26.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Additions)

- (id)objectOfClass:(Class)theClass;
- (id)objectWithTag:(NSInteger)tag;
- (NSArray*)subarrayWithIndexes:(NSIndexSet*)indexes;
- (NSArray*)sortByObjectTag;
- (NSArray*)sortByObjectRestorationId;
- (NSArray*)sortByUIViewOriginX;
- (NSArray*)sortByUIViewOriginY;

@end
