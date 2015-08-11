//
//  GroupListModel.m
//
//  Created by HuiYin  on 15/8/11
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GroupListModel.h"


NSString *const kGroupListModelGroupId = @"groupId";
NSString *const kGroupListModelGroupName = @"groupName";
NSString *const kGroupListModelGroupIcon = @"groupIcon";
NSString *const kGroupListModelGroupType = @"groupType";
NSString *const kGroupListModelGroupTypeName = @"groupTypeName";
NSString *const kGroupListModelIsChat = @"isChat";


@interface GroupListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GroupListModel

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
            self.groupId = [self objectOrNilForKey:kGroupListModelGroupId fromDictionary:dict];
            self.groupName = [self objectOrNilForKey:kGroupListModelGroupName fromDictionary:dict];
            self.groupIcon = [self objectOrNilForKey:kGroupListModelGroupIcon fromDictionary:dict];
            self.groupType = [self objectOrNilForKey:kGroupListModelGroupType fromDictionary:dict];
            self.groupTypeName = [self objectOrNilForKey:kGroupListModelGroupTypeName fromDictionary:dict];
            self.isChat = [[self objectOrNilForKey:kGroupListModelIsChat fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.groupId forKey:kGroupListModelGroupId];
    [mutableDict setValue:self.groupName forKey:kGroupListModelGroupName];
    [mutableDict setValue:self.groupIcon forKey:kGroupListModelGroupIcon];
    [mutableDict setValue:self.groupType forKey:kGroupListModelGroupType];
    [mutableDict setValue:self.groupTypeName forKey:kGroupListModelGroupTypeName];
    [mutableDict setValue:[NSNumber numberWithBool:self.isChat] forKey:kGroupListModelIsChat];

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

    self.groupId = [aDecoder decodeObjectForKey:kGroupListModelGroupId];
    self.groupName = [aDecoder decodeObjectForKey:kGroupListModelGroupName];
    self.groupIcon = [aDecoder decodeObjectForKey:kGroupListModelGroupIcon];
    self.groupType = [aDecoder decodeObjectForKey:kGroupListModelGroupType];
    self.groupTypeName = [aDecoder decodeObjectForKey:kGroupListModelGroupTypeName];
    self.isChat = [aDecoder decodeBoolForKey:kGroupListModelIsChat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_groupId forKey:kGroupListModelGroupId];
    [aCoder encodeObject:_groupName forKey:kGroupListModelGroupName];
    [aCoder encodeObject:_groupIcon forKey:kGroupListModelGroupIcon];
    [aCoder encodeObject:_groupType forKey:kGroupListModelGroupType];
    [aCoder encodeObject:_groupTypeName forKey:kGroupListModelGroupTypeName];
    [aCoder encodeBool:_isChat forKey:kGroupListModelIsChat];
}

- (id)copyWithZone:(NSZone *)zone
{
    GroupListModel *copy = [[GroupListModel alloc] init];
    
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
