//
//  UserSchedulingInfo.m
//
//  Created by   on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserSchedulingInfo.h"


NSString *const kUserSchedulingInfoStatus = @"status";
NSString *const kUserSchedulingInfoContent = @"content";
NSString *const kUserSchedulingInfoOpUser = @"opUser";
NSString *const kUserSchedulingInfoId = @"id";
NSString *const kUserSchedulingInfoUid = @"uid";
NSString *const kUserSchedulingInfoEndTime = @"endTime";
NSString *const kUserSchedulingInfoUpdateTime = @"updateTime";
NSString *const kUserSchedulingInfoNoticeTimePeriod = @"noticeTimePeriod";
NSString *const kUserSchedulingInfoStartTime = @"startTime";
NSString *const kUserSchedulingInfoCreateTime = @"createTime";


@interface UserSchedulingInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserSchedulingInfo

@synthesize status = _status;
@synthesize content = _content;
@synthesize opUser = _opUser;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize uid = _uid;
@synthesize endTime = _endTime;
@synthesize updateTime = _updateTime;
@synthesize noticeTimePeriod = _noticeTimePeriod;
@synthesize startTime = _startTime;
@synthesize createTime = _createTime;


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
            self.status = [self objectOrNilForKey:kUserSchedulingInfoStatus fromDictionary:dict];
            self.content = [self objectOrNilForKey:kUserSchedulingInfoContent fromDictionary:dict];
            self.opUser = [self objectOrNilForKey:kUserSchedulingInfoOpUser fromDictionary:dict];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kUserSchedulingInfoId fromDictionary:dict] doubleValue];
            self.uid = [self objectOrNilForKey:kUserSchedulingInfoUid fromDictionary:dict];
            self.endTime = [[self objectOrNilForKey:kUserSchedulingInfoEndTime fromDictionary:dict] doubleValue];
            self.updateTime = [[self objectOrNilForKey:kUserSchedulingInfoUpdateTime fromDictionary:dict] doubleValue];
            self.noticeTimePeriod = [[self objectOrNilForKey:kUserSchedulingInfoNoticeTimePeriod fromDictionary:dict] doubleValue];
            self.startTime = [[self objectOrNilForKey:kUserSchedulingInfoStartTime fromDictionary:dict] doubleValue];
            self.createTime = [[self objectOrNilForKey:kUserSchedulingInfoCreateTime fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kUserSchedulingInfoStatus];
    [mutableDict setValue:self.content forKey:kUserSchedulingInfoContent];
    [mutableDict setValue:self.opUser forKey:kUserSchedulingInfoOpUser];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kUserSchedulingInfoId];
    [mutableDict setValue:self.uid forKey:kUserSchedulingInfoUid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endTime] forKey:kUserSchedulingInfoEndTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateTime] forKey:kUserSchedulingInfoUpdateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.noticeTimePeriod] forKey:kUserSchedulingInfoNoticeTimePeriod];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startTime] forKey:kUserSchedulingInfoStartTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kUserSchedulingInfoCreateTime];

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

    self.status = [aDecoder decodeObjectForKey:kUserSchedulingInfoStatus];
    self.content = [aDecoder decodeObjectForKey:kUserSchedulingInfoContent];
    self.opUser = [aDecoder decodeObjectForKey:kUserSchedulingInfoOpUser];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kUserSchedulingInfoId];
    self.uid = [aDecoder decodeObjectForKey:kUserSchedulingInfoUid];
    self.endTime = [aDecoder decodeDoubleForKey:kUserSchedulingInfoEndTime];
    self.updateTime = [aDecoder decodeDoubleForKey:kUserSchedulingInfoUpdateTime];
    self.noticeTimePeriod = [aDecoder decodeDoubleForKey:kUserSchedulingInfoNoticeTimePeriod];
    self.startTime = [aDecoder decodeDoubleForKey:kUserSchedulingInfoStartTime];
    self.createTime = [aDecoder decodeDoubleForKey:kUserSchedulingInfoCreateTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kUserSchedulingInfoStatus];
    [aCoder encodeObject:_content forKey:kUserSchedulingInfoContent];
    [aCoder encodeObject:_opUser forKey:kUserSchedulingInfoOpUser];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kUserSchedulingInfoId];
    [aCoder encodeObject:_uid forKey:kUserSchedulingInfoUid];
    [aCoder encodeDouble:_endTime forKey:kUserSchedulingInfoEndTime];
    [aCoder encodeDouble:_updateTime forKey:kUserSchedulingInfoUpdateTime];
    [aCoder encodeDouble:_noticeTimePeriod forKey:kUserSchedulingInfoNoticeTimePeriod];
    [aCoder encodeDouble:_startTime forKey:kUserSchedulingInfoStartTime];
    [aCoder encodeDouble:_createTime forKey:kUserSchedulingInfoCreateTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserSchedulingInfo *copy = [[UserSchedulingInfo alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.opUser = [self.opUser copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.uid = [self.uid copyWithZone:zone];
        copy.endTime = self.endTime;
        copy.updateTime = self.updateTime;
        copy.noticeTimePeriod = self.noticeTimePeriod;
        copy.startTime = self.startTime;
        copy.createTime = self.createTime;
    }
    
    return copy;
}


@end
