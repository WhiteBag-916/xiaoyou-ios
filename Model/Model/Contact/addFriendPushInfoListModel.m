//
//  addFriendPushInfoListModel.m
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "addFriendPushInfoListModel.h"


NSString *const kaddFriendPushInfoListModelIdRead = @"idRead";
NSString *const kaddFriendPushInfoListModelContent = @"content";
NSString *const kaddFriendPushInfoListModelIsRemind = @"isRemind";
NSString *const kaddFriendPushInfoListModelId = @"id";
NSString *const kaddFriendPushInfoListModelTime = @"time";
NSString *const kaddFriendPushInfoListModelSendstudentNo = @"sendstudentNo";
NSString *const kaddFriendPushInfoListModelFlag = @"flag";
NSString *const kaddFriendPushInfoListModelRelation = @"relation";
NSString *const kaddFriendPushInfoListModelReciveStudentNo = @"reciveStudentNo";
NSString *const kaddFriendPushInfoListModelIsDel = @"isDel";
NSString *const kaddFriendPushInfoListModelIsSheild = @"isSheild";


@interface addFriendPushInfoListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation addFriendPushInfoListModel

@synthesize idRead = _idRead;
@synthesize content = _content;
@synthesize isRemind = _isRemind;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize time = _time;
@synthesize sendstudentNo = _sendstudentNo;
@synthesize flag = _flag;
@synthesize relation = _relation;
@synthesize reciveStudentNo = _reciveStudentNo;
@synthesize isDel = _isDel;
@synthesize isSheild = _isSheild;


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
            self.idRead = [[self objectOrNilForKey:kaddFriendPushInfoListModelIdRead fromDictionary:dict] doubleValue];
            self.content = [self objectOrNilForKey:kaddFriendPushInfoListModelContent fromDictionary:dict];
            self.isRemind = [self objectOrNilForKey:kaddFriendPushInfoListModelIsRemind fromDictionary:dict];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kaddFriendPushInfoListModelId fromDictionary:dict] doubleValue];
            self.time = [self objectOrNilForKey:kaddFriendPushInfoListModelTime fromDictionary:dict];
            self.sendstudentNo = [self objectOrNilForKey:kaddFriendPushInfoListModelSendstudentNo fromDictionary:dict];
            self.flag = [[self objectOrNilForKey:kaddFriendPushInfoListModelFlag fromDictionary:dict] doubleValue];
            self.relation = [self objectOrNilForKey:kaddFriendPushInfoListModelRelation fromDictionary:dict];
            self.reciveStudentNo = [self objectOrNilForKey:kaddFriendPushInfoListModelReciveStudentNo fromDictionary:dict];
            self.isDel = [self objectOrNilForKey:kaddFriendPushInfoListModelIsDel fromDictionary:dict];
            self.isSheild = [self objectOrNilForKey:kaddFriendPushInfoListModelIsSheild fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.idRead] forKey:kaddFriendPushInfoListModelIdRead];
    [mutableDict setValue:self.content forKey:kaddFriendPushInfoListModelContent];
    [mutableDict setValue:self.isRemind forKey:kaddFriendPushInfoListModelIsRemind];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kaddFriendPushInfoListModelId];
    [mutableDict setValue:self.time forKey:kaddFriendPushInfoListModelTime];
    [mutableDict setValue:self.sendstudentNo forKey:kaddFriendPushInfoListModelSendstudentNo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.flag] forKey:kaddFriendPushInfoListModelFlag];
    [mutableDict setValue:self.relation forKey:kaddFriendPushInfoListModelRelation];
    [mutableDict setValue:self.reciveStudentNo forKey:kaddFriendPushInfoListModelReciveStudentNo];
    [mutableDict setValue:self.isDel forKey:kaddFriendPushInfoListModelIsDel];
    [mutableDict setValue:self.isSheild forKey:kaddFriendPushInfoListModelIsSheild];

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

    self.idRead = [aDecoder decodeDoubleForKey:kaddFriendPushInfoListModelIdRead];
    self.content = [aDecoder decodeObjectForKey:kaddFriendPushInfoListModelContent];
    self.isRemind = [aDecoder decodeObjectForKey:kaddFriendPushInfoListModelIsRemind];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kaddFriendPushInfoListModelId];
    self.time = [aDecoder decodeObjectForKey:kaddFriendPushInfoListModelTime];
    self.sendstudentNo = [aDecoder decodeObjectForKey:kaddFriendPushInfoListModelSendstudentNo];
    self.flag = [aDecoder decodeDoubleForKey:kaddFriendPushInfoListModelFlag];
    self.relation = [aDecoder decodeObjectForKey:kaddFriendPushInfoListModelRelation];
    self.reciveStudentNo = [aDecoder decodeObjectForKey:kaddFriendPushInfoListModelReciveStudentNo];
    self.isDel = [aDecoder decodeObjectForKey:kaddFriendPushInfoListModelIsDel];
    self.isSheild = [aDecoder decodeObjectForKey:kaddFriendPushInfoListModelIsSheild];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_idRead forKey:kaddFriendPushInfoListModelIdRead];
    [aCoder encodeObject:_content forKey:kaddFriendPushInfoListModelContent];
    [aCoder encodeObject:_isRemind forKey:kaddFriendPushInfoListModelIsRemind];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kaddFriendPushInfoListModelId];
    [aCoder encodeObject:_time forKey:kaddFriendPushInfoListModelTime];
    [aCoder encodeObject:_sendstudentNo forKey:kaddFriendPushInfoListModelSendstudentNo];
    [aCoder encodeDouble:_flag forKey:kaddFriendPushInfoListModelFlag];
    [aCoder encodeObject:_relation forKey:kaddFriendPushInfoListModelRelation];
    [aCoder encodeObject:_reciveStudentNo forKey:kaddFriendPushInfoListModelReciveStudentNo];
    [aCoder encodeObject:_isDel forKey:kaddFriendPushInfoListModelIsDel];
    [aCoder encodeObject:_isSheild forKey:kaddFriendPushInfoListModelIsSheild];
}

- (id)copyWithZone:(NSZone *)zone
{
    addFriendPushInfoListModel *copy = [[addFriendPushInfoListModel alloc] init];
    
    if (copy) {

        copy.idRead = self.idRead;
        copy.content = [self.content copyWithZone:zone];
        copy.isRemind = [self.isRemind copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.time = [self.time copyWithZone:zone];
        copy.sendstudentNo = [self.sendstudentNo copyWithZone:zone];
        copy.flag = self.flag;
        copy.relation = [self.relation copyWithZone:zone];
        copy.reciveStudentNo = [self.reciveStudentNo copyWithZone:zone];
        copy.isDel = [self.isDel copyWithZone:zone];
        copy.isSheild = [self.isSheild copyWithZone:zone];
    }
    
    return copy;
}


@end
