//
//  ReceiveAuthCodeModel.m
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ReceiveAuthCodeModel.h"


NSString *const kReceiveAuthCodeModelTime = @"time";


@interface ReceiveAuthCodeModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ReceiveAuthCodeModel

@synthesize time = _time;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.time = [self objectOrNilForKey:kReceiveAuthCodeModelTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.time forKey:kReceiveAuthCodeModelTime];

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

    self.time = [aDecoder decodeObjectForKey:kReceiveAuthCodeModelTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_time forKey:kReceiveAuthCodeModelTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ReceiveAuthCodeModel *copy = [[ReceiveAuthCodeModel alloc] init];
    
    if (copy) {

        copy.time = [self.time copyWithZone:zone];
    }
    
    return copy;
}


@end
