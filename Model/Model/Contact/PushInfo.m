//
//  PushInfo.m
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PushInfo.h"


NSString *const kPushInfoIsRead = @"isRead";
NSString *const kPushInfoContent = @"content";
NSString *const kPushInfoSchoolCode = @"schoolCode";
NSString *const kPushInfoId = @"id";
NSString *const kPushInfoIsShield = @"isShield";
NSString *const kPushInfoTime = @"time";
NSString *const kPushInfoFlag = @"flag";
NSString *const kPushInfoSendStudentNo = @"sendStudentNo";
NSString *const kPushInfoRealtion = @"realtion";
NSString *const kPushInfoReciveStudentNo = @"reciveStudentNo";
NSString *const kPushInfoIsDel = @"isDel";


@interface PushInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PushInfo

@synthesize isRead = _isRead;
@synthesize content = _content;
@synthesize schoolCode = _schoolCode;
@synthesize pushInfoIdentifier = _pushInfoIdentifier;
@synthesize isShield = _isShield;
@synthesize time = _time;
@synthesize flag = _flag;
@synthesize sendStudentNo = _sendStudentNo;
@synthesize realtion = _realtion;
@synthesize reciveStudentNo = _reciveStudentNo;
@synthesize isDel = _isDel;


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
            self.isRead = [self objectOrNilForKey:kPushInfoIsRead fromDictionary:dict];
            self.content = [self objectOrNilForKey:kPushInfoContent fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kPushInfoSchoolCode fromDictionary:dict];
            self.pushInfoIdentifier = [[self objectOrNilForKey:kPushInfoId fromDictionary:dict] doubleValue];
            self.isShield = [self objectOrNilForKey:kPushInfoIsShield fromDictionary:dict];
            self.time = [self objectOrNilForKey:kPushInfoTime fromDictionary:dict];
            self.flag = [self objectOrNilForKey:kPushInfoFlag fromDictionary:dict];
            self.sendStudentNo = [self objectOrNilForKey:kPushInfoSendStudentNo fromDictionary:dict];
            self.realtion = [self objectOrNilForKey:kPushInfoRealtion fromDictionary:dict];
            self.reciveStudentNo = [self objectOrNilForKey:kPushInfoReciveStudentNo fromDictionary:dict];
            self.isDel = [self objectOrNilForKey:kPushInfoIsDel fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.isRead forKey:kPushInfoIsRead];
    [mutableDict setValue:self.content forKey:kPushInfoContent];
    [mutableDict setValue:self.schoolCode forKey:kPushInfoSchoolCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pushInfoIdentifier] forKey:kPushInfoId];
    [mutableDict setValue:self.isShield forKey:kPushInfoIsShield];
    [mutableDict setValue:self.time forKey:kPushInfoTime];
    [mutableDict setValue:self.flag forKey:kPushInfoFlag];
    [mutableDict setValue:self.sendStudentNo forKey:kPushInfoSendStudentNo];
    [mutableDict setValue:self.realtion forKey:kPushInfoRealtion];
    [mutableDict setValue:self.reciveStudentNo forKey:kPushInfoReciveStudentNo];
    [mutableDict setValue:self.isDel forKey:kPushInfoIsDel];

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

    self.isRead = [aDecoder decodeObjectForKey:kPushInfoIsRead];
    self.content = [aDecoder decodeObjectForKey:kPushInfoContent];
    self.schoolCode = [aDecoder decodeObjectForKey:kPushInfoSchoolCode];
    self.pushInfoIdentifier = [aDecoder decodeDoubleForKey:kPushInfoId];
    self.isShield = [aDecoder decodeObjectForKey:kPushInfoIsShield];
    self.time = [aDecoder decodeObjectForKey:kPushInfoTime];
    self.flag = [aDecoder decodeObjectForKey:kPushInfoFlag];
    self.sendStudentNo = [aDecoder decodeObjectForKey:kPushInfoSendStudentNo];
    self.realtion = [aDecoder decodeObjectForKey:kPushInfoRealtion];
    self.reciveStudentNo = [aDecoder decodeObjectForKey:kPushInfoReciveStudentNo];
    self.isDel = [aDecoder decodeObjectForKey:kPushInfoIsDel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_isRead forKey:kPushInfoIsRead];
    [aCoder encodeObject:_content forKey:kPushInfoContent];
    [aCoder encodeObject:_schoolCode forKey:kPushInfoSchoolCode];
    [aCoder encodeDouble:_pushInfoIdentifier forKey:kPushInfoId];
    [aCoder encodeObject:_isShield forKey:kPushInfoIsShield];
    [aCoder encodeObject:_time forKey:kPushInfoTime];
    [aCoder encodeObject:_flag forKey:kPushInfoFlag];
    [aCoder encodeObject:_sendStudentNo forKey:kPushInfoSendStudentNo];
    [aCoder encodeObject:_realtion forKey:kPushInfoRealtion];
    [aCoder encodeObject:_reciveStudentNo forKey:kPushInfoReciveStudentNo];
    [aCoder encodeObject:_isDel forKey:kPushInfoIsDel];
}

- (id)copyWithZone:(NSZone *)zone
{
    PushInfo *copy = [[PushInfo alloc] init];
    
    if (copy) {

        copy.isRead = [self.isRead copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.pushInfoIdentifier = self.pushInfoIdentifier;
        copy.isShield = [self.isShield copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.sendStudentNo = [self.sendStudentNo copyWithZone:zone];
        copy.realtion = [self.realtion copyWithZone:zone];
        copy.reciveStudentNo = [self.reciveStudentNo copyWithZone:zone];
        copy.isDel = [self.isDel copyWithZone:zone];
    }
    
    return copy;
}


@end
