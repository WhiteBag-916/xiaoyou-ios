//
//  BaseClass.m
//
//  Created by sheng  on 15/11/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//
#import "AvailableTimeModel.h"
#import "Scheduling.h"
#import "ActivityInfoModel.h"


NSString *const kBaseClassScheduling = @"scheduling";
NSString *const kBaseClassAvailableBuilding = @"availableBuilding";
NSString *const kBaseClassActivityList = @"activityList";


@interface AvailableTimeModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AvailableTimeModel

@synthesize scheduling = _scheduling;
@synthesize availableBuilding = _availableBuilding;
@synthesize activityList = _activityList;


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
    NSObject *receivedScheduling = [dict objectForKey:kBaseClassScheduling];
    NSMutableArray *parsedScheduling = [NSMutableArray array];
    if ([receivedScheduling isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedScheduling) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedScheduling addObject:[Scheduling modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedScheduling isKindOfClass:[NSDictionary class]]) {
       [parsedScheduling addObject:[Scheduling modelObjectWithDictionary:(NSDictionary *)receivedScheduling]];
    }

    self.scheduling = [NSArray arrayWithArray:parsedScheduling];
            self.availableBuilding = [[self objectOrNilForKey:kBaseClassAvailableBuilding fromDictionary:dict] doubleValue];
    NSObject *receivedActivityInfoModel = [dict objectForKey:kBaseClassActivityList];
    NSMutableArray *parsedActivityInfoModel = [NSMutableArray array];
    if ([receivedActivityInfoModel isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedActivityInfoModel) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedActivityInfoModel addObject:[ActivityInfoModel modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedActivityInfoModel isKindOfClass:[NSDictionary class]]) {
       [parsedActivityInfoModel addObject:[ActivityInfoModel modelObjectWithDictionary:(NSDictionary *)receivedActivityInfoModel]];
    }

    self.activityList = [NSArray arrayWithArray:parsedActivityInfoModel];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForScheduling = [NSMutableArray array];
    for (NSObject *subArrayObject in self.scheduling) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForScheduling addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForScheduling addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForScheduling] forKey:kBaseClassScheduling];
    [mutableDict setValue:[NSNumber numberWithDouble:self.availableBuilding] forKey:kBaseClassAvailableBuilding];
    NSMutableArray *tempArrayForActivityInfoModel = [NSMutableArray array];
    for (NSObject *subArrayObject in self.activityList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForActivityInfoModel addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForActivityInfoModel addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForActivityInfoModel] forKey:kBaseClassActivityList];

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

    self.scheduling = [aDecoder decodeObjectForKey:kBaseClassScheduling];
    self.availableBuilding = [aDecoder decodeDoubleForKey:kBaseClassAvailableBuilding];
    self.activityList = [aDecoder decodeObjectForKey:kBaseClassActivityList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_scheduling forKey:kBaseClassScheduling];
    [aCoder encodeDouble:_availableBuilding forKey:kBaseClassAvailableBuilding];
    [aCoder encodeObject:_activityList forKey:kBaseClassActivityList];
}

- (id)copyWithZone:(NSZone *)zone
{
    AvailableTimeModel *copy = [[AvailableTimeModel alloc] init];
    
    if (copy) {

        copy.scheduling = [self.scheduling copyWithZone:zone];
        copy.availableBuilding = self.availableBuilding;
        copy.activityList = [self.activityList copyWithZone:zone];
    }
    
    return copy;
}


@end
