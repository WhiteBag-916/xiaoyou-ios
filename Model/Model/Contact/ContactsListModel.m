//
//  ContactsListModel.m
//
//  Created by HuiYin  on 15/8/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ContactsListModel.h"
#import "FriendList.h"
#import "GroupList.h"


NSString *const kContactsListModelCode = @"code";
NSString *const kContactsListModelMessage = @"message";
NSString *const kContactsListModelFriendList = @"friendList";
NSString *const kContactsListModelGroupList = @"groupList";


@interface ContactsListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContactsListModel

@synthesize code = _code;
@synthesize message = _message;
@synthesize friendList = _friendList;
@synthesize groupList = _groupList;


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
            self.code = [self objectOrNilForKey:kContactsListModelCode fromDictionary:dict];
            self.message = [self objectOrNilForKey:kContactsListModelMessage fromDictionary:dict];
    NSObject *receivedFriendList = [dict objectForKey:kContactsListModelFriendList];
    NSMutableArray *parsedFriendList = [NSMutableArray array];
    if ([receivedFriendList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFriendList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFriendList addObject:[FriendList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFriendList isKindOfClass:[NSDictionary class]]) {
       [parsedFriendList addObject:[FriendList modelObjectWithDictionary:(NSDictionary *)receivedFriendList]];
    }

    self.friendList = [NSArray arrayWithArray:parsedFriendList];
    NSObject *receivedGroupList = [dict objectForKey:kContactsListModelGroupList];
    NSMutableArray *parsedGroupList = [NSMutableArray array];
    if ([receivedGroupList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedGroupList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedGroupList addObject:[GroupList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedGroupList isKindOfClass:[NSDictionary class]]) {
       [parsedGroupList addObject:[GroupList modelObjectWithDictionary:(NSDictionary *)receivedGroupList]];
    }

    self.groupList = [NSArray arrayWithArray:parsedGroupList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.code forKey:kContactsListModelCode];
    [mutableDict setValue:self.message forKey:kContactsListModelMessage];
    NSMutableArray *tempArrayForFriendList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.friendList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForFriendList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForFriendList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForFriendList] forKey:kContactsListModelFriendList];
    NSMutableArray *tempArrayForGroupList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.groupList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForGroupList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForGroupList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGroupList] forKey:kContactsListModelGroupList];

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

    self.code = [aDecoder decodeObjectForKey:kContactsListModelCode];
    self.message = [aDecoder decodeObjectForKey:kContactsListModelMessage];
    self.friendList = [aDecoder decodeObjectForKey:kContactsListModelFriendList];
    self.groupList = [aDecoder decodeObjectForKey:kContactsListModelGroupList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_code forKey:kContactsListModelCode];
    [aCoder encodeObject:_message forKey:kContactsListModelMessage];
    [aCoder encodeObject:_friendList forKey:kContactsListModelFriendList];
    [aCoder encodeObject:_groupList forKey:kContactsListModelGroupList];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContactsListModel *copy = [[ContactsListModel alloc] init];
    
    if (copy) {

        copy.code = [self.code copyWithZone:zone];
        copy.message = [self.message copyWithZone:zone];
        copy.friendList = [self.friendList copyWithZone:zone];
        copy.groupList = [self.groupList copyWithZone:zone];
    }
    
    return copy;
}


@end
