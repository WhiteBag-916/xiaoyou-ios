//
//  ActivityPublishedModel.m
//
//  Created by   on 15/10/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ActivityPublishedModel.h"


NSString *const kActivityPublishedModelEnrollCheck = @"enrollCheck";
NSString *const kActivityPublishedModelStatus = @"status";
NSString *const kActivityPublishedModelActStartTime = @"actStartTime";
NSString *const kActivityPublishedModelActCreateUserSource = @"actCreateUserSource";
NSString *const kActivityPublishedModelUpdateTime = @"updateTime";
NSString *const kActivityPublishedModelEnroll = @"enroll";
NSString *const kActivityPublishedModelEnrollEndTime = @"enrollEndTime";
NSString *const kActivityPublishedModelActCreateUserId = @"actCreateUserId";
NSString *const kActivityPublishedModelName = @"name";
NSString *const kActivityPublishedModelVersion = @"version";
NSString *const kActivityPublishedModelActivityDirection = @"activityDirection";
NSString *const kActivityPublishedModelActivityId = @"activityId";
NSString *const kActivityPublishedModelCheckOperator = @"checkOperator";
NSString *const kActivityPublishedModelId = @"id";
NSString *const kActivityPublishedModelType = @"type";
NSString *const kActivityPublishedModelActEndTime = @"actEndTime";
NSString *const kActivityPublishedModelCheckType = @"checkType";
NSString *const kActivityPublishedModelPublishType = @"publishType";
NSString *const kActivityPublishedModelOpUser = @"opUser";
NSString *const kActivityPublishedModelEnrollStartTime = @"enrollStartTime";
NSString *const kActivityPublishedModelCheckStatus = @"checkStatus";
NSString *const kActivityPublishedModelCreateTime = @"createTime";
NSString *const kActivityPublishedModelActivityOrganizer = @"activityOrganizer";
NSString *const kActivityPublishedModelAddress = @"address";


@interface ActivityPublishedModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ActivityPublishedModel

