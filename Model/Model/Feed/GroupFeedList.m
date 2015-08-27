//
//  GroupFeedList.m
//
//  Created by   on 15/8/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GroupFeedList.h"
#import "GroupModel.h"
#import "FeedInfo.h"


NSString *const kGroupFeedListGroupModel = @"groupModel";
NSString *const kGroupFeedListGroupFeeds = @"groupFeeds";


@interface GroupFeedList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GroupFeedList

@synthesize groupModel = _groupModel;
@synthesize groupFeeds = _groupFeeds;


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
            self.groupModel = [GroupModel modelObjectWithDictionary:[dict objectForKey:kGroupFeedListGroupModel]];
    NSObject *receivedGroupFeeds = [dict objectForKey:kGroupFeedListGroupFeeds];
    NSMutableArray *parsedGroupFeeds = [NSMutableArray array];
    if ([receivedGroupFeeds isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedGroupFeeds) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedGroupFeeds addObject:[FeedInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedGroupFeeds isKindOfClass:[NSDictionary class]]) {
       [parsedGroupFeeds addObject:[FeedInfo modelObjectWithDictionary:(NSDictionary *)receivedGroupFeeds]];
    }

    self.groupFeeds = [NSArray arrayWithArray:parsedGroupFeeds];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.groupModel dictionaryRepresentation] forKey:kGroupFeedListGroupModel];
    NSMutableArray *tempArrayForGroupFeeds = [NSMutableArray array];
    for (NSObject *subArrayObject in self.groupFeeds) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForGroupFeeds addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForGroupFeeds addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGroupFeeds] forKey:kGroupFeedListGroupFeeds];

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

    self.groupModel = [aDecoder decodeObjectForKey:kGroupFeedListGroupModel];
    self.groupFeeds = [aDecoder decodeObjectForKey:kGroupFeedListGroupFeeds];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_groupModel forKey:kGroupFeedListGroupModel];
    [aCoder encodeObject:_groupFeeds forKey:kGroupFeedListGroupFeeds];
}

- (id)copyWithZone:(NSZone *)zone
{
    GroupFeedList *copy = [[GroupFeedList alloc] init];
    
    if (copy) {

        copy.groupModel = [self.groupModel copyWithZone:zone];
        copy.groupFeeds = [self.groupFeeds copyWithZone:zone];
    }
    
    return copy;
}


@end
