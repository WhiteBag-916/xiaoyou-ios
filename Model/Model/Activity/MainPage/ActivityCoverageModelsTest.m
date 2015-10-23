//
//  ActivityCoverageModels.m
//
//  Created by sheng  on 15/10/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ActivityCoverageModelsTest.h"


NSString *const kActivityCoverageModelsActivityId = @"activityId";
NSString *const kActivityCoverageModelsCoverageType = @"coverageType";
NSString *const kActivityCoverageModelsId = @"id";
NSString *const kActivityCoverageModelsUpdateTime = @"updateTime";
NSString *const kActivityCoverageModelsIsRepeatPush = @"isRepeatPush";
NSString *const kActivityCoverageModelsPushStatus = @"pushStatus";
NSString *const kActivityCoverageModelsCoverage = @"coverage";
NSString *const kActivityCoverageModelsCreateTime = @"createTime";


@interface ActivityCoverageModelsTest ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ActivityCoverageModelsTest

@synthesize activityId = _activityId;
@synthesize coverageType = _coverageType;
@synthesize activityCoverageModelsIdentifier = _activityCoverageModelsIdentifier;
@synthesize updateTime = _updateTime;
@synthesize isRepeatPush = _isRepeatPush;
@synthesize pushStatus = _pushStatus;
@synthesize coverage = _coverage;
@synthesize createTime = _createTime;


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
            self.activityId = [[self objectOrNilForKey:kActivityCoverageModelsActivityId fromDictionary:dict] doubleValue];
            self.coverageType = [self objectOrNilForKey:kActivityCoverageModelsCoverageType fromDictionary:dict];
            self.activityCoverageModelsIdentifier = [[self objectOrNilForKey:kActivityCoverageModelsId fromDictionary:dict] doubleValue];
            self.updateTime = [[self objectOrNilForKey:kActivityCoverageModelsUpdateTime fromDictionary:dict] doubleValue];
            self.isRepeatPush = [[self objectOrNilForKey:kActivityCoverageModelsIsRepeatPush fromDictionary:dict] boolValue];
            self.pushStatus = [self objectOrNilForKey:kActivityCoverageModelsPushStatus fromDictionary:dict];
            self.coverage = [self objectOrNilForKey:kActivityCoverageModelsCoverage fromDictionary:dict];
            self.createTime = [[self objectOrNilForKey:kActivityCoverageModelsCreateTime fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.activityId] forKey:kActivityCoverageModelsActivityId];
    [mutableDict setValue:self.coverageType forKey:kActivityCoverageModelsCoverageType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.activityCoverageModelsIdentifier] forKey:kActivityCoverageModelsId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateTime] forKey:kActivityCoverageModelsUpdateTime];
    [mutableDict setValue:[NSNumber numberWithBool:self.isRepeatPush] forKey:kActivityCoverageModelsIsRepeatPush];
    [mutableDict setValue:self.pushStatus forKey:kActivityCoverageModelsPushStatus];
    [mutableDict setValue:self.coverage forKey:kActivityCoverageModelsCoverage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kActivityCoverageModelsCreateTime];

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

    self.activityId = [aDecoder decodeDoubleForKey:kActivityCoverageModelsActivityId];
    self.coverageType = [aDecoder decodeObjectForKey:kActivityCoverageModelsCoverageType];
    self.activityCoverageModelsIdentifier = [aDecoder decodeDoubleForKey:kActivityCoverageModelsId];
    self.updateTime = [aDecoder decodeDoubleForKey:kActivityCoverageModelsUpdateTime];
    self.isRepeatPush = [aDecoder decodeBoolForKey:kActivityCoverageModelsIsRepeatPush];
    self.pushStatus = [aDecoder decodeObjectForKey:kActivityCoverageModelsPushStatus];
    self.coverage = [aDecoder decodeObjectForKey:kActivityCoverageModelsCoverage];
    self.createTime = [aDecoder decodeDoubleForKey:kActivityCoverageModelsCreateTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_activityId forKey:kActivityCoverageModelsActivityId];
    [aCoder encodeObject:_coverageType forKey:kActivityCoverageModelsCoverageType];
    [aCoder encodeDouble:_activityCoverageModelsIdentifier forKey:kActivityCoverageModelsId];
    [aCoder encodeDouble:_updateTime forKey:kActivityCoverageModelsUpdateTime];
    [aCoder encodeBool:_isRepeatPush forKey:kActivityCoverageModelsIsRepeatPush];
    [aCoder encodeObject:_pushStatus forKey:kActivityCoverageModelsPushStatus];
    [aCoder encodeObject:_coverage forKey:kActivityCoverageModelsCoverage];
    [aCoder encodeDouble:_createTime forKey:kActivityCoverageModelsCreateTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ActivityCoverageModelsTest *copy = [[ActivityCoverageModelsTest alloc] init];
    
    if (copy) {

        copy.activityId = self.activityId;
        copy.coverageType = [self.coverageType copyWithZone:zone];
        copy.activityCoverageModelsIdentifier = self.activityCoverageModelsIdentifier;
        copy.updateTime = self.updateTime;
        copy.isRepeatPush = self.isRepeatPush;
        copy.pushStatus = [self.pushStatus copyWithZone:zone];
        copy.coverage = [self.coverage copyWithZone:zone];
        copy.createTime = self.createTime;
    }
    
    return copy;
}


@end