@synthesize enrollCheck = _enrollCheck;
@synthesize status = _status;
@synthesize actStartTime = _actStartTime;
@synthesize actCreateUserSource = _actCreateUserSource;
@synthesize updateTime = _updateTime;
@synthesize enroll = _enroll;
@synthesize enrollEndTime = _enrollEndTime;
@synthesize actCreateUserId = _actCreateUserId;
@synthesize name = _name;
@synthesize version = _version;
@synthesize activityDirection = _activityDirection;
@synthesize activityId = _activityId;
@synthesize checkOperator = _checkOperator;
@synthesize activityPublishedModelIdentifier = _activityPublishedModelIdentifier;
@synthesize type = _type;
@synthesize actEndTime = _actEndTime;
@synthesize checkType = _checkType;
@synthesize publishType = _publishType;
@synthesize opUser = _opUser;
@synthesize enrollStartTime = _enrollStartTime;
@synthesize checkStatus = _checkStatus;
@synthesize createTime = _createTime;
@synthesize activityOrganizer = _activityOrganizer;
@synthesize address = _address;


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
            self.enrollCheck = [[self objectOrNilForKey:kActivityPublishedModelEnrollCheck fromDictionary:dict] boolValue];
            self.status = [self objectOrNilForKey:kActivityPublishedModelStatus fromDictionary:dict];
            self.actStartTime = [[self objectOrNilForKey:kActivityPublishedModelActStartTime fromDictionary:dict] doubleValue];
            self.actCreateUserSource = [self objectOrNilForKey:kActivityPublishedModelActCreateUserSource fromDictionary:dict];
            self.updateTime = [[self objectOrNilForKey:kActivityPublishedModelUpdateTime fromDictionary:dict] doubleValue];
            self.enroll = [[self objectOrNilForKey:kActivityPublishedModelEnroll fromDictionary:dict] boolValue];
            self.enrollEndTime = [[self objectOrNilForKey:kActivityPublishedModelEnrollEndTime fromDictionary:dict] doubleValue];
            self.actCreateUserId = [self objectOrNilForKey:kActivityPublishedModelActCreateUserId fromDictionary:dict];
            self.name = [self objectOrNilForKey:kActivityPublishedModelName fromDictionary:dict];
            self.version = [[self objectOrNilForKey:kActivityPublishedModelVersion fromDictionary:dict] doubleValue];
            self.activityDirection = [self objectOrNilForKey:kActivityPublishedModelActivityDirection fromDictionary:dict];
            self.activityId = [[self objectOrNilForKey:kActivityPublishedModelActivityId fromDictionary:dict] doubleValue];
            self.checkOperator = [self objectOrNilForKey:kActivityPublishedModelCheckOperator fromDictionary:dict];
            self.activityPublishedModelIdentifier = [[self objectOrNilForKey:kActivityPublishedModelId fromDictionary:dict] doubleValue];
            self.type = [self objectOrNilForKey:kActivityPublishedModelType fromDictionary:dict];
            self.actEndTime = [[self objectOrNilForKey:kActivityPublishedModelActEndTime fromDictionary:dict] doubleValue];
            self.checkType = [self objectOrNilForKey:kActivityPublishedModelCheckType fromDictionary:dict];
            self.publishType = [self objectOrNilForKey:kActivityPublishedModelPublishType fromDictionary:dict];
            self.opUser = [self objectOrNilForKey:kActivityPublishedModelOpUser fromDictionary:dict];
            self.enrollStartTime = [[self objectOrNilForKey:kActivityPublishedModelEnrollStartTime fromDictionary:dict] doubleValue];
            self.checkStatus = [self objectOrNilForKey:kActivityPublishedModelCheckStatus fromDictionary:dict];
            self.createTime = [[self objectOrNilForKey:kActivityPublishedModelCreateTime fromDictionary:dict] doubleValue];
            self.activityOrganizer = [self objectOrNilForKey:kActivityPublishedModelActivityOrganizer fromDictionary:dict];
            self.address = [self objectOrNilForKey:kActivityPublishedModelAddress fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.enrollCheck] forKey:kActivityPublishedModelEnrollCheck];
    [mutableDict setValue:self.status forKey:kActivityPublishedModelStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.actStartTime] forKey:kActivityPublishedModelActStartTime];
    [mutableDict setValue:self.actCreateUserSource forKey:kActivityPublishedModelActCreateUserSource];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateTime] forKey:kActivityPublishedModelUpdateTime];
    [mutableDict setValue:[NSNumber numberWithBool:self.enroll] forKey:kActivityPublishedModelEnroll];
    [mutableDict setValue:[NSNumber numberWithDouble:self.enrollEndTime] forKey:kActivityPublishedModelEnrollEndTime];
    [mutableDict setValue:self.actCreateUserId forKey:kActivityPublishedModelActCreateUserId];
    [mutableDict setValue:self.name forKey:kActivityPublishedModelName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.version] forKey:kActivityPublishedModelVersion];
    [mutableDict setValue:self.activityDirection forKey:kActivityPublishedModelActivityDirection];
    [mutableDict setValue:[NSNumber numberWithDouble:self.activityId] forKey:kActivityPublishedModelActivityId];
    [mutableDict setValue:self.checkOperator forKey:kActivityPublishedModelCheckOperator];
    [mutableDict setValue:[NSNumber numberWithDouble:self.activityPublishedModelIdentifier] forKey:kActivityPublishedModelId];
    [mutableDict setValue:self.type forKey:kActivityPublishedModelType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.actEndTime] forKey:kActivityPublishedModelActEndTime];
    [mutableDict setValue:self.checkType forKey:kActivityPublishedModelCheckType];
    [mutableDict setValue:self.publishType forKey:kActivityPublishedModelPublishType];
    [mutableDict setValue:self.opUser forKey:kActivityPublishedModelOpUser];
    [mutableDict setValue:[NSNumber numberWithDouble:self.enrollStartTime] forKey:kActivityPublishedModelEnrollStartTime];
    [mutableDict setValue:self.checkStatus forKey:kActivityPublishedModelCheckStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kActivityPublishedModelCreateTime];
    [mutableDict setValue:self.activityOrganizer forKey:kActivityPublishedModelActivityOrganizer];
    [mutableDict setValue:self.address forKey:kActivityPublishedModelAddress];

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

    self.enrollCheck = [aDecoder decodeBoolForKey:kActivityPublishedModelEnrollCheck];
    self.status = [aDecoder decodeObjectForKey:kActivityPublishedModelStatus];
    self.actStartTime = [aDecoder decodeDoubleForKey:kActivityPublishedModelActStartTime];
    self.actCreateUserSource = [aDecoder decodeObjectForKey:kActivityPublishedModelActCreateUserSource];
    self.updateTime = [aDecoder decodeDoubleForKey:kActivityPublishedModelUpdateTime];
    self.enroll = [aDecoder decodeBoolForKey:kActivityPublishedModelEnroll];
    self.enrollEndTime = [aDecoder decodeDoubleForKey:kActivityPublishedModelEnrollEndTime];
    self.actCreateUserId = [aDecoder decodeObjectForKey:kActivityPublishedModelActCreateUserId];
    self.name = [aDecoder decodeObjectForKey:kActivityPublishedModelName];
    self.version = [aDecoder decodeDoubleForKey:kActivityPublishedModelVersion];
    self.activityDirection = [aDecoder decodeObjectForKey:kActivityPublishedModelActivityDirection];
    self.activityId = [aDecoder decodeDoubleForKey:kActivityPublishedModelActivityId];
    self.checkOperator = [aDecoder decodeObjectForKey:kActivityPublishedModelCheckOperator];
    self.activityPublishedModelIdentifier = [aDecoder decodeDoubleForKey:kActivityPublishedModelId];
    self.type = [aDecoder decodeObjectForKey:kActivityPublishedModelType];
    self.actEndTime = [aDecoder decodeDoubleForKey:kActivityPublishedModelActEndTime];
    self.checkType = [aDecoder decodeObjectForKey:kActivityPublishedModelCheckType];
    self.publishType = [aDecoder decodeObjectForKey:kActivityPublishedModelPublishType];
    self.opUser = [aDecoder decodeObjectForKey:kActivityPublishedModelOpUser];
    self.enrollStartTime = [aDecoder decodeDoubleForKey:kActivityPublishedModelEnrollStartTime];
    self.checkStatus = [aDecoder decodeObjectForKey:kActivityPublishedModelCheckStatus];
    self.createTime = [aDecoder decodeDoubleForKey:kActivityPublishedModelCreateTime];
    self.activityOrganizer = [aDecoder decodeObjectForKey:kActivityPublishedModelActivityOrganizer];
    self.address = [aDecoder decodeObjectForKey:kActivityPublishedModelAddress];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_enrollCheck forKey:kActivityPublishedModelEnrollCheck];
    [aCoder encodeObject:_status forKey:kActivityPublishedModelStatus];
    [aCoder encodeDouble:_actStartTime forKey:kActivityPublishedModelActStartTime];
    [aCoder encodeObject:_actCreateUserSource forKey:kActivityPublishedModelActCreateUserSource];
    [aCoder encodeDouble:_updateTime forKey:kActivityPublishedModelUpdateTime];
    [aCoder encodeBool:_enroll forKey:kActivityPublishedModelEnroll];
    [aCoder encodeDouble:_enrollEndTime forKey:kActivityPublishedModelEnrollEndTime];
    [aCoder encodeObject:_actCreateUserId forKey:kActivityPublishedModelActCreateUserId];
    [aCoder encodeObject:_name forKey:kActivityPublishedModelName];
    [aCoder encodeDouble:_version forKey:kActivityPublishedModelVersion];
    [aCoder encodeObject:_activityDirection forKey:kActivityPublishedModelActivityDirection];
    [aCoder encodeDouble:_activityId forKey:kActivityPublishedModelActivityId];
    [aCoder encodeObject:_checkOperator forKey:kActivityPublishedModelCheckOperator];
    [aCoder encodeDouble:_activityPublishedModelIdentifier forKey:kActivityPublishedModelId];
    [aCoder encodeObject:_type forKey:kActivityPublishedModelType];
    [aCoder encodeDouble:_actEndTime forKey:kActivityPublishedModelActEndTime];
    [aCoder encodeObject:_checkType forKey:kActivityPublishedModelCheckType];
    [aCoder encodeObject:_publishType forKey:kActivityPublishedModelPublishType];
    [aCoder encodeObject:_opUser forKey:kActivityPublishedModelOpUser];
    [aCoder encodeDouble:_enrollStartTime forKey:kActivityPublishedModelEnrollStartTime];
    [aCoder encodeObject:_checkStatus forKey:kActivityPublishedModelCheckStatus];
    [aCoder encodeDouble:_createTime forKey:kActivityPublishedModelCreateTime];
    [aCoder encodeObject:_activityOrganizer forKey:kActivityPublishedModelActivityOrganizer];
    [aCoder encodeObject:_address forKey:kActivityPublishedModelAddress];
}

