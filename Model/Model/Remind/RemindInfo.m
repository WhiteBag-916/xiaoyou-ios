//
//  RemindInfo.m
//  Model
//
//  Created by sheng on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RemindInfo.h"

NSString *const kRemindTimeString   = @"remindtime";
NSString *const kHeadImageUrl       = @"imageurl";
NSString *const kRemindTitle        = @"remindtitle";
NSString *const kRemindName         = @"id";

@implementation RemindInfo

+(instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if ((self = [super init]) && ([dict isKindOfClass:[NSDictionary class]])) {
        self.remindTimeString = [self objectOrNilForKey:kRemindTimeString fromDictionary:dict];
        self.headImageUrl = [self objectOrNilForKey:kHeadImageUrl fromDictionary:dict];
        self.remindTitle = [self objectOrNilForKey:kRemindTitle fromDictionary:dict];
        self.remindName = [self objectOrNilForKey:kRemindName fromDictionary:dict];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.remindTimeString forKey:kRemindTimeString];
    [mutableDict setValue:self.headImageUrl forKey:kHeadImageUrl];
    [mutableDict setValue:self.remindTitle forKey:kRemindTitle];
    [mutableDict setValue:self.remindName forKey:kRemindName];
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.remindTimeString = [aDecoder decodeObjectForKey:kRemindTimeString];
        self.headImageUrl = [aDecoder decodeObjectForKey:kHeadImageUrl];
        self.remindTitle = [aDecoder decodeObjectForKey:kRemindTitle];
        self.remindName = [aDecoder decodeObjectForKey:kRemindName];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_remindTimeString forKey:kRemindTimeString];
    [aCoder encodeObject:_headImageUrl forKey:kHeadImageUrl];
    [aCoder encodeObject:_remindTitle forKey:kRemindTitle];
    [aCoder encodeObject:_remindName forKey:kRemindName];
}

- (id)copyWithZone:(NSZone *)zone
{
    RemindInfo *copy = [[RemindInfo alloc]init];
    if (copy) {
        copy.remindTimeString = self.remindTimeString;
        copy.headImageUrl = self.headImageUrl;
        self.remindTitle = self.remindTitle;
        self.remindName = self.remindName;
    }
    return copy;
}
@end