//
//  YDirectory.m
//  YFramework
//
//  Created by abc on 15/4/18.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YModel.h"
#import "MJExtension.h"

@implementation YModel

+ (id)objectWithObjectClass:(Class) class KeyValues:(NSDictionary *)keyValues
{
    if ([class instancesRespondToSelector:@selector(initWithDictionary:)])
    {
        return [[class alloc] initWithDictionary:keyValues];
    }
    else
    {
        return [class objectWithKeyValues:keyValues];
    }
}

+ (NSArray *) objectsWithObjectClass : (Class) class keyValuesArray : (NSArray *) keyValuesArray
{
    NSArray *objectArray = nil;
    if ([class instancesRespondToSelector:@selector(initWithDictionary:)])
    {
        NSMutableArray *objects = [NSMutableArray array];
        for (NSDictionary *keyValues in keyValuesArray)
        {
            id aObject = [[class alloc] initWithDictionary:keyValues];
            [objects addObject:aObject];
        }
        objectArray = objects;
    }
    else
    {
        objectArray = [class objectArrayWithKeyValuesArray:keyValuesArray];
    }
    return objectArray;
}

+ (instancetype) modelObjectWithJSONData : (NSData *) data
{
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    if ([self instancesRespondToSelector:@selector(initWithDictionary:)])
    {
        return [[self alloc] initWithDictionary:dataDic];
    }
    else
    {
        return [self objectWithKeyValues:dataDic];
    }
}

+ (instancetype)modelObjectWithJSONDataByKey:(NSData *)data key:(NSString *)commonKey
{
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSDictionary *dataDicByKey = [dataDic objectForKey:commonKey];
    if (nil != dataDicByKey)
    {
        if ([self instancesRespondToSelector:@selector(initWithDictionary:)])
        {
            return [[self alloc] initWithDictionary:dataDic];
        }
        else
        {
            return [self objectWithKeyValues:dataDic];
        }
    }
    else
    {
        return [self modelObjectWithJSONData:data];
    }
}

+ (instancetype)modelObjectWithKeyValues:(NSDictionary *)keyValues
{
    if ([self instancesRespondToSelector:@selector(initWithDictionary:)])
    {
        return [[self alloc] initWithDictionary:keyValues];
    }
    else
    {
        return [self objectWithKeyValues:keyValues];
    }
}

+ (NSArray *)modelObjectArrayWithJSONData:(NSData *)data
{
    NSArray *keyValuesArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    if ([self instancesRespondToSelector:@selector(initWithDictionary:)])
    {
        return [self modelObjectArrayWithKeyValuesArray:keyValuesArray];
    }
    else
    {
        return [self objectArrayWithKeyValuesArray:keyValuesArray];
    }
}

+ (NSArray *)modelObjectArrayWithKeyValuesArray:(NSArray *)keyValuesArray
{
    NSArray *objectArray = nil;
    if ([self instancesRespondToSelector:@selector(initWithDictionary:)])
    {
        NSMutableArray *objects = [NSMutableArray array];
        for (NSDictionary *keyValues in keyValuesArray)
        {
            id aObject = [[self alloc] initWithDictionary:keyValues];
            [objects addObject:aObject];
        }
        objectArray = objects;
    }
    else
    {
        objectArray = [self objectArrayWithKeyValuesArray:keyValuesArray];
    }
    return objectArray;
}

- (void)writeToFile:(NSString *)path
{
    if ([self conformsToProtocol:@protocol(NSCoding)]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        [NSKeyedArchiver archiveRootObject:self toFile:path];
    }
}

+ (instancetype) instanceWithFile:(NSString *)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

@end
