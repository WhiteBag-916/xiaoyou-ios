//
//  UserSchedulingInfo.m
//
//  Created by   on 15/11/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserSchedulingInfo.h"


NSString *const kUserSchedulingInfoOpUser = @"opUser";
NSString *const kUserSchedulingInfoId = @"id";
NSString *const kUserSchedulingInfoUpdateTime = @"updateTime";
NSString *const kUserSchedulingInfoUid = @"uid";
NSString *const kUserSchedulingInfoType = @"type";
NSString *const kUserSchedulingInfoAddress = @"address";
NSString *const kUserSchedulingInfoEndTime = @"endTime";
NSString *const kUserSchedulingInfoNoticeTimePeriod = @"noticeTimePeriod";
NSString *const kUserSchedulingInfoCreateTime = @"createTime";
NSString *const kUserSchedulingInfoStartTime = @"startTime";
NSString *const kUserSchedulingInfoStatus = @"status";
NSString *const kUserSchedulingInfoContent = @"content";


@interface UserSchedulingInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserSchedulingInfo

@synthesize opUser = _opUser;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize updateTime = _updateTime;
@synthesize uid = _uid;
@synthesize type = _type;
@synthesize address = _address;
@synthesize endTime = _endTime;
@synthesize noticeTimePeriod = _noticeTimePeriod;
@synthesize createTime = _createTime;
@synthesize startTime = _startTime;
@synthesize status = _status;
@synthesize content = _content;


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
            self.opUser = [self objectOrNilForKey:kUserSchedulingInfoOpUser fromDictionary:dict];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kUserSchedulingInfoId fromDictionary:dict] doubleValue];
            self.updateTime = [[self objectOrNilForKey:kUserSchedulingInfoUpdateTime fromDictionary:dict] doubleValue];
            self.uid = [self objectOrNilForKey:kUserSchedulingInfoUid fromDictionary:dict];
            self.type = [self objectOrNilForKey:kUserSchedulingInfoType fromDictionary:dict];
            self.address = [self objectOrNilForKey:kUserSchedulingInfoAddress fromDictionary:dict];
            self.endTime = [[self objectOrNilForKey:kUserSchedulingInfoEndTime fromDictionary:dict] doubleValue];
            self.noticeTimePeriod = [[self objectOrNilForKey:kUserSchedulingInfoNoticeTimePeriod fromDictionary:dict] doubleValue];
            self.createTime = [[self objectOrNilForKey:kUserSchedulingInfoCreateTime fromDictionary:dict] doubleValue];
            self.startTime = [[self objectOrNilForKey:kUserSchedulingInfoStartTime fromDictionary:dict] doubleValue];
            self.status = [self objectOrNilForKey:kUserSchedulingInfoStatus fromDictionary:dict];
            self.content = [self objectOrNilForKey:kUserSchedulingInfoContent fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.opUser forKey:kUserSchedulingInfoOpUser];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kUserSchedulingInfoId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateTime] forKey:kUserSchedulingInfoUpdateTime];
    [mutableDict setValue:self.uid forKey:kUserSchedulingInfoUid];
    [mutableDict setValue:self.type forKey:kUserSchedulingInfoType];
    [mutableDict setValue:self.address forKey:kUserSchedulingInfoAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endTime] forKey:kUserSchedulingInfoEndTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.noticeTimePeriod] forKey:kUserSchedulingInfoNoticeTimePeriod];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kUserSchedulingInfoCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startTime] forKey:kUserSchedulingInfoStartTime];
    [mutableDict setValue:self.status forKey:kUserSchedulingInfoStatus];
    [mutableDict setValue:self.content forKey:kUserSchedulingInfoContent];

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

    self.opUser = [aDecoder decodeObjectForKey:kUserSchedulingInfoOpUser];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kUserSchedulingInfoId];
    self.updateTime = [aDecoder decodeDoubleForKey:kUserSchedulingInfoUpdateTime];
    self.uid = [aDecoder decodeObjectForKey:kUserSchedulingInfoUid];
    self.type = [aDecoder decodeObjectForKey:kUserSchedulingInfoType];
    self.address = [aDecoder decodeObjectForKey:kUserSchedulingInfoAddress];
    self.endTime = [aDecoder decodeDoubleForKey:kUserSchedulingInfoEndTime];
    self.noticeTimePeriod = [aDecoder decodeDoubleForKey:kUserSchedulingInfoNoticeTimePeriod];
    self.createTime = [aDecoder decodeDoubleForKey:kUserSchedulingInfoCreateTime];
    self.startTime = [aDecoder decodeDoubleForKey:kUserSchedulingInfoStartTime];
    self.status = [aDecoder decodeObjectForKey:kUserSchedulingInfoStatus];
    self.content = [aDecoder decodeObjectForKey:kUserSchedulingInfoContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_opUser forKey:kUserSchedulingInfoOpUser];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kUserSchedulingInfoId];
    [aCoder encodeDouble:_updateTime forKey:kUserSchedulingInfoUpdateTime];
    [aCoder encodeObject:_uid forKey:kUserSchedulingInfoUid];
    [aCoder encodeObject:_type forKey:kUserSchedulingInfoType];
    [aCoder encodeObject:_address forKey:kUserSchedulingInfoAddress];
    [aCoder encodeDouble:_endTime forKey:kUserSchedulingInfoEndTime];
    [aCoder encodeDouble:_noticeTimePeriod forKey:kUserSchedulingInfoNoticeTimePeriod];
    [aCoder encodeDouble:_createTime forKey:kUserSchedulingInfoCreateTime];
    [aCoder encodeDouble:_startTime forKey:kUserSchedulingInfoStartTime];
    [aCoder encodeObject:_status forKey:kUserSchedulingInfoStatus];
    [aCoder encodeObject:_content forKey:kUserSchedulingInfoContent];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserSchedulingInfo *copy = [[UserSchedulingInfo alloc] init];
    
    if (copy) {

        copy.opUser = [self.opUser copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.updateTime = self.updateTime;
        copy.uid = [self.uid copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.endTime = self.endTime;
        copy.noticeTimePeriod = self.noticeTimePeriod;
        copy.createTime = self.createTime;
        copy.startTime = self.startTime;
        copy.status = [self.status copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
    }
    
    return copy;
}


@end
