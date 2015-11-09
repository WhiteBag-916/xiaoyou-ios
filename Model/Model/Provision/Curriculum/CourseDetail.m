//
//  CourseDetail.m
//
//  Created by   on 15/11/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CourseDetail.h"


NSString *const kCourseDetailUnicode = @"unicode";
NSString *const kCourseDetailRoomName = @"roomName";
NSString *const kCourseDetailWeek = @"week";
NSString *const kCourseDetailBegWeek = @"begWeek";
NSString *const kCourseDetailUpdateTime = @"updateTime";
NSString *const kCourseDetailTeacherGender = @"teacherGender";
NSString *const kCourseDetailSchoolCode = @"schoolCode";
NSString *const kCourseDetailDepartmentName = @"instituteName";
NSString *const kCourseDetailTeacherName = @"teacherName";
NSString *const kCourseDetailEndTime = @"endTime";
NSString *const kCourseDetailTeacherNo = @"teacherNo";
NSString *const kCourseDetailEndPhase = @"endPhase";
NSString *const kCourseDetailId = @"id";
NSString *const kCourseDetailCourseName = @"courseName";
NSString *const kCourseDetailBegPhase = @"begPhase";
NSString *const kCourseDetailWeekPosition = @"weekPosition";
NSString *const kCourseDetailTeacherMajor = @"teacherMajor";
NSString *const kCourseDetailEndWeek = @"endWeek";
NSString *const kCourseDetailRoomCode = @"roomCode";
NSString *const kCourseDetailStartTime = @"startTime";
NSString *const kCourseDetailCreateTime = @"createTime";


@interface CourseDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CourseDetail

