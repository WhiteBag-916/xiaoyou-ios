//
//  GroupModel.m
//
//  Created by   on 15/8/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GroupModel.h"


NSString *const kGroupModelId = @"id";
NSString *const kGroupModelCategory = @"category";
NSString *const kGroupModelSchoolCode = @"schoolCode";
NSString *const kGroupModelDescription = @"description";
NSString *const kGroupModelStar = @"star";
NSString *const kGroupModelGroupIcon = @"groupIcon";
NSString *const kGroupModelHot = @"hot";
NSString *const kGroupModelKeyWords = @"keyWords";
NSString *const kGroupModelSchoolName = @"schoolName";
NSString *const kGroupModelGroupName = @"groupName";
NSString *const kGroupModelThirdId = @"thirdId";
NSString *const kGroupModelCacheVersion = @"cacheVersion";


@interface GroupModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GroupModel

@synthesize groupModelIdentifier = _groupModelIdentifier;
@synthesize category = _category;
@synthesize schoolCode = _schoolCode;
@synthesize groupModelDescription = _groupModelDescription;
@synthesize star = _star;
@synthesize groupIcon = _groupIcon;
@synthesize hot = _hot;
@synthesize keyWords = _keyWords;
@synthesize schoolName = _schoolName;
@synthesize groupName = _groupName;
@synthesize thirdId = _thirdId;
@synthesize cacheVersion = _cacheVersion;


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
            self.groupModelIdentifier = [[self objectOrNilForKey:kGroupModelId fromDictionary:dict] doubleValue];
            self.category = [self objectOrNilForKey:kGroupModelCategory fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kGroupModelSchoolCode fromDictionary:dict];
            self.groupModelDescription = [self objectOrNilForKey:kGroupModelDescription fromDictionary:dict];
            self.star = [self objectOrNilForKey:kGroupModelStar fromDictionary:dict];
            self.groupIcon = [self objectOrNilForKey:kGroupModelGroupIcon fromDictionary:dict];
            self.hot = [self objectOrNilForKey:kGroupModelHot fromDictionary:dict];
            self.keyWords = [self objectOrNilForKey:kGroupModelKeyWords fromDictionary:dict];
            self.schoolName = [self objectOrNilForKey:kGroupModelSchoolName fromDictionary:dict];
            self.groupName = [self objectOrNilForKey:kGroupModelGroupName fromDictionary:dict];
            self.thirdId = [self objectOrNilForKey:kGroupModelThirdId fromDictionary:dict];
            self.cacheVersion = [self objectOrNilForKey:kGroupModelCacheVersion fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.groupModelIdentifier] forKey:kGroupModelId];
    [mutableDict setValue:self.category forKey:kGroupModelCategory];
    [mutableDict setValue:self.schoolCode forKey:kGroupModelSchoolCode];
    [mutableDict setValue:self.groupModelDescription forKey:kGroupModelDescription];
    [mutableDict setValue:self.star forKey:kGroupModelStar];
    [mutableDict setValue:self.groupIcon forKey:kGroupModelGroupIcon];
    [mutableDict setValue:self.hot forKey:kGroupModelHot];
    [mutableDict setValue:self.keyWords forKey:kGroupModelKeyWords];
    [mutableDict setValue:self.schoolName forKey:kGroupModelSchoolName];
    [mutableDict setValue:self.groupName forKey:kGroupModelGroupName];
    [mutableDict setValue:self.thirdId forKey:kGroupModelThirdId];
    [mutableDict setValue:self.cacheVersion forKey:kGroupModelCacheVersion];

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

    self.groupModelIdentifier = [aDecoder decodeDoubleForKey:kGroupModelId];
    self.category = [aDecoder decodeObjectForKey:kGroupModelCategory];
    self.schoolCode = [aDecoder decodeObjectForKey:kGroupModelSchoolCode];
    self.groupModelDescription = [aDecoder decodeObjectForKey:kGroupModelDescription];
    self.star = [aDecoder decodeObjectForKey:kGroupModelStar];
    self.groupIcon = [aDecoder decodeObjectForKey:kGroupModelGroupIcon];
    self.hot = [aDecoder decodeObjectForKey:kGroupModelHot];
    self.keyWords = [aDecoder decodeObjectForKey:kGroupModelKeyWords];
    self.schoolName = [aDecoder decodeObjectForKey:kGroupModelSchoolName];
    self.groupName = [aDecoder decodeObjectForKey:kGroupModelGroupName];
    self.thirdId = [aDecoder decodeObjectForKey:kGroupModelThirdId];
    self.cacheVersion = [aDecoder decodeObjectForKey:kGroupModelCacheVersion];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_groupModelIdentifier forKey:kGroupModelId];
    [aCoder encodeObject:_category forKey:kGroupModelCategory];
    [aCoder encodeObject:_schoolCode forKey:kGroupModelSchoolCode];
    [aCoder encodeObject:_groupModelDescription forKey:kGroupModelDescription];
    [aCoder encodeObject:_star forKey:kGroupModelStar];
    [aCoder encodeObject:_groupIcon forKey:kGroupModelGroupIcon];
    [aCoder encodeObject:_hot forKey:kGroupModelHot];
    [aCoder encodeObject:_keyWords forKey:kGroupModelKeyWords];
    [aCoder encodeObject:_schoolName forKey:kGroupModelSchoolName];
    [aCoder encodeObject:_groupName forKey:kGroupModelGroupName];
    [aCoder encodeObject:_thirdId forKey:kGroupModelThirdId];
    [aCoder encodeObject:_cacheVersion forKey:kGroupModelCacheVersion];
}

- (id)copyWithZone:(NSZone *)zone
{
    GroupModel *copy = [[GroupModel alloc] init];
    
    if (copy) {

        copy.groupModelIdentifier = self.groupModelIdentifier;
        copy.category = [self.category copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.groupModelDescription = [self.groupModelDescription copyWithZone:zone];
        copy.star = [self.star copyWithZone:zone];
        copy.groupIcon = [self.groupIcon copyWithZone:zone];
        copy.hot = [self.hot copyWithZone:zone];
        copy.keyWords = [self.keyWords copyWithZone:zone];
        copy.schoolName = [self.schoolName copyWithZone:zone];
        copy.groupName = [self.groupName copyWithZone:zone];
        copy.thirdId = [self.thirdId copyWithZone:zone];
        copy.cacheVersion = [self.cacheVersion copyWithZone:zone];
    }
    
    return copy;
}


@end
