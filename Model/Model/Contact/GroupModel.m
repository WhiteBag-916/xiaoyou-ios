//
//  GroupModel.m
//
//  Created by   on 15/8/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GroupModel.h"


NSString *const kGroupModelId = @"id";
NSString *const kGroupModelCategory = @"category";
NSString *const kGroupModelSchoolCode = @"schoolCode";
NSString *const kGroupModelGroupType = @"groupType";
NSString *const kGroupModelPraiseCount = @"praiseCount";
NSString *const kGroupModelDescription = @"description";
NSString *const kGroupModelStar = @"star";
NSString *const kGroupModelGroupIcon = @"groupIcon";
NSString *const kGroupModelHot = @"hot";
NSString *const kGroupModelIsCool = @"isCool";
NSString *const kGroupModelCoolCount = @"coolCount";
NSString *const kGroupModelKeyWords = @"keyWords";
NSString *const kGroupModelGroupName = @"groupName";
NSString *const kGroupModelSchoolName = @"schoolName";
NSString *const kGroupModelGroupStatus = @"groupStatus";
NSString *const kGroupModelThirdId = @"thirdId";
NSString *const kGroupModelCacheVersion = @"cacheVersion";


@interface GroupModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GroupModel

@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize category = _category;
@synthesize schoolCode = _schoolCode;
@synthesize groupType = _groupType;
@synthesize praiseCount = _praiseCount;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize star = _star;
@synthesize groupIcon = _groupIcon;
@synthesize hot = _hot;
@synthesize isCool = _isCool;
@synthesize coolCount = _coolCount;
@synthesize keyWords = _keyWords;
@synthesize groupName = _groupName;
@synthesize schoolName = _schoolName;
@synthesize groupStatus = _groupStatus;
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
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kGroupModelId fromDictionary:dict] doubleValue];
            self.category = [self objectOrNilForKey:kGroupModelCategory fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kGroupModelSchoolCode fromDictionary:dict];
            self.groupType = [[self objectOrNilForKey:kGroupModelGroupType fromDictionary:dict] doubleValue];
            self.praiseCount = [[self objectOrNilForKey:kGroupModelPraiseCount fromDictionary:dict] doubleValue];
            self.internalBaseClassDescription = [self objectOrNilForKey:kGroupModelDescription fromDictionary:dict];
            self.star = [self objectOrNilForKey:kGroupModelStar fromDictionary:dict];
            self.groupIcon = [self objectOrNilForKey:kGroupModelGroupIcon fromDictionary:dict];
            self.hot = [self objectOrNilForKey:kGroupModelHot fromDictionary:dict];
            self.isCool = [[self objectOrNilForKey:kGroupModelIsCool fromDictionary:dict] boolValue];
            self.coolCount = [[self objectOrNilForKey:kGroupModelCoolCount fromDictionary:dict] doubleValue];
            self.keyWords = [self objectOrNilForKey:kGroupModelKeyWords fromDictionary:dict];
            self.groupName = [self objectOrNilForKey:kGroupModelGroupName fromDictionary:dict];
            self.schoolName = [self objectOrNilForKey:kGroupModelSchoolName fromDictionary:dict];
            self.groupStatus = [self objectOrNilForKey:kGroupModelGroupStatus fromDictionary:dict];
            self.thirdId = [self objectOrNilForKey:kGroupModelThirdId fromDictionary:dict];
            self.cacheVersion = [self objectOrNilForKey:kGroupModelCacheVersion fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kGroupModelId];
    [mutableDict setValue:self.category forKey:kGroupModelCategory];
    [mutableDict setValue:self.schoolCode forKey:kGroupModelSchoolCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.groupType] forKey:kGroupModelGroupType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.praiseCount] forKey:kGroupModelPraiseCount];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kGroupModelDescription];
    [mutableDict setValue:self.star forKey:kGroupModelStar];
    [mutableDict setValue:self.groupIcon forKey:kGroupModelGroupIcon];
    [mutableDict setValue:[NSNumber numberWithBool:self.hot] forKey:kGroupModelHot];
    [mutableDict setValue:[NSNumber numberWithBool:self.isCool] forKey:kGroupModelIsCool];
    [mutableDict setValue:[NSNumber numberWithDouble:self.coolCount] forKey:kGroupModelCoolCount];
    [mutableDict setValue:self.keyWords forKey:kGroupModelKeyWords];
    [mutableDict setValue:self.groupName forKey:kGroupModelGroupName];
    [mutableDict setValue:self.schoolName forKey:kGroupModelSchoolName];
    [mutableDict setValue:self.groupStatus forKey:kGroupModelGroupStatus];
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

    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kGroupModelId];
    self.category = [aDecoder decodeObjectForKey:kGroupModelCategory];
    self.schoolCode = [aDecoder decodeObjectForKey:kGroupModelSchoolCode];
    self.groupType = [aDecoder decodeDoubleForKey:kGroupModelGroupType];
    self.praiseCount = [aDecoder decodeDoubleForKey:kGroupModelPraiseCount];
    self.internalBaseClassDescription = [aDecoder decodeObjectForKey:kGroupModelDescription];
    self.star = [aDecoder decodeObjectForKey:kGroupModelStar];
    self.groupIcon = [aDecoder decodeObjectForKey:kGroupModelGroupIcon];
    self.hot = [aDecoder decodeObjectForKey:kGroupModelHot];
    self.isCool = [aDecoder decodeBoolForKey:kGroupModelIsCool];
    self.coolCount = [aDecoder decodeDoubleForKey:kGroupModelCoolCount];
    self.keyWords = [aDecoder decodeObjectForKey:kGroupModelKeyWords];
    self.groupName = [aDecoder decodeObjectForKey:kGroupModelGroupName];
    self.schoolName = [aDecoder decodeObjectForKey:kGroupModelSchoolName];
    self.groupStatus = [aDecoder decodeObjectForKey:kGroupModelGroupStatus];
    self.thirdId = [aDecoder decodeObjectForKey:kGroupModelThirdId];
    self.cacheVersion = [aDecoder decodeObjectForKey:kGroupModelCacheVersion];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kGroupModelId];
    [aCoder encodeObject:_category forKey:kGroupModelCategory];
    [aCoder encodeObject:_schoolCode forKey:kGroupModelSchoolCode];
    [aCoder encodeDouble:_groupType forKey:kGroupModelGroupType];
    [aCoder encodeDouble:_praiseCount forKey:kGroupModelPraiseCount];
    [aCoder encodeObject:_internalBaseClassDescription forKey:kGroupModelDescription];
    [aCoder encodeObject:_star forKey:kGroupModelStar];
    [aCoder encodeObject:_groupIcon forKey:kGroupModelGroupIcon];
    [aCoder encodeBool:_hot forKey:kGroupModelHot];
    [aCoder encodeBool:_isCool forKey:kGroupModelIsCool];
    [aCoder encodeDouble:_coolCount forKey:kGroupModelCoolCount];
    [aCoder encodeObject:_keyWords forKey:kGroupModelKeyWords];
    [aCoder encodeObject:_groupName forKey:kGroupModelGroupName];
    [aCoder encodeObject:_schoolName forKey:kGroupModelSchoolName];
    [aCoder encodeObject:_groupStatus forKey:kGroupModelGroupStatus];
    [aCoder encodeObject:_thirdId forKey:kGroupModelThirdId];
    [aCoder encodeObject:_cacheVersion forKey:kGroupModelCacheVersion];
}

- (id)copyWithZone:(NSZone *)zone
{
    GroupModel *copy = [[GroupModel alloc] init];
    
    if (copy) {

        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.category = [self.category copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.groupType = self.groupType;
        copy.praiseCount = self.praiseCount;
        copy.internalBaseClassDescription = [self.internalBaseClassDescription copyWithZone:zone];
        copy.star = [self.star copyWithZone:zone];
        copy.groupIcon = [self.groupIcon copyWithZone:zone];
        copy.hot = self.hot;
        copy.isCool = self.isCool;
        copy.coolCount = self.coolCount;
        copy.keyWords = [self.keyWords copyWithZone:zone];
        copy.groupName = [self.groupName copyWithZone:zone];
        copy.schoolName = [self.schoolName copyWithZone:zone];
        copy.groupStatus = [self.groupStatus copyWithZone:zone];
        copy.thirdId = [self.thirdId copyWithZone:zone];
        copy.cacheVersion = [self.cacheVersion copyWithZone:zone];
    }
    
    return copy;
}


@end
