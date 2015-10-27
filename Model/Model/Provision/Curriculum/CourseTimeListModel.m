//
//  CourseTimeListModel.m
//
//  Created by   on 15/10/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CourseTimeListModel.h"


NSString *const kCourseTimeListModelPhase = @"phase";
NSString *const kCourseTimeListModelSchoolCode = @"schoolCode";
NSString *const kCourseTimeListModelId = @"id";
NSString *const kCourseTimeListModelEndTime = @"endTime";
NSString *const kCourseTimeListModelUpdateTime = @"updateTime";
NSString *const kCourseTimeListModelDescription = @"description";
NSString *const kCourseTimeListModelStartTime = @"startTime";
NSString *const kCourseTimeListModelCreateTime = @"createTime";


@interface CourseTimeListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CourseTimeListModel

@synthesize phase = _phase;
@synthesize schoolCode = _schoolCode;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize endTime = _endTime;
@synthesize updateTime = _updateTime;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
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
            self.phase = [[self objectOrNilForKey:kCourseTimeListModelPhase fromDictionary:dict] doubleValue];
            self.schoolCode = [self objectOrNilForKey:kCourseTimeListModelSchoolCode fromDictionary:dict];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kCourseTimeListModelId fromDictionary:dict] doubleValue];
            self.endTime = [self objectOrNilForKey:kCourseTimeListModelEndTime fromDictionary:dict];
            self.updateTime = [self objectOrNilForKey:kCourseTimeListModelUpdateTime fromDictionary:dict];
            self.internalBaseClassDescription = [self objectOrNilForKey:kCourseTimeListModelDescription fromDictionary:dict];
            self.startTime = [self objectOrNilForKey:kCourseTimeListModelStartTime fromDictionary:dict];
            self.createTime = [[self objectOrNilForKey:kCourseTimeListModelCreateTime fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.phase] forKey:kCourseTimeListModelPhase];
    [mutableDict setValue:self.schoolCode forKey:kCourseTimeListModelSchoolCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kCourseTimeListModelId];
    [mutableDict setValue:self.endTime forKey:kCourseTimeListModelEndTime];
    [mutableDict setValue:self.updateTime forKey:kCourseTimeListModelUpdateTime];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kCourseTimeListModelDescription];
    [mutableDict setValue:self.startTime forKey:kCourseTimeListModelStartTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kCourseTimeListModelCreateTime];

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

    self.phase = [aDecoder decodeDoubleForKey:kCourseTimeListModelPhase];
    self.schoolCode = [aDecoder decodeObjectForKey:kCourseTimeListModelSchoolCode];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kCourseTimeListModelId];
    self.endTime = [aDecoder decodeObjectForKey:kCourseTimeListModelEndTime];
    self.updateTime = [aDecoder decodeObjectForKey:kCourseTimeListModelUpdateTime];
    self.internalBaseClassDescription = [aDecoder decodeObjectForKey:kCourseTimeListModelDescription];
    self.startTime = [aDecoder decodeObjectForKey:kCourseTimeListModelStartTime];
    self.createTime = [aDecoder decodeDoubleForKey:kCourseTimeListModelCreateTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_phase forKey:kCourseTimeListModelPhase];
    [aCoder encodeObject:_schoolCode forKey:kCourseTimeListModelSchoolCode];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kCourseTimeListModelId];
    [aCoder encodeObject:_endTime forKey:kCourseTimeListModelEndTime];
    [aCoder encodeObject:_updateTime forKey:kCourseTimeListModelUpdateTime];
    [aCoder encodeObject:_internalBaseClassDescription forKey:kCourseTimeListModelDescription];
    [aCoder encodeObject:_startTime forKey:kCourseTimeListModelStartTime];
    [aCoder encodeDouble:_createTime forKey:kCourseTimeListModelCreateTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    CourseTimeListModel *copy = [[CourseTimeListModel alloc] init];
    
    if (copy) {

        copy.phase = self.phase;
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.endTime = [self.endTime copyWithZone:zone];
        copy.updateTime = [self.updateTime copyWithZone:zone];
        copy.internalBaseClassDescription = [self.internalBaseClassDescription copyWithZone:zone];
        copy.startTime = [self.startTime copyWithZone:zone];
        copy.createTime = self.createTime;
    }
    
    return copy;
}


@end
