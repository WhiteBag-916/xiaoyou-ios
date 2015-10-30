//
//  CourseTime.m
//
//  Created by   on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CourseTime.h"


NSString *const kCourseTimePhase = @"phase";
NSString *const kCourseTimeSchoolCode = @"schoolCode";
NSString *const kCourseTimeId = @"id";
NSString *const kCourseTimeEndTime = @"endTime";
NSString *const kCourseTimeUpdateTime = @"updateTime";
NSString *const kCourseTimeDescription = @"description";
NSString *const kCourseTimeStartTime = @"startTime";
NSString *const kCourseTimeCreateTime = @"createTime";


@interface CourseTime ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CourseTime

@synthesize phase = _phase;
@synthesize schoolCode = _schoolCode;
@synthesize courseTimeIdentifier = _courseTimeIdentifier;
@synthesize endTime = _endTime;
@synthesize updateTime = _updateTime;
@synthesize courseTimeDescription = _courseTimeDescription;
@synthesize startTime = _startTime;
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
            self.phase = [[self objectOrNilForKey:kCourseTimePhase fromDictionary:dict] doubleValue];
            self.schoolCode = [self objectOrNilForKey:kCourseTimeSchoolCode fromDictionary:dict];
            self.courseTimeIdentifier = [[self objectOrNilForKey:kCourseTimeId fromDictionary:dict] doubleValue];
            self.endTime = [self objectOrNilForKey:kCourseTimeEndTime fromDictionary:dict];
            self.updateTime = [[self objectOrNilForKey:kCourseTimeUpdateTime fromDictionary:dict] doubleValue];
            self.courseTimeDescription = [self objectOrNilForKey:kCourseTimeDescription fromDictionary:dict];
            self.startTime = [self objectOrNilForKey:kCourseTimeStartTime fromDictionary:dict];
            self.createTime = [[self objectOrNilForKey:kCourseTimeCreateTime fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.phase] forKey:kCourseTimePhase];
    [mutableDict setValue:self.schoolCode forKey:kCourseTimeSchoolCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.courseTimeIdentifier] forKey:kCourseTimeId];
    [mutableDict setValue:self.endTime forKey:kCourseTimeEndTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateTime] forKey:kCourseTimeUpdateTime];
    [mutableDict setValue:self.courseTimeDescription forKey:kCourseTimeDescription];
    [mutableDict setValue:self.startTime forKey:kCourseTimeStartTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kCourseTimeCreateTime];

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

    self.phase = [aDecoder decodeDoubleForKey:kCourseTimePhase];
    self.schoolCode = [aDecoder decodeObjectForKey:kCourseTimeSchoolCode];
    self.courseTimeIdentifier = [aDecoder decodeDoubleForKey:kCourseTimeId];
    self.endTime = [aDecoder decodeObjectForKey:kCourseTimeEndTime];
    self.updateTime = [aDecoder decodeDoubleForKey:kCourseTimeUpdateTime];
    self.courseTimeDescription = [aDecoder decodeObjectForKey:kCourseTimeDescription];
    self.startTime = [aDecoder decodeObjectForKey:kCourseTimeStartTime];
    self.createTime = [aDecoder decodeDoubleForKey:kCourseTimeCreateTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_phase forKey:kCourseTimePhase];
    [aCoder encodeObject:_schoolCode forKey:kCourseTimeSchoolCode];
    [aCoder encodeDouble:_courseTimeIdentifier forKey:kCourseTimeId];
    [aCoder encodeObject:_endTime forKey:kCourseTimeEndTime];
    [aCoder encodeDouble:_updateTime forKey:kCourseTimeUpdateTime];
    [aCoder encodeObject:_courseTimeDescription forKey:kCourseTimeDescription];
    [aCoder encodeObject:_startTime forKey:kCourseTimeStartTime];
    [aCoder encodeDouble:_createTime forKey:kCourseTimeCreateTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    CourseTime *copy = [[CourseTime alloc] init];
    
    if (copy) {

        copy.phase = self.phase;
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.courseTimeIdentifier = self.courseTimeIdentifier;
        copy.endTime = [self.endTime copyWithZone:zone];
        copy.updateTime = self.updateTime;
        copy.courseTimeDescription = [self.courseTimeDescription copyWithZone:zone];
        copy.startTime = [self.startTime copyWithZone:zone];
        copy.createTime = self.createTime;
    }
    
    return copy;
}


@end