@synthesize unicode = _unicode;
@synthesize roomName = _roomName;
@synthesize week = _week;
@synthesize begWeek = _begWeek;
@synthesize updateTime = _updateTime;
@synthesize teacherGender = _teacherGender;
@synthesize schoolCode = _schoolCode;
@synthesize departmentName = _departmentName;
@synthesize teacherName = _teacherName;
@synthesize endTime = _endTime;
@synthesize teacherNo = _teacherNo;
@synthesize endPhase = _endPhase;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize courseName = _courseName;
@synthesize begPhase = _begPhase;
@synthesize weekPosition = _weekPosition;
@synthesize teacherMajor = _teacherMajor;
@synthesize endWeek = _endWeek;
@synthesize roomCode = _roomCode;
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
            self.unicode = [self objectOrNilForKey:kCourseDetailUnicode fromDictionary:dict];
            self.roomName = [self objectOrNilForKey:kCourseDetailRoomName fromDictionary:dict];
            self.week = [[self objectOrNilForKey:kCourseDetailWeek fromDictionary:dict] doubleValue];
            self.begWeek = [[self objectOrNilForKey:kCourseDetailBegWeek fromDictionary:dict] doubleValue];
            self.updateTime = [[self objectOrNilForKey:kCourseDetailUpdateTime fromDictionary:dict] doubleValue];
            self.teacherGender = [self objectOrNilForKey:kCourseDetailTeacherGender fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kCourseDetailSchoolCode fromDictionary:dict];
            self.departmentName = [self objectOrNilForKey:kCourseDetailDepartmentName fromDictionary:dict];
            self.teacherName = [self objectOrNilForKey:kCourseDetailTeacherName fromDictionary:dict];
            self.endTime = [[self objectOrNilForKey:kCourseDetailEndTime fromDictionary:dict] doubleValue];
            self.teacherNo = [self objectOrNilForKey:kCourseDetailTeacherNo fromDictionary:dict];
            self.endPhase = [[self objectOrNilForKey:kCourseDetailEndPhase fromDictionary:dict] doubleValue];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kCourseDetailId fromDictionary:dict] doubleValue];
            self.courseName = [self objectOrNilForKey:kCourseDetailCourseName fromDictionary:dict];
            self.begPhase = [[self objectOrNilForKey:kCourseDetailBegPhase fromDictionary:dict] doubleValue];
            self.weekPosition = [[self objectOrNilForKey:kCourseDetailWeekPosition fromDictionary:dict] doubleValue];
            self.teacherMajor = [self objectOrNilForKey:kCourseDetailTeacherMajor fromDictionary:dict];
            self.endWeek = [[self objectOrNilForKey:kCourseDetailEndWeek fromDictionary:dict] doubleValue];
            self.roomCode = [self objectOrNilForKey:kCourseDetailRoomCode fromDictionary:dict];
            self.startTime = [[self objectOrNilForKey:kCourseDetailStartTime fromDictionary:dict] doubleValue];
            self.createTime = [[self objectOrNilForKey:kCourseDetailCreateTime fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.unicode forKey:kCourseDetailUnicode];
    [mutableDict setValue:self.roomName forKey:kCourseDetailRoomName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.week] forKey:kCourseDetailWeek];
    [mutableDict setValue:[NSNumber numberWithDouble:self.begWeek] forKey:kCourseDetailBegWeek];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateTime] forKey:kCourseDetailUpdateTime];
    [mutableDict setValue:self.teacherGender forKey:kCourseDetailTeacherGender];
    [mutableDict setValue:self.schoolCode forKey:kCourseDetailSchoolCode];
    [mutableDict setValue:self.departmentName forKey:kCourseDetailDepartmentName];
    [mutableDict setValue:self.teacherName forKey:kCourseDetailTeacherName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endTime] forKey:kCourseDetailEndTime];
    [mutableDict setValue:self.teacherNo forKey:kCourseDetailTeacherNo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endPhase] forKey:kCourseDetailEndPhase];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kCourseDetailId];
    [mutableDict setValue:self.courseName forKey:kCourseDetailCourseName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.begPhase] forKey:kCourseDetailBegPhase];
    [mutableDict setValue:[NSNumber numberWithDouble:self.weekPosition] forKey:kCourseDetailWeekPosition];
    [mutableDict setValue:self.teacherMajor forKey:kCourseDetailTeacherMajor];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endWeek] forKey:kCourseDetailEndWeek];
    [mutableDict setValue:self.roomCode forKey:kCourseDetailRoomCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startTime] forKey:kCourseDetailStartTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kCourseDetailCreateTime];

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

    self.unicode = [aDecoder decodeObjectForKey:kCourseDetailUnicode];
    self.roomName = [aDecoder decodeObjectForKey:kCourseDetailRoomName];
    self.week = [aDecoder decodeDoubleForKey:kCourseDetailWeek];
    self.begWeek = [aDecoder decodeDoubleForKey:kCourseDetailBegWeek];
    self.updateTime = [aDecoder decodeDoubleForKey:kCourseDetailUpdateTime];
    self.teacherGender = [aDecoder decodeObjectForKey:kCourseDetailTeacherGender];
    self.schoolCode = [aDecoder decodeObjectForKey:kCourseDetailSchoolCode];
    self.departmentName = [aDecoder decodeObjectForKey:kCourseDetailDepartmentName];
    self.teacherName = [aDecoder decodeObjectForKey:kCourseDetailTeacherName];
    self.endTime = [aDecoder decodeDoubleForKey:kCourseDetailEndTime];
    self.teacherNo = [aDecoder decodeObjectForKey:kCourseDetailTeacherNo];
    self.endPhase = [aDecoder decodeDoubleForKey:kCourseDetailEndPhase];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kCourseDetailId];
    self.courseName = [aDecoder decodeObjectForKey:kCourseDetailCourseName];
    self.begPhase = [aDecoder decodeDoubleForKey:kCourseDetailBegPhase];
    self.weekPosition = [aDecoder decodeDoubleForKey:kCourseDetailWeekPosition];
    self.teacherMajor = [aDecoder decodeObjectForKey:kCourseDetailTeacherMajor];
    self.endWeek = [aDecoder decodeDoubleForKey:kCourseDetailEndWeek];
    self.roomCode = [aDecoder decodeObjectForKey:kCourseDetailRoomCode];
    self.startTime = [aDecoder decodeDoubleForKey:kCourseDetailStartTime];
    self.createTime = [aDecoder decodeDoubleForKey:kCourseDetailCreateTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_unicode forKey:kCourseDetailUnicode];
    [aCoder encodeObject:_roomName forKey:kCourseDetailRoomName];
    [aCoder encodeDouble:_week forKey:kCourseDetailWeek];
    [aCoder encodeDouble:_begWeek forKey:kCourseDetailBegWeek];
    [aCoder encodeDouble:_updateTime forKey:kCourseDetailUpdateTime];
    [aCoder encodeObject:_teacherGender forKey:kCourseDetailTeacherGender];
    [aCoder encodeObject:_schoolCode forKey:kCourseDetailSchoolCode];
    [aCoder encodeObject:_departmentName forKey:kCourseDetailDepartmentName];
    [aCoder encodeObject:_teacherName forKey:kCourseDetailTeacherName];
    [aCoder encodeDouble:_endTime forKey:kCourseDetailEndTime];
    [aCoder encodeObject:_teacherNo forKey:kCourseDetailTeacherNo];
    [aCoder encodeDouble:_endPhase forKey:kCourseDetailEndPhase];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kCourseDetailId];
    [aCoder encodeObject:_courseName forKey:kCourseDetailCourseName];
    [aCoder encodeDouble:_begPhase forKey:kCourseDetailBegPhase];
    [aCoder encodeDouble:_weekPosition forKey:kCourseDetailWeekPosition];
    [aCoder encodeObject:_teacherMajor forKey:kCourseDetailTeacherMajor];
    [aCoder encodeDouble:_endWeek forKey:kCourseDetailEndWeek];
    [aCoder encodeObject:_roomCode forKey:kCourseDetailRoomCode];
    [aCoder encodeDouble:_startTime forKey:kCourseDetailStartTime];
    [aCoder encodeDouble:_createTime forKey:kCourseDetailCreateTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    CourseDetail *copy = [[CourseDetail alloc] init];
    
    if (copy) {

        copy.unicode = [self.unicode copyWithZone:zone];
        copy.roomName = [self.roomName copyWithZone:zone];
        copy.week = self.week;
        copy.begWeek = self.begWeek;
        copy.updateTime = self.updateTime;
        copy.teacherGender = [self.teacherGender copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.departmentName = [self.departmentName copyWithZone:zone];
        copy.teacherName = [self.teacherName copyWithZone:zone];
        copy.endTime = self.endTime;
        copy.teacherNo = [self.teacherNo copyWithZone:zone];
        copy.endPhase = self.endPhase;
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.courseName = [self.courseName copyWithZone:zone];
        copy.begPhase = self.begPhase;
        copy.weekPosition = self.weekPosition;
        copy.teacherMajor = [self.teacherMajor copyWithZone:zone];
        copy.endWeek = self.endWeek;
        copy.roomCode = [self.roomCode copyWithZone:zone];
        copy.startTime = self.startTime;
        copy.createTime = self.createTime;
    }
    
    return copy;
}


@end