- (id)copyWithZone:(NSZone *)zone
{
    ActivityPublishedModel *copy = [[ActivityPublishedModel alloc] init];
    
    if (copy) {

        copy.enrollCheck = self.enrollCheck;
        copy.status = [self.status copyWithZone:zone];
        copy.actStartTime = self.actStartTime;
        copy.actCreateUserSource = [self.actCreateUserSource copyWithZone:zone];
        copy.updateTime = self.updateTime;
        copy.enroll = self.enroll;
        copy.enrollEndTime = self.enrollEndTime;
        copy.actCreateUserId = [self.actCreateUserId copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.version = self.version;
        copy.activityDirection = [self.activityDirection copyWithZone:zone];
        copy.activityId = self.activityId;
        copy.checkOperator = [self.checkOperator copyWithZone:zone];
        copy.activityPublishedModelIdentifier = self.activityPublishedModelIdentifier;
        copy.type = [self.type copyWithZone:zone];
        copy.actEndTime = self.actEndTime;
        copy.checkType = [self.checkType copyWithZone:zone];
        copy.publishType = [self.publishType copyWithZone:zone];
        copy.opUser = [self.opUser copyWithZone:zone];
        copy.enrollStartTime = self.enrollStartTime;
        copy.checkStatus = [self.checkStatus copyWithZone:zone];
        copy.createTime = self.createTime;
        copy.activityOrganizer = [self.activityOrganizer copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
    }
    
    return copy;
}


@end
