//
//  ResultCommon.m
//
//  Created by   on 15/5/1
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "ResultCommon.h"

NSString *const kResultCommonStatus = @"code";
NSString *const kResultCommonMsg = @"message";

@interface ResultCommon ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ResultCommon

@synthesize code = _code;
@synthesize message = _message;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];

    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]])
    {
        self.code = [[self objectOrNilForKey:kResultCommonStatus fromDictionary:dict] doubleValue];
        self.message = [self objectOrNilForKey:kResultCommonMsg fromDictionary:dict];
    }

    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kResultCommonStatus];
    [mutableDict setValue:self.message forKey:kResultCommonMsg];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.code = [aDecoder decodeDoubleForKey:kResultCommonStatus];
    self.message = [aDecoder decodeObjectForKey:kResultCommonMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_code forKey:kResultCommonStatus];
    [aCoder encodeObject:_message forKey:kResultCommonMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    ResultCommon *copy = [[ResultCommon alloc] init];

    if (copy)
    {
        copy.code = self.code;
        copy.message = [self.message copyWithZone:zone];
    }

    return copy;
}

@end
