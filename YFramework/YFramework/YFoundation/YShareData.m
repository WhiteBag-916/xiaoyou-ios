//
//  YShareData.m
//  YFramework
//
//  Created by abc on 15/5/1.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YShareData.h"
@interface YShareData()
@property (nonatomic,strong) NSMutableDictionary *shardData;
@end
@implementation YShareData

+(YShareData *) defaultData
{
    static dispatch_once_t once;
    static YShareData *__singleton__;
    dispatch_once(&once, ^{ __singleton__ = [[[self class] alloc] init]; });
    return __singleton__;
}

- (NSMutableDictionary *)shardData
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shardData = [[NSMutableDictionary alloc] init];
    });
    return _shardData;
}

- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (anObject)
    {
        @synchronized([self shardData])
        {
            [[self shardData] setObject:anObject forKey:aKey];
        }
    }
}

- (id)objectForKey:(id)aKey
{
    @synchronized([self shardData])
    {
        return [[self shardData] objectForKey:aKey];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    @synchronized([self shardData])
    {
        [[self shardData] setValue:value forKey:key];
    }
}

- (id)valueForKey:(NSString *)key
{
    @synchronized([self shardData])
    {
        return [[self shardData] valueForKey:key];
    }
}

- (NSDictionary *)dictionaryWithValuesForKeys:(NSArray *)keys
{
    @synchronized([self shardData])
    {
        return [[self shardData] dictionaryWithValuesForKeys:keys];
    }
}

- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues
{
    @synchronized([self shardData])
    {
        [[self shardData] setValuesForKeysWithDictionary:keyedValues];
    }
}

- (void)removeAllObjects
{
    @synchronized([self shardData])
    {
        [[self shardData] removeAllObjects];
    }
}
- (void)removeObjectsForKeys:(NSArray *)keyArray
{
    @synchronized([self shardData])
    {
        [[self shardData] removeObjectsForKeys:keyArray];
    }
}

- (void)removeObjectForKey:(id)aKey
{
    @synchronized([self shardData])
    {
        [[self shardData] removeObjectForKey:aKey];
    }
}

- (id)objectForKeyedSubscript:(id)key
{
    return [self objectForKey:key];
}

- (void)setObject:(id)object forKeyedSubscript:(id)key
{
    [self setObject:object forKey:key];
}

@end
