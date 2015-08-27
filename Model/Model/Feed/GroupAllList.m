//
//  GroupAllList.m
//
//  Created by   on 15/8/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GroupAllList.h"
#import "GroupModel.h"


NSString *const kGroupAllListGroupList = @"groupList";
NSString *const kGroupAllListSearchKey = @"searchKey";


@interface GroupAllList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GroupAllList

@synthesize groupList = _groupList;
@synthesize searchKey = _searchKey;


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
    NSObject *receivedGroupList = [dict objectForKey:kGroupAllListGroupList];
    NSMutableArray *parsedGroupList = [NSMutableArray array];
    if ([receivedGroupList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedGroupList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedGroupList addObject:[GroupModel modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedGroupList isKindOfClass:[NSDictionary class]]) {
       [parsedGroupList addObject:[GroupModel modelObjectWithDictionary:(NSDictionary *)receivedGroupList]];
    }

    self.groupList = [NSArray arrayWithArray:parsedGroupList];
            self.searchKey = [self objectOrNilForKey:kGroupAllListSearchKey fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGroupList] forKey:kGroupAllListGroupList];
    [mutableDict setValue:self.searchKey forKey:kGroupAllListSearchKey];

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

    self.groupList = [aDecoder decodeObjectForKey:kGroupAllListGroupList];
    self.searchKey = [aDecoder decodeObjectForKey:kGroupAllListSearchKey];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_groupList forKey:kGroupAllListGroupList];
    [aCoder encodeObject:_searchKey forKey:kGroupAllListSearchKey];
}

- (id)copyWithZone:(NSZone *)zone
{
    GroupAllList *copy = [[GroupAllList alloc] init];
    
    if (copy) {

        copy.groupList = [self.groupList copyWithZone:zone];
        copy.searchKey = [self.searchKey copyWithZone:zone];
    }
    
    return copy;
}


@end
