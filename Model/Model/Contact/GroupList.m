//
//  GroupList.m
//
//  Created by HuiYin  on 15/8/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GroupList.h"


NSString *const kGroupListGroupId = @"groupId";
NSString *const kGroupListGroupName = @"groupName";
NSString *const kGroupListGroupIcon = @"groupIcon";
NSString *const kGroupListGroupType = @"groupType";
NSString *const kGroupListGroupTypeName = @"groupTypeName";
NSString *const kGroupListIsChat = @"isChat";


@interface GroupList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GroupList

@synthesize groupId = _groupId;
@synthesize groupName = _groupName;
@synthesize groupIcon = _groupIcon;
@synthesize groupType = _groupType;
@synthesize groupTypeName = _groupTypeName;
@synthesize isChat = _isChat;


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
            self.groupId = [self objectOrNilForKey:kGroupListGroupId fromDictionary:dict];
            self.groupName = [self objectOrNilForKey:kGroupListGroupName fromDictionary:dict];
            self.groupIcon = [self objectOrNilForKey:kGroupListGroupIcon fromDictionary:dict];
            self.groupType = [self objectOrNilForKey:kGroupListGroupType fromDictionary:dict];
            self.groupTypeName = [self objectOrNilForKey:kGroupListGroupTypeName fromDictionary:dict];
            self.isChat = [[self objectOrNilForKey:kGroupListIsChat fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.groupId forKey:kGroupListGroupId];
    [mutableDict setValue:self.groupName forKey:kGroupListGroupName];
    [mutableDict setValue:self.groupIcon forKey:kGroupListGroupIcon];
    [mutableDict setValue:self.groupType forKey:kGroupListGroupType];
    [mutableDict setValue:self.groupTypeName forKey:kGroupListGroupTypeName];
    [mutableDict setValue:[NSNumber numberWithBool:self.isChat] forKey:kGroupListIsChat];

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

    self.groupId = [aDecoder decodeObjectForKey:kGroupListGroupId];
    self.groupName = [aDecoder decodeObjectForKey:kGroupListGroupName];
    self.groupIcon = [aDecoder decodeObjectForKey:kGroupListGroupIcon];
    self.groupType = [aDecoder decodeObjectForKey:kGroupListGroupType];
    self.groupTypeName = [aDecoder decodeObjectForKey:kGroupListGroupTypeName];
    self.isChat = [aDecoder decodeBoolForKey:kGroupListIsChat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_groupId forKey:kGroupListGroupId];
    [aCoder encodeObject:_groupName forKey:kGroupListGroupName];
    [aCoder encodeObject:_groupIcon forKey:kGroupListGroupIcon];
    [aCoder encodeObject:_groupType forKey:kGroupListGroupType];
    [aCoder encodeObject:_groupTypeName forKey:kGroupListGroupTypeName];
    [aCoder encodeBool:_isChat forKey:kGroupListIsChat];
}

- (id)copyWithZone:(NSZone *)zone
{
    GroupList *copy = [[GroupList alloc] init];
    
    if (copy) {

        copy.groupId = [self.groupId copyWithZone:zone];
        copy.groupName = [self.groupName copyWithZone:zone];
        copy.groupIcon = [self.groupIcon copyWithZone:zone];
        copy.groupType = [self.groupType copyWithZone:zone];
        copy.groupTypeName = [self.groupTypeName copyWithZone:zone];
        copy.isChat = self.isChat;
    }
    
    return copy;
}


@end
