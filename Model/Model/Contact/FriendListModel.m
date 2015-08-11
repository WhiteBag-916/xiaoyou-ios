//
//  FriendListModel.m
//
//  Created by HuiYin  on 15/8/11
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FriendListModel.h"
#import "Tags.h"
#import "Relationship.h"
#import "Groups.h"


NSString *const kFriendListModelUserIcon = @"userIcon";
NSString *const kFriendListModelTags = @"tags";
NSString *const kFriendListModelRelationship = @"relationship";
NSString *const kFriendListModelGroups = @"groups";
NSString *const kFriendListModelUserId = @"userId";
NSString *const kFriendListModelUserName = @"userName";


@interface FriendListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FriendListModel

@synthesize userIcon = _userIcon;
@synthesize tags = _tags;
@synthesize relationship = _relationship;
@synthesize groups = _groups;
@synthesize userId = _userId;
@synthesize userName = _userName;


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
            self.userIcon = [self objectOrNilForKey:kFriendListModelUserIcon fromDictionary:dict];
    NSObject *receivedTags = [dict objectForKey:kFriendListModelTags];
    NSMutableArray *parsedTags = [NSMutableArray array];
    if ([receivedTags isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTags) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTags addObject:[Tags modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTags isKindOfClass:[NSDictionary class]]) {
       [parsedTags addObject:[Tags modelObjectWithDictionary:(NSDictionary *)receivedTags]];
    }

    self.tags = [NSArray arrayWithArray:parsedTags];
    NSObject *receivedRelationship = [dict objectForKey:kFriendListModelRelationship];
    NSMutableArray *parsedRelationship = [NSMutableArray array];
    if ([receivedRelationship isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedRelationship) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedRelationship addObject:[Relationship modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedRelationship isKindOfClass:[NSDictionary class]]) {
       [parsedRelationship addObject:[Relationship modelObjectWithDictionary:(NSDictionary *)receivedRelationship]];
    }

    self.relationship = [NSArray arrayWithArray:parsedRelationship];
    NSObject *receivedGroups = [dict objectForKey:kFriendListModelGroups];
    NSMutableArray *parsedGroups = [NSMutableArray array];
    if ([receivedGroups isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedGroups) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedGroups addObject:[Groups modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedGroups isKindOfClass:[NSDictionary class]]) {
       [parsedGroups addObject:[Groups modelObjectWithDictionary:(NSDictionary *)receivedGroups]];
    }

    self.groups = [NSArray arrayWithArray:parsedGroups];
            self.userId = [self objectOrNilForKey:kFriendListModelUserId fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kFriendListModelUserName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userIcon forKey:kFriendListModelUserIcon];
    NSMutableArray *tempArrayForTags = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tags) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTags addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTags addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTags] forKey:kFriendListModelTags];
    NSMutableArray *tempArrayForRelationship = [NSMutableArray array];
    for (NSObject *subArrayObject in self.relationship) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRelationship addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRelationship addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRelationship] forKey:kFriendListModelRelationship];
    NSMutableArray *tempArrayForGroups = [NSMutableArray array];
    for (NSObject *subArrayObject in self.groups) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForGroups addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForGroups addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGroups] forKey:kFriendListModelGroups];
    [mutableDict setValue:self.userId forKey:kFriendListModelUserId];
    [mutableDict setValue:self.userName forKey:kFriendListModelUserName];

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

    self.userIcon = [aDecoder decodeObjectForKey:kFriendListModelUserIcon];
    self.tags = [aDecoder decodeObjectForKey:kFriendListModelTags];
    self.relationship = [aDecoder decodeObjectForKey:kFriendListModelRelationship];
    self.groups = [aDecoder decodeObjectForKey:kFriendListModelGroups];
    self.userId = [aDecoder decodeObjectForKey:kFriendListModelUserId];
    self.userName = [aDecoder decodeObjectForKey:kFriendListModelUserName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userIcon forKey:kFriendListModelUserIcon];
    [aCoder encodeObject:_tags forKey:kFriendListModelTags];
    [aCoder encodeObject:_relationship forKey:kFriendListModelRelationship];
    [aCoder encodeObject:_groups forKey:kFriendListModelGroups];
    [aCoder encodeObject:_userId forKey:kFriendListModelUserId];
    [aCoder encodeObject:_userName forKey:kFriendListModelUserName];
}

- (id)copyWithZone:(NSZone *)zone
{
    FriendListModel *copy = [[FriendListModel alloc] init];
    
    if (copy) {

        copy.userIcon = [self.userIcon copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
        copy.relationship = [self.relationship copyWithZone:zone];
        copy.groups = [self.groups copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
    }
    
    return copy;
}


@end
