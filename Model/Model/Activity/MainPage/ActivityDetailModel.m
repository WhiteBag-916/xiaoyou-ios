//
//  ActivityDetailModel.m
//
//  Created by   on 15/10/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ActivityDetailModel.h"
#import "Author.h"
#import "ActivityOrganizer.h"
#import "ActivityTypeInfo.h"
#import "ActivityInfoModel.h"


NSString *const kActivityDetailModelEnroll = @"enroll";
NSString *const kActivityDetailModelEnrollActivityUserInfos = @"enrollActivityUserInfos";
NSString *const kActivityDetailModelActivityOrganizer = @"activityOrganizer";
NSString *const kActivityDetailModelActivityTypeInfo = @"activityTypeInfo";
NSString *const kActivityDetailModelActivityPublishedDto = @"activityPublishedDto";
NSString *const kActivityDetailModelActivityEnrollStatus = @"enrollStatus";

@interface ActivityDetailModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ActivityDetailModel

@synthesize enroll = _enroll;
@synthesize enrollActivityUserInfos = _enrollActivityUserInfos;
@synthesize activityOrganizer = _activityOrganizer;
@synthesize activityTypeInfo = _activityTypeInfo;
@synthesize activityPublishedDto = _activityPublishedDto;


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
        self.enrollStatus = [self objectOrNilForKey:kActivityDetailModelActivityEnrollStatus fromDictionary:dict];
        
            self.enroll = [[self objectOrNilForKey:kActivityDetailModelEnroll fromDictionary:dict] boolValue];
    NSObject *receivedEnrollActivityUserInfos = [dict objectForKey:kActivityDetailModelEnrollActivityUserInfos];
    NSMutableArray *parsedEnrollActivityUserInfos = [NSMutableArray array];
    if ([receivedEnrollActivityUserInfos isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEnrollActivityUserInfos) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEnrollActivityUserInfos addObject:[Author modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEnrollActivityUserInfos isKindOfClass:[NSDictionary class]]) {
       [parsedEnrollActivityUserInfos addObject:[Author modelObjectWithDictionary:(NSDictionary *)receivedEnrollActivityUserInfos]];
    }

    self.enrollActivityUserInfos = [NSArray arrayWithArray:parsedEnrollActivityUserInfos];
            self.activityOrganizer = [ActivityOrganizer modelObjectWithDictionary:[dict objectForKey:kActivityDetailModelActivityOrganizer]];
            self.activityTypeInfo = [ActivityTypeInfo modelObjectWithDictionary:[dict objectForKey:kActivityDetailModelActivityTypeInfo]];
            self.activityPublishedDto = [ActivityInfoModel modelObjectWithDictionary:[dict objectForKey:kActivityDetailModelActivityPublishedDto]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.enroll] forKey:kActivityDetailModelEnroll];
    [mutableDict setValue:self.enrollStatus forKey:kActivityDetailModelActivityEnrollStatus];
    NSMutableArray *tempArrayForEnrollActivityUserInfos = [NSMutableArray array];
    for (NSObject *subArrayObject in self.enrollActivityUserInfos) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForEnrollActivityUserInfos addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForEnrollActivityUserInfos addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForEnrollActivityUserInfos] forKey:kActivityDetailModelEnrollActivityUserInfos];
    [mutableDict setValue:[self.activityOrganizer dictionaryRepresentation] forKey:kActivityDetailModelActivityOrganizer];
    [mutableDict setValue:[self.activityTypeInfo dictionaryRepresentation] forKey:kActivityDetailModelActivityTypeInfo];
    [mutableDict setValue:[self.activityPublishedDto dictionaryRepresentation] forKey:kActivityDetailModelActivityPublishedDto];

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

    self.enroll = [aDecoder decodeBoolForKey:kActivityDetailModelEnroll];
    self.enrollActivityUserInfos = [aDecoder decodeObjectForKey:kActivityDetailModelEnrollActivityUserInfos];
    self.activityOrganizer = [aDecoder decodeObjectForKey:kActivityDetailModelActivityOrganizer];
    self.activityTypeInfo = [aDecoder decodeObjectForKey:kActivityDetailModelActivityTypeInfo];
    self.activityPublishedDto = [aDecoder decodeObjectForKey:kActivityDetailModelActivityPublishedDto];
    self.enrollStatus = [aDecoder decodeObjectForKey:kActivityDetailModelActivityEnrollStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_enroll forKey:kActivityDetailModelEnroll];
    [aCoder encodeObject:_enrollActivityUserInfos forKey:kActivityDetailModelEnrollActivityUserInfos];
    [aCoder encodeObject:_activityOrganizer forKey:kActivityDetailModelActivityOrganizer];
    [aCoder encodeObject:_activityTypeInfo forKey:kActivityDetailModelActivityTypeInfo];
    [aCoder encodeObject:_activityPublishedDto forKey:kActivityDetailModelActivityPublishedDto];
    [aCoder encodeObject:_enrollStatus forKey:kActivityDetailModelActivityEnrollStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    ActivityDetailModel *copy = [[ActivityDetailModel alloc] init];
    
    if (copy) {

        copy.enroll = self.enroll;
        copy.enrollActivityUserInfos = [self.enrollActivityUserInfos copyWithZone:zone];
        copy.activityOrganizer = [self.activityOrganizer copyWithZone:zone];
        copy.activityTypeInfo = [self.activityTypeInfo copyWithZone:zone];
        copy.activityPublishedDto = [self.activityPublishedDto copyWithZone:zone];
        copy.enrollStatus = [self.enrollStatus copyWithZone:zone];
    }
    
    return copy;
}


@end
