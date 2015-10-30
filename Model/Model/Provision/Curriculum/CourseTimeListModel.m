//
//  CourseTimeListModel.m
//
//  Created by   on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CourseTimeListModel.h"
#import "CourseTime.h"


NSString *const kCourseTimeListModelFirstTime = @"firstTime";
NSString *const kCourseTimeListModelMaxWeek = @"maxWeek";
NSString *const kCourseTimeListModelCourseTime = @"courseTime";


@interface CourseTimeListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CourseTimeListModel

@synthesize firstTime = _firstTime;
@synthesize maxWeek = _maxWeek;
@synthesize courseTime = _courseTime;


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
            self.firstTime = [self objectOrNilForKey:kCourseTimeListModelFirstTime fromDictionary:dict];
            self.maxWeek = [[self objectOrNilForKey:kCourseTimeListModelMaxWeek fromDictionary:dict] doubleValue];
    NSObject *receivedCourseTime = [dict objectForKey:kCourseTimeListModelCourseTime];
    NSMutableArray *parsedCourseTime = [NSMutableArray array];
    if ([receivedCourseTime isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCourseTime) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCourseTime addObject:[CourseTime modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCourseTime isKindOfClass:[NSDictionary class]]) {
       [parsedCourseTime addObject:[CourseTime modelObjectWithDictionary:(NSDictionary *)receivedCourseTime]];
    }

    self.courseTime = [NSArray arrayWithArray:parsedCourseTime];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.firstTime forKey:kCourseTimeListModelFirstTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.maxWeek] forKey:kCourseTimeListModelMaxWeek];
    NSMutableArray *tempArrayForCourseTime = [NSMutableArray array];
    for (NSObject *subArrayObject in self.courseTime) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCourseTime addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCourseTime addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCourseTime] forKey:kCourseTimeListModelCourseTime];

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

    self.firstTime = [aDecoder decodeObjectForKey:kCourseTimeListModelFirstTime];
    self.maxWeek = [aDecoder decodeDoubleForKey:kCourseTimeListModelMaxWeek];
    self.courseTime = [aDecoder decodeObjectForKey:kCourseTimeListModelCourseTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_firstTime forKey:kCourseTimeListModelFirstTime];
    [aCoder encodeDouble:_maxWeek forKey:kCourseTimeListModelMaxWeek];
    [aCoder encodeObject:_courseTime forKey:kCourseTimeListModelCourseTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    CourseTimeListModel *copy = [[CourseTimeListModel alloc] init];
    
    if (copy) {

        copy.firstTime = [self.firstTime copyWithZone:zone];
        copy.maxWeek = self.maxWeek;
        copy.courseTime = [self.courseTime copyWithZone:zone];
    }
    
    return copy;
}


@end
