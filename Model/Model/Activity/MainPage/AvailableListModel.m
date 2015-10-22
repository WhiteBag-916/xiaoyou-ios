//
//  Obj.m
//
//  Created by sheng  on 15/10/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "AvailableListModel.h"
#import "ActivityPublishedModel.h"
#import "ActivityCoverageModels.h"
#import "ActivityImageTextModels.h"


NSString *const kObjActivityPublishedModel = @"activityPublishedModel";
NSString *const kObjActivityCoverageModels = @"activityCoverageModels";
NSString *const kObjActivityImageTextModels = @"activityImageTextModels";


@interface AvailableListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AvailableListModel

@synthesize activityPublishedModel = _activityPublishedModel;
@synthesize activityCoverageModels = _activityCoverageModels;
@synthesize activityImageTextModels = _activityImageTextModels;


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
            self.activityPublishedModel = [ActivityPublishedModel modelObjectWithDictionary:[dict objectForKey:kObjActivityPublishedModel]];
    NSObject *receivedActivityCoverageModels = [dict objectForKey:kObjActivityCoverageModels];
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
    NSObject *receivedActivityImageTextModels = [dict objectForKey:kObjActivityImageTextModels];
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

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.activityPublishedModel dictionaryRepresentation] forKey:kObjActivityPublishedModel];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForActivityCoverageModels] forKey:kObjActivityCoverageModels];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForActivityImageTextModels] forKey:kObjActivityImageTextModels];

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

    self.activityPublishedModel = [aDecoder decodeObjectForKey:kObjActivityPublishedModel];
    self.activityCoverageModels = [aDecoder decodeObjectForKey:kObjActivityCoverageModels];
    self.activityImageTextModels = [aDecoder decodeObjectForKey:kObjActivityImageTextModels];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_activityPublishedModel forKey:kObjActivityPublishedModel];
    [aCoder encodeObject:_activityCoverageModels forKey:kObjActivityCoverageModels];
    [aCoder encodeObject:_activityImageTextModels forKey:kObjActivityImageTextModels];
}

- (id)copyWithZone:(NSZone *)zone
{
    AvailableListModel *copy = [[AvailableListModel alloc] init];
    
    if (copy) {

        copy.activityPublishedModel = [self.activityPublishedModel copyWithZone:zone];
        copy.activityCoverageModels = [self.activityCoverageModels copyWithZone:zone];
        copy.activityImageTextModels = [self.activityImageTextModels copyWithZone:zone];
    }
    
    return copy;
}


@end
