//
//  AlertList.m
//
//  Created by   on 15/8/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "AlertList.h"


NSString *const kAlertListIsRead = @"isRead";
NSString *const kAlertListContent = @"content";
NSString *const kAlertListUserId = @"userId";
NSString *const kAlertListId = @"id";
NSString *const kAlertListAffectId = @"affectId";
NSString *const kAlertListCreateTime = @"createTime";
NSString *const kAlertListLastReadTime = @"lastReadTime";
NSString *const kAlertListHedPic = @"hedPic";

@interface AlertList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AlertList

@synthesize isRead = _isRead;
@synthesize content = _content;
@synthesize userId = _userId;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize affectId = _affectId;
@synthesize createTime = _createTime;
@synthesize lastReadTime = _lastReadTime;
@synthesize hedPic = _hedPic;

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
            self.isRead = [[self objectOrNilForKey:kAlertListIsRead fromDictionary:dict] boolValue];
            self.content = [self objectOrNilForKey:kAlertListContent fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kAlertListUserId fromDictionary:dict];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kAlertListId fromDictionary:dict] doubleValue];
            self.affectId = [[self objectOrNilForKey:kAlertListAffectId fromDictionary:dict] doubleValue];
            self.createTime = [[self objectOrNilForKey:kAlertListCreateTime fromDictionary:dict] doubleValue];
            self.lastReadTime = [[self objectOrNilForKey:kAlertListLastReadTime fromDictionary:dict] doubleValue];
        self.hedPic = [self objectOrNilForKey:kAlertListHedPic fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.isRead] forKey:kAlertListIsRead];
    [mutableDict setValue:self.content forKey:kAlertListContent];
    [mutableDict setValue:self.userId forKey:kAlertListUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kAlertListId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.affectId] forKey:kAlertListAffectId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kAlertListCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lastReadTime] forKey:kAlertListLastReadTime];
    [mutableDict setValue:self.hedPic forKey:kAlertListHedPic];

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

    self.isRead = [aDecoder decodeBoolForKey:kAlertListIsRead];
    self.content = [aDecoder decodeObjectForKey:kAlertListContent];
    self.userId = [aDecoder decodeObjectForKey:kAlertListUserId];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kAlertListId];
    self.affectId = [aDecoder decodeDoubleForKey:kAlertListAffectId];
    self.createTime = [aDecoder decodeDoubleForKey:kAlertListCreateTime];
    self.lastReadTime = [aDecoder decodeDoubleForKey:kAlertListLastReadTime];
    self.hedPic = [aDecoder decodeObjectForKey:kAlertListHedPic];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_isRead forKey:kAlertListIsRead];
    [aCoder encodeObject:_content forKey:kAlertListContent];
    [aCoder encodeObject:_userId forKey:kAlertListUserId];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kAlertListId];
    [aCoder encodeDouble:_affectId forKey:kAlertListAffectId];
    [aCoder encodeDouble:_createTime forKey:kAlertListCreateTime];
    [aCoder encodeDouble:_lastReadTime forKey:kAlertListLastReadTime];
    [aCoder encodeObject:_hedPic forKey:kAlertListHedPic];
}

- (id)copyWithZone:(NSZone *)zone
{
    AlertList *copy = [[AlertList alloc] init];
    
    if (copy) {

        copy.isRead = self.isRead;
        copy.content = [self.content copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.affectId = self.affectId;
        copy.createTime = self.createTime;
        copy.lastReadTime = self.lastReadTime;
        copy.hedPic = [self.hedPic copyWithZone:zone];
    }
    
    return copy;
}


@end
