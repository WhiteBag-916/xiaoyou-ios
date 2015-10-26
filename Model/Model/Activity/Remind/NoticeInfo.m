//
//  Obj.m
//
//  Created by sheng  on 15/10/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NoticeInfo.h"


NSString *const kObjUserId = @"userId";
NSString *const kObjUserHeadPic = @"userHeadPic";
NSString *const kObjEnrollTime = @"enrollTime";
NSString *const kObjUserName = @"userName";
NSString *const kObjActivityOrganizer = @"activityOrganizer";
NSString *const kObjActivityOwner = @"activityOwner";
NSString *const kObjActivityPublishedId = @"activityPublishedId";
NSString *const kObjActivityName = @"activityName";
NSString *const kObjActivityEndTime = @"activityEndTime";
NSString *const kObjCheckStatus = @"checkStatus";
NSString *const kObjActivityStartTime = @"activityStartTime";


@interface NoticeInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NoticeInfo

@synthesize userId = _userId;
@synthesize userHeadPic = _userHeadPic;
@synthesize enrollTime = _enrollTime;
@synthesize userName = _userName;
@synthesize activityOrganizer = _activityOrganizer;
@synthesize activityOwner = _activityOwner;
@synthesize activityPublishedId = _activityPublishedId;
@synthesize activityName = _activityName;
@synthesize activityEndTime = _activityEndTime;
@synthesize checkStatus = _checkStatus;
@synthesize activityStartTime = _activityStartTime;


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
            self.userId = [self objectOrNilForKey:kObjUserId fromDictionary:dict];
            self.userHeadPic = [self objectOrNilForKey:kObjUserHeadPic fromDictionary:dict];
            self.enrollTime = [[self objectOrNilForKey:kObjEnrollTime fromDictionary:dict] doubleValue];
            self.userName = [self objectOrNilForKey:kObjUserName fromDictionary:dict];
            self.activityOrganizer = [self objectOrNilForKey:kObjActivityOrganizer fromDictionary:dict];
            self.activityOwner = [[self objectOrNilForKey:kObjActivityOwner fromDictionary:dict] boolValue];
            self.activityPublishedId = [[self objectOrNilForKey:kObjActivityPublishedId fromDictionary:dict] doubleValue];
            self.activityName = [self objectOrNilForKey:kObjActivityName fromDictionary:dict];
            self.activityEndTime = [[self objectOrNilForKey:kObjActivityEndTime fromDictionary:dict] doubleValue];
            self.checkStatus = [self objectOrNilForKey:kObjCheckStatus fromDictionary:dict];
            self.activityStartTime = [[self objectOrNilForKey:kObjActivityStartTime fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userId forKey:kObjUserId];
    [mutableDict setValue:self.userHeadPic forKey:kObjUserHeadPic];
    [mutableDict setValue:[NSNumber numberWithDouble:self.enrollTime] forKey:kObjEnrollTime];
    [mutableDict setValue:self.userName forKey:kObjUserName];
    [mutableDict setValue:self.activityOrganizer forKey:kObjActivityOrganizer];
    [mutableDict setValue:[NSNumber numberWithBool:self.activityOwner] forKey:kObjActivityOwner];
    [mutableDict setValue:[NSNumber numberWithDouble:self.activityPublishedId] forKey:kObjActivityPublishedId];
    [mutableDict setValue:self.activityName forKey:kObjActivityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.activityEndTime] forKey:kObjActivityEndTime];
    [mutableDict setValue:self.checkStatus forKey:kObjCheckStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.activityStartTime] forKey:kObjActivityStartTime];

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

    self.userId = [aDecoder decodeObjectForKey:kObjUserId];
    self.userHeadPic = [aDecoder decodeObjectForKey:kObjUserHeadPic];
    self.enrollTime = [aDecoder decodeDoubleForKey:kObjEnrollTime];
    self.userName = [aDecoder decodeObjectForKey:kObjUserName];
    self.activityOrganizer = [aDecoder decodeObjectForKey:kObjActivityOrganizer];
    self.activityOwner = [aDecoder decodeBoolForKey:kObjActivityOwner];
    self.activityPublishedId = [aDecoder decodeDoubleForKey:kObjActivityPublishedId];
    self.activityName = [aDecoder decodeObjectForKey:kObjActivityName];
    self.activityEndTime = [aDecoder decodeDoubleForKey:kObjActivityEndTime];
    self.checkStatus = [aDecoder decodeObjectForKey:kObjCheckStatus];
    self.activityStartTime = [aDecoder decodeDoubleForKey:kObjActivityStartTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userId forKey:kObjUserId];
    [aCoder encodeObject:_userHeadPic forKey:kObjUserHeadPic];
    [aCoder encodeDouble:_enrollTime forKey:kObjEnrollTime];
    [aCoder encodeObject:_userName forKey:kObjUserName];
    [aCoder encodeObject:_activityOrganizer forKey:kObjActivityOrganizer];
    [aCoder encodeBool:_activityOwner forKey:kObjActivityOwner];
    [aCoder encodeDouble:_activityPublishedId forKey:kObjActivityPublishedId];
    [aCoder encodeObject:_activityName forKey:kObjActivityName];
    [aCoder encodeDouble:_activityEndTime forKey:kObjActivityEndTime];
    [aCoder encodeObject:_checkStatus forKey:kObjCheckStatus];
    [aCoder encodeDouble:_activityStartTime forKey:kObjActivityStartTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    NoticeInfo *copy = [[NoticeInfo alloc] init];
    
    if (copy) {

        copy.userId = [self.userId copyWithZone:zone];
        copy.userHeadPic = [self.userHeadPic copyWithZone:zone];
        copy.enrollTime = self.enrollTime;
        copy.userName = [self.userName copyWithZone:zone];
        copy.activityOrganizer = [self.activityOrganizer copyWithZone:zone];
        copy.activityOwner = self.activityOwner;
        copy.activityPublishedId = self.activityPublishedId;
        copy.activityName = [self.activityName copyWithZone:zone];
        copy.activityEndTime = self.activityEndTime;
        copy.checkStatus = [self.checkStatus copyWithZone:zone];
        copy.activityStartTime = self.activityStartTime;
    }
    
    return copy;
}


@end
