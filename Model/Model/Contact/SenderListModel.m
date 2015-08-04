//
//  SenderListModel.m
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SenderListModel.h"


NSString *const kSenderListModelFlag = @"flag";
NSString *const kSenderListModelBadgeValue = @"badgeValue";
NSString *const kSenderListModelContent = @"content";
NSString *const kSenderListModelTime = @"time";
NSString *const kSenderListModelSendStudentNo = @"sendStudentNo";


@interface SenderListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SenderListModel

@synthesize flag = _flag;
@synthesize badgeValue = _badgeValue;
@synthesize content = _content;
@synthesize time = _time;
@synthesize sendStudentNo = _sendStudentNo;


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
            self.flag = [self objectOrNilForKey:kSenderListModelFlag fromDictionary:dict];
            self.badgeValue = [[self objectOrNilForKey:kSenderListModelBadgeValue fromDictionary:dict] doubleValue];
            self.content = [self objectOrNilForKey:kSenderListModelContent fromDictionary:dict];
            self.time = [self objectOrNilForKey:kSenderListModelTime fromDictionary:dict];
            self.sendStudentNo = [self objectOrNilForKey:kSenderListModelSendStudentNo fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.flag forKey:kSenderListModelFlag];
    [mutableDict setValue:[NSNumber numberWithDouble:self.badgeValue] forKey:kSenderListModelBadgeValue];
    [mutableDict setValue:self.content forKey:kSenderListModelContent];
    [mutableDict setValue:self.time forKey:kSenderListModelTime];
    [mutableDict setValue:self.sendStudentNo forKey:kSenderListModelSendStudentNo];

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

    self.flag = [aDecoder decodeObjectForKey:kSenderListModelFlag];
    self.badgeValue = [aDecoder decodeDoubleForKey:kSenderListModelBadgeValue];
    self.content = [aDecoder decodeObjectForKey:kSenderListModelContent];
    self.time = [aDecoder decodeObjectForKey:kSenderListModelTime];
    self.sendStudentNo = [aDecoder decodeObjectForKey:kSenderListModelSendStudentNo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_flag forKey:kSenderListModelFlag];
    [aCoder encodeDouble:_badgeValue forKey:kSenderListModelBadgeValue];
    [aCoder encodeObject:_content forKey:kSenderListModelContent];
    [aCoder encodeObject:_time forKey:kSenderListModelTime];
    [aCoder encodeObject:_sendStudentNo forKey:kSenderListModelSendStudentNo];
}

- (id)copyWithZone:(NSZone *)zone
{
    SenderListModel *copy = [[SenderListModel alloc] init];
    
    if (copy) {

        copy.flag = [self.flag copyWithZone:zone];
        copy.badgeValue = self.badgeValue;
        copy.content = [self.content copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
        copy.sendStudentNo = [self.sendStudentNo copyWithZone:zone];
    }
    
    return copy;
}


@end
