//
//  SystemPushInfoListModel.m
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SystemPushInfoListModel.h"


NSString *const kSystemPushInfoListModelId = @"id";
NSString *const kSystemPushInfoListModelTablename = @"tablename";
NSString *const kSystemPushInfoListModelSchoolCode = @"schoolCode";
NSString *const kSystemPushInfoListModelSendStudentNo = @"sendStudentNo";
NSString *const kSystemPushInfoListModelRealtion = @"realtion";
NSString *const kSystemPushInfoListModelTime = @"time";
NSString *const kSystemPushInfoListModelIsRead = @"isRead";
NSString *const kSystemPushInfoListModelFlag = @"flag";
NSString *const kSystemPushInfoListModelReciveStudentNo = @"reciveStudentNo";
NSString *const kSystemPushInfoListModelIcon = @"icon";
NSString *const kSystemPushInfoListModelReciveIsDel = @"reciveIsDel";
NSString *const kSystemPushInfoListModelIsShield = @"isShield";
NSString *const kSystemPushInfoListModelSendIsDel = @"sendIsDel";
NSString *const kSystemPushInfoListModelContent = @"content";


@interface SystemPushInfoListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SystemPushInfoListModel

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
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kSystemPushInfoListModelId fromDictionary:dict] doubleValue];
            self.tablename = [self objectOrNilForKey:kSystemPushInfoListModelTablename fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kSystemPushInfoListModelSchoolCode fromDictionary:dict];
            self.sendStudentNo = [self objectOrNilForKey:kSystemPushInfoListModelSendStudentNo fromDictionary:dict];
            self.realtion = [self objectOrNilForKey:kSystemPushInfoListModelRealtion fromDictionary:dict];
            self.time = [self objectOrNilForKey:kSystemPushInfoListModelTime fromDictionary:dict];
            self.isRead = [self objectOrNilForKey:kSystemPushInfoListModelIsRead fromDictionary:dict];
            self.flag = [self objectOrNilForKey:kSystemPushInfoListModelFlag fromDictionary:dict];
            self.reciveStudentNo = [self objectOrNilForKey:kSystemPushInfoListModelReciveStudentNo fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kSystemPushInfoListModelIcon fromDictionary:dict];
            self.reciveIsDel = [self objectOrNilForKey:kSystemPushInfoListModelReciveIsDel fromDictionary:dict];
            self.isShield = [self objectOrNilForKey:kSystemPushInfoListModelIsShield fromDictionary:dict];
            self.sendIsDel = [self objectOrNilForKey:kSystemPushInfoListModelSendIsDel fromDictionary:dict];
            self.content = [self objectOrNilForKey:kSystemPushInfoListModelContent fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kSystemPushInfoListModelId];
    [mutableDict setValue:self.tablename forKey:kSystemPushInfoListModelTablename];
    [mutableDict setValue:self.schoolCode forKey:kSystemPushInfoListModelSchoolCode];
    [mutableDict setValue:self.sendStudentNo forKey:kSystemPushInfoListModelSendStudentNo];
    [mutableDict setValue:self.realtion forKey:kSystemPushInfoListModelRealtion];
    [mutableDict setValue:self.time forKey:kSystemPushInfoListModelTime];
    [mutableDict setValue:self.isRead forKey:kSystemPushInfoListModelIsRead];
    [mutableDict setValue:self.flag forKey:kSystemPushInfoListModelFlag];
    [mutableDict setValue:self.reciveStudentNo forKey:kSystemPushInfoListModelReciveStudentNo];
    [mutableDict setValue:self.icon forKey:kSystemPushInfoListModelIcon];
    [mutableDict setValue:self.reciveIsDel forKey:kSystemPushInfoListModelReciveIsDel];
    [mutableDict setValue:self.isShield forKey:kSystemPushInfoListModelIsShield];
    [mutableDict setValue:self.sendIsDel forKey:kSystemPushInfoListModelSendIsDel];
    [mutableDict setValue:self.content forKey:kSystemPushInfoListModelContent];

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

    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kSystemPushInfoListModelId];
    self.tablename = [aDecoder decodeObjectForKey:kSystemPushInfoListModelTablename];
    self.schoolCode = [aDecoder decodeObjectForKey:kSystemPushInfoListModelSchoolCode];
    self.sendStudentNo = [aDecoder decodeObjectForKey:kSystemPushInfoListModelSendStudentNo];
    self.realtion = [aDecoder decodeObjectForKey:kSystemPushInfoListModelRealtion];
    self.time = [aDecoder decodeObjectForKey:kSystemPushInfoListModelTime];
    self.isRead = [aDecoder decodeObjectForKey:kSystemPushInfoListModelIsRead];
    self.flag = [aDecoder decodeObjectForKey:kSystemPushInfoListModelFlag];
    self.reciveStudentNo = [aDecoder decodeObjectForKey:kSystemPushInfoListModelReciveStudentNo];
    self.icon = [aDecoder decodeObjectForKey:kSystemPushInfoListModelIcon];
    self.reciveIsDel = [aDecoder decodeObjectForKey:kSystemPushInfoListModelReciveIsDel];
    self.isShield = [aDecoder decodeObjectForKey:kSystemPushInfoListModelIsShield];
    self.sendIsDel = [aDecoder decodeObjectForKey:kSystemPushInfoListModelSendIsDel];
    self.content = [aDecoder decodeObjectForKey:kSystemPushInfoListModelContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kSystemPushInfoListModelId];
    [aCoder encodeObject:_tablename forKey:kSystemPushInfoListModelTablename];
    [aCoder encodeObject:_schoolCode forKey:kSystemPushInfoListModelSchoolCode];
    [aCoder encodeObject:_sendStudentNo forKey:kSystemPushInfoListModelSendStudentNo];
    [aCoder encodeObject:_realtion forKey:kSystemPushInfoListModelRealtion];
    [aCoder encodeObject:_time forKey:kSystemPushInfoListModelTime];
    [aCoder encodeObject:_isRead forKey:kSystemPushInfoListModelIsRead];
    [aCoder encodeObject:_flag forKey:kSystemPushInfoListModelFlag];
    [aCoder encodeObject:_reciveStudentNo forKey:kSystemPushInfoListModelReciveStudentNo];
    [aCoder encodeObject:_icon forKey:kSystemPushInfoListModelIcon];
    [aCoder encodeObject:_reciveIsDel forKey:kSystemPushInfoListModelReciveIsDel];
    [aCoder encodeObject:_isShield forKey:kSystemPushInfoListModelIsShield];
    [aCoder encodeObject:_sendIsDel forKey:kSystemPushInfoListModelSendIsDel];
    [aCoder encodeObject:_content forKey:kSystemPushInfoListModelContent];
}

- (id)copyWithZone:(NSZone *)zone
{
    SystemPushInfoListModel *copy = [[SystemPushInfoListModel alloc] init];
    
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
