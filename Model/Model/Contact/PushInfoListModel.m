//
//  PushInfoListModel.m
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PushInfoListModel.h"


NSString *const kPushInfoListModelId = @"id";
NSString *const kPushInfoListModelTablename = @"tablename";
NSString *const kPushInfoListModelSchoolCode = @"schoolCode";
NSString *const kPushInfoListModelSendStudentNo = @"sendStudentNo";
NSString *const kPushInfoListModelRealtion = @"realtion";
NSString *const kPushInfoListModelTime = @"time";
NSString *const kPushInfoListModelIsRead = @"isRead";
NSString *const kPushInfoListModelFlag = @"flag";
NSString *const kPushInfoListModelReciveStudentNo = @"reciveStudentNo";
NSString *const kPushInfoListModelIcon = @"icon";
NSString *const kPushInfoListModelReciveIsDel = @"reciveIsDel";
NSString *const kPushInfoListModelIsShield = @"isShield";
NSString *const kPushInfoListModelSendIsDel = @"sendIsDel";
NSString *const kPushInfoListModelContent = @"content";


@interface PushInfoListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PushInfoListModel

@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize tablename = _tablename;
@synthesize schoolCode = _schoolCode;
@synthesize sendStudentNo = _sendStudentNo;
@synthesize realtion = _realtion;
@synthesize time = _time;
@synthesize isRead = _isRead;
@synthesize flag = _flag;
@synthesize reciveStudentNo = _reciveStudentNo;
@synthesize icon = _icon;
@synthesize reciveIsDel = _reciveIsDel;
@synthesize isShield = _isShield;
@synthesize sendIsDel = _sendIsDel;
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
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kPushInfoListModelId fromDictionary:dict] doubleValue];
            self.tablename = [self objectOrNilForKey:kPushInfoListModelTablename fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kPushInfoListModelSchoolCode fromDictionary:dict];
            self.sendStudentNo = [self objectOrNilForKey:kPushInfoListModelSendStudentNo fromDictionary:dict];
            self.realtion = [self objectOrNilForKey:kPushInfoListModelRealtion fromDictionary:dict];
            self.time = [self objectOrNilForKey:kPushInfoListModelTime fromDictionary:dict];
            self.isRead = [self objectOrNilForKey:kPushInfoListModelIsRead fromDictionary:dict];
            self.flag = [self objectOrNilForKey:kPushInfoListModelFlag fromDictionary:dict];
            self.reciveStudentNo = [self objectOrNilForKey:kPushInfoListModelReciveStudentNo fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kPushInfoListModelIcon fromDictionary:dict];
            self.reciveIsDel = [self objectOrNilForKey:kPushInfoListModelReciveIsDel fromDictionary:dict];
            self.isShield = [self objectOrNilForKey:kPushInfoListModelIsShield fromDictionary:dict];
            self.sendIsDel = [self objectOrNilForKey:kPushInfoListModelSendIsDel fromDictionary:dict];
            self.content = [self objectOrNilForKey:kPushInfoListModelContent fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kPushInfoListModelId];
    [mutableDict setValue:self.tablename forKey:kPushInfoListModelTablename];
    [mutableDict setValue:self.schoolCode forKey:kPushInfoListModelSchoolCode];
    [mutableDict setValue:self.sendStudentNo forKey:kPushInfoListModelSendStudentNo];
    [mutableDict setValue:self.realtion forKey:kPushInfoListModelRealtion];
    [mutableDict setValue:self.time forKey:kPushInfoListModelTime];
    [mutableDict setValue:self.isRead forKey:kPushInfoListModelIsRead];
    [mutableDict setValue:self.flag forKey:kPushInfoListModelFlag];
    [mutableDict setValue:self.reciveStudentNo forKey:kPushInfoListModelReciveStudentNo];
    [mutableDict setValue:self.icon forKey:kPushInfoListModelIcon];
    [mutableDict setValue:self.reciveIsDel forKey:kPushInfoListModelReciveIsDel];
    [mutableDict setValue:self.isShield forKey:kPushInfoListModelIsShield];
    [mutableDict setValue:self.sendIsDel forKey:kPushInfoListModelSendIsDel];
    [mutableDict setValue:self.content forKey:kPushInfoListModelContent];

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

    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kPushInfoListModelId];
    self.tablename = [aDecoder decodeObjectForKey:kPushInfoListModelTablename];
    self.schoolCode = [aDecoder decodeObjectForKey:kPushInfoListModelSchoolCode];
    self.sendStudentNo = [aDecoder decodeObjectForKey:kPushInfoListModelSendStudentNo];
    self.realtion = [aDecoder decodeObjectForKey:kPushInfoListModelRealtion];
    self.time = [aDecoder decodeObjectForKey:kPushInfoListModelTime];
    self.isRead = [aDecoder decodeObjectForKey:kPushInfoListModelIsRead];
    self.flag = [aDecoder decodeObjectForKey:kPushInfoListModelFlag];
    self.reciveStudentNo = [aDecoder decodeObjectForKey:kPushInfoListModelReciveStudentNo];
    self.icon = [aDecoder decodeObjectForKey:kPushInfoListModelIcon];
    self.reciveIsDel = [aDecoder decodeObjectForKey:kPushInfoListModelReciveIsDel];
    self.isShield = [aDecoder decodeObjectForKey:kPushInfoListModelIsShield];
    self.sendIsDel = [aDecoder decodeObjectForKey:kPushInfoListModelSendIsDel];
    self.content = [aDecoder decodeObjectForKey:kPushInfoListModelContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kPushInfoListModelId];
    [aCoder encodeObject:_tablename forKey:kPushInfoListModelTablename];
    [aCoder encodeObject:_schoolCode forKey:kPushInfoListModelSchoolCode];
    [aCoder encodeObject:_sendStudentNo forKey:kPushInfoListModelSendStudentNo];
    [aCoder encodeObject:_realtion forKey:kPushInfoListModelRealtion];
    [aCoder encodeObject:_time forKey:kPushInfoListModelTime];
    [aCoder encodeObject:_isRead forKey:kPushInfoListModelIsRead];
    [aCoder encodeObject:_flag forKey:kPushInfoListModelFlag];
    [aCoder encodeObject:_reciveStudentNo forKey:kPushInfoListModelReciveStudentNo];
    [aCoder encodeObject:_icon forKey:kPushInfoListModelIcon];
    [aCoder encodeObject:_reciveIsDel forKey:kPushInfoListModelReciveIsDel];
    [aCoder encodeObject:_isShield forKey:kPushInfoListModelIsShield];
    [aCoder encodeObject:_sendIsDel forKey:kPushInfoListModelSendIsDel];
    [aCoder encodeObject:_content forKey:kPushInfoListModelContent];
}

- (id)copyWithZone:(NSZone *)zone
{
    PushInfoListModel *copy = [[PushInfoListModel alloc] init];
    
    if (copy) {

        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.tablename = [self.tablename copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.sendStudentNo = [self.sendStudentNo copyWithZone:zone];
        copy.realtion = [self.realtion copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
        copy.isRead = [self.isRead copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.reciveStudentNo = [self.reciveStudentNo copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.reciveIsDel = [self.reciveIsDel copyWithZone:zone];
        copy.isShield = [self.isShield copyWithZone:zone];
        copy.sendIsDel = [self.sendIsDel copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
    }
    
    return copy;
}


@end
