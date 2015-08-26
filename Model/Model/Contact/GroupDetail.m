//
//  GroupDetail.m
//
//  Created by   on 15/8/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GroupDetail.h"
#import "Author.h"
#import "GroupModel.h"


NSString *const kGroupDetailGroupMemebers = @"groupMemebers";
NSString *const kGroupDetailGroupModel = @"groupModel";


@interface GroupDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GroupDetail

@synthesize groupMemebers = _groupMemebers;
@synthesize groupModel = _groupModel;


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
    NSObject *receivedGroupMemebers = [dict objectForKey:kGroupDetailGroupMemebers];
    NSMutableArray *parsedGroupMemebers = [NSMutableArray array];
    if ([receivedGroupMemebers isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedGroupMemebers) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedGroupMemebers addObject:[Author modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedGroupMemebers isKindOfClass:[NSDictionary class]]) {
       [parsedGroupMemebers addObject:[Author modelObjectWithDictionary:(NSDictionary *)receivedGroupMemebers]];
    }

    self.groupMemebers = [NSArray arrayWithArray:parsedGroupMemebers];
            self.groupModel = [GroupModel modelObjectWithDictionary:[dict objectForKey:kGroupDetailGroupModel]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForGroupMemebers = [NSMutableArray array];
    for (NSObject *subArrayObject in self.groupMemebers) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForGroupMemebers addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForGroupMemebers addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGroupMemebers] forKey:kGroupDetailGroupMemebers];
    [mutableDict setValue:[self.groupModel dictionaryRepresentation] forKey:kGroupDetailGroupModel];

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

    self.groupMemebers = [aDecoder decodeObjectForKey:kGroupDetailGroupMemebers];
    self.groupModel = [aDecoder decodeObjectForKey:kGroupDetailGroupModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_groupMemebers forKey:kGroupDetailGroupMemebers];
    [aCoder encodeObject:_groupModel forKey:kGroupDetailGroupModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    GroupDetail *copy = [[GroupDetail alloc] init];
    
    if (copy) {

        copy.groupMemebers = [self.groupMemebers copyWithZone:zone];
        copy.groupModel = [self.groupModel copyWithZone:zone];
    }
    
    return copy;
}


@end
