//
//  Groups.m
//
//  Created by HuiYin  on 15/8/11
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Groups.h"


NSString *const kGroupsGroupId = @"groupId";
NSString *const kGroupsGroupName = @"groupName";


@interface Groups ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Groups

@synthesize groupId = _groupId;
@synthesize groupName = _groupName;


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
            self.groupId = [self objectOrNilForKey:kGroupsGroupId fromDictionary:dict];
            self.groupName = [self objectOrNilForKey:kGroupsGroupName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.groupId forKey:kGroupsGroupId];
    [mutableDict setValue:self.groupName forKey:kGroupsGroupName];

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

    self.groupId = [aDecoder decodeObjectForKey:kGroupsGroupId];
    self.groupName = [aDecoder decodeObjectForKey:kGroupsGroupName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_groupId forKey:kGroupsGroupId];
    [aCoder encodeObject:_groupName forKey:kGroupsGroupName];
}

- (id)copyWithZone:(NSZone *)zone
{
    Groups *copy = [[Groups alloc] init];
    
    if (copy) {

        copy.groupId = [self.groupId copyWithZone:zone];
        copy.groupName = [self.groupName copyWithZone:zone];
    }
    
    return copy;
}


@end
