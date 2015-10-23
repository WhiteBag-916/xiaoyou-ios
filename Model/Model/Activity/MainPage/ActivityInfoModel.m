//
//  ActivityInfoModel.m
//
//  Created by   on 15/10/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ActivityInfoModel.h"
#import "ActivityImageTextModels.h"
#import "ActivityPublishedModel.h"
#import "ActivityCoverageModels.h"


NSString *const kActivityInfoModelActivityImageTextModels = @"activityImageTextModels";
NSString *const kActivityInfoModelActivityPublishedModel = @"activityPublishedModel";
NSString *const kActivityInfoModelActivityCoverageModels = @"activityCoverageModels";


@interface ActivityInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ActivityInfoModel

@synthesize activityImageTextModels = _activityImageTextModels;
@synthesize activityPublishedModel = _activityPublishedModel;
@synthesize activityCoverageModels = _activityCoverageModels;


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
    NSObject *receivedActivityImageTextModels = [dict objectForKey:kActivityInfoModelActivityImageTextModels];
    NSMutableArray *parsedActivityImageTextModels = [NSMutableArray array];
    if ([receivedActivityImageTextModels isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedActivityImageTextModels) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedActivityImageTextModels addObject:[ActivityImageTextModels modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedActivityImageTextModels isKindOfClass:[NSDictionary class]]) {
       [parsedActivityImageTextModels addObject:[ActivityImageTextModels modelObjectWithDictionary:(NSDictionary *)receivedActivityImageTextModels]];
    }

    self.activityImageTextModels = [NSArray arrayWithArray:parsedActivityImageTextModels];
            self.activityPublishedModel = [ActivityPublishedModel modelObjectWithDictionary:[dict objectForKey:kActivityInfoModelActivityPublishedModel]];
    NSObject *receivedActivityCoverageModels = [dict objectForKey:kActivityInfoModelActivityCoverageModels];
    NSMutableArray *parsedActivityCoverageModels = [NSMutableArray array];
    if ([receivedActivityCoverageModels isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedActivityCoverageModels) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedActivityCoverageModels addObject:[ActivityCoverageModels modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedActivityCoverageModels isKindOfClass:[NSDictionary class]]) {
       [parsedActivityCoverageModels addObject:[ActivityCoverageModels modelObjectWithDictionary:(NSDictionary *)receivedActivityCoverageModels]];
    }

    self.activityCoverageModels = [NSArray arrayWithArray:parsedActivityCoverageModels];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForActivityImageTextModels = [NSMutableArray array];
    for (NSObject *subArrayObject in self.activityImageTextModels) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForActivityImageTextModels addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForActivityImageTextModels addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForActivityImageTextModels] forKey:kActivityInfoModelActivityImageTextModels];
    [mutableDict setValue:[self.activityPublishedModel dictionaryRepresentation] forKey:kActivityInfoModelActivityPublishedModel];
    NSMutableArray *tempArrayForActivityCoverageModels = [NSMutableArray array];
    for (NSObject *subArrayObject in self.activityCoverageModels) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForActivityCoverageModels addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForActivityCoverageModels addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForActivityCoverageModels] forKey:kActivityInfoModelActivityCoverageModels];

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

    self.activityImageTextModels = [aDecoder decodeObjectForKey:kActivityInfoModelActivityImageTextModels];
    self.activityPublishedModel = [aDecoder decodeObjectForKey:kActivityInfoModelActivityPublishedModel];
    self.activityCoverageModels = [aDecoder decodeObjectForKey:kActivityInfoModelActivityCoverageModels];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_activityImageTextModels forKey:kActivityInfoModelActivityImageTextModels];
    [aCoder encodeObject:_activityPublishedModel forKey:kActivityInfoModelActivityPublishedModel];
    [aCoder encodeObject:_activityCoverageModels forKey:kActivityInfoModelActivityCoverageModels];
}

- (id)copyWithZone:(NSZone *)zone
{
    ActivityInfoModel *copy = [[ActivityInfoModel alloc] init];
    
    if (copy) {

        copy.activityImageTextModels = [self.activityImageTextModels copyWithZone:zone];
        copy.activityPublishedModel = [self.activityPublishedModel copyWithZone:zone];
        copy.activityCoverageModels = [self.activityCoverageModels copyWithZone:zone];
    }
    
    return copy;
}


@end
