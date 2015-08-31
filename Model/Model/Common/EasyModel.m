//
//  EasyModel.m
//
//  Created by   on 15/8/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "EasyModel.h"


NSString *const kEasyModelNoticeUrl = @"noticeUrl";
NSString *const kEasyModelTime = @"time";


@interface EasyModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EasyModel

@synthesize noticeUrl = _noticeUrl;
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
            self.noticeUrl = [self objectOrNilForKey:kEasyModelNoticeUrl fromDictionary:dict];
            self.time = [self objectOrNilForKey:kEasyModelTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.noticeUrl forKey:kEasyModelNoticeUrl];
    [mutableDict setValue:self.time forKey:kEasyModelTime];

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

    self.noticeUrl = [aDecoder decodeObjectForKey:kEasyModelNoticeUrl];
    self.time = [aDecoder decodeObjectForKey:kEasyModelTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_noticeUrl forKey:kEasyModelNoticeUrl];
    [aCoder encodeObject:_time forKey:kEasyModelTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    EasyModel *copy = [[EasyModel alloc] init];
    
    if (copy) {

        copy.noticeUrl = [self.noticeUrl copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
    }
    
    return copy;
}


@end
