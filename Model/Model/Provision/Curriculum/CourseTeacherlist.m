//
//  CourseTeacherlist.m
//
//  Created by   on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CourseTeacherlist.h"


NSString *const kCourseTeacherlistRoomName = @"roomName";
NSString *const kCourseTeacherlistTeacherMajor = @"teacherMajor";
NSString *const kCourseTeacherlistTeacherName = @"teacherName";
NSString *const kCourseTeacherlistEndPhase = @"endPhase";
NSString *const kCourseTeacherlistEvenodd = @"evenodd";
NSString *const kCourseTeacherlistRoomCode = @"roomCode";
NSString *const kCourseTeacherlistWeek = @"week";
NSString *const kCourseTeacherlistTeacherNo = @"teacherNo";
NSString *const kCourseTeacherlistBeginPhase = @"beginPhase";
NSString *const kCourseTeacherlistBeginWeek = @"beginWeek";
NSString *const kCourseTeacherlistTeacherGender = @"teacherGender";
NSString *const kCourseTeacherlistEndWeek = @"endWeek";


@interface CourseTeacherlist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CourseTeacherlist

@synthesize roomName = _roomName;
@synthesize teacherMajor = _teacherMajor;
@synthesize teacherName = _teacherName;
@synthesize endPhase = _endPhase;
@synthesize evenodd = _evenodd;
@synthesize roomCode = _roomCode;
@synthesize week = _week;
@synthesize teacherNo = _teacherNo;
@synthesize beginPhase = _beginPhase;
@synthesize beginWeek = _beginWeek;
@synthesize teacherGender = _teacherGender;
@synthesize endWeek = _endWeek;


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
            self.roomName = [self objectOrNilForKey:kCourseTeacherlistRoomName fromDictionary:dict];
            self.teacherMajor = [self objectOrNilForKey:kCourseTeacherlistTeacherMajor fromDictionary:dict];
            self.teacherName = [self objectOrNilForKey:kCourseTeacherlistTeacherName fromDictionary:dict];
            self.endPhase = [[self objectOrNilForKey:kCourseTeacherlistEndPhase fromDictionary:dict] doubleValue];
            self.evenodd = [[self objectOrNilForKey:kCourseTeacherlistEvenodd fromDictionary:dict] boolValue];
            self.roomCode = [self objectOrNilForKey:kCourseTeacherlistRoomCode fromDictionary:dict];
            self.week = [[self objectOrNilForKey:kCourseTeacherlistWeek fromDictionary:dict] doubleValue];
            self.teacherNo = [self objectOrNilForKey:kCourseTeacherlistTeacherNo fromDictionary:dict];
            self.beginPhase = [[self objectOrNilForKey:kCourseTeacherlistBeginPhase fromDictionary:dict] doubleValue];
            self.beginWeek = [[self objectOrNilForKey:kCourseTeacherlistBeginWeek fromDictionary:dict] doubleValue];
            self.teacherGender = [self objectOrNilForKey:kCourseTeacherlistTeacherGender fromDictionary:dict];
            self.endWeek = [[self objectOrNilForKey:kCourseTeacherlistEndWeek fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.roomName forKey:kCourseTeacherlistRoomName];
    [mutableDict setValue:self.teacherMajor forKey:kCourseTeacherlistTeacherMajor];
    [mutableDict setValue:self.teacherName forKey:kCourseTeacherlistTeacherName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endPhase] forKey:kCourseTeacherlistEndPhase];
    [mutableDict setValue:[NSNumber numberWithBool:self.evenodd] forKey:kCourseTeacherlistEvenodd];
    [mutableDict setValue:self.roomCode forKey:kCourseTeacherlistRoomCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.week] forKey:kCourseTeacherlistWeek];
    [mutableDict setValue:self.teacherNo forKey:kCourseTeacherlistTeacherNo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.beginPhase] forKey:kCourseTeacherlistBeginPhase];
    [mutableDict setValue:[NSNumber numberWithDouble:self.beginWeek] forKey:kCourseTeacherlistBeginWeek];
    [mutableDict setValue:self.teacherGender forKey:kCourseTeacherlistTeacherGender];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endWeek] forKey:kCourseTeacherlistEndWeek];

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

    self.roomName = [aDecoder decodeObjectForKey:kCourseTeacherlistRoomName];
    self.teacherMajor = [aDecoder decodeObjectForKey:kCourseTeacherlistTeacherMajor];
    self.teacherName = [aDecoder decodeObjectForKey:kCourseTeacherlistTeacherName];
    self.endPhase = [aDecoder decodeDoubleForKey:kCourseTeacherlistEndPhase];
    self.evenodd = [aDecoder decodeBoolForKey:kCourseTeacherlistEvenodd];
    self.roomCode = [aDecoder decodeObjectForKey:kCourseTeacherlistRoomCode];
    self.week = [aDecoder decodeDoubleForKey:kCourseTeacherlistWeek];
    self.teacherNo = [aDecoder decodeObjectForKey:kCourseTeacherlistTeacherNo];
    self.beginPhase = [aDecoder decodeDoubleForKey:kCourseTeacherlistBeginPhase];
    self.beginWeek = [aDecoder decodeDoubleForKey:kCourseTeacherlistBeginWeek];
    self.teacherGender = [aDecoder decodeObjectForKey:kCourseTeacherlistTeacherGender];
    self.endWeek = [aDecoder decodeDoubleForKey:kCourseTeacherlistEndWeek];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_roomName forKey:kCourseTeacherlistRoomName];
    [aCoder encodeObject:_teacherMajor forKey:kCourseTeacherlistTeacherMajor];
    [aCoder encodeObject:_teacherName forKey:kCourseTeacherlistTeacherName];
    [aCoder encodeDouble:_endPhase forKey:kCourseTeacherlistEndPhase];
    [aCoder encodeBool:_evenodd forKey:kCourseTeacherlistEvenodd];
    [aCoder encodeObject:_roomCode forKey:kCourseTeacherlistRoomCode];
    [aCoder encodeDouble:_week forKey:kCourseTeacherlistWeek];
    [aCoder encodeObject:_teacherNo forKey:kCourseTeacherlistTeacherNo];
    [aCoder encodeDouble:_beginPhase forKey:kCourseTeacherlistBeginPhase];
    [aCoder encodeDouble:_beginWeek forKey:kCourseTeacherlistBeginWeek];
    [aCoder encodeObject:_teacherGender forKey:kCourseTeacherlistTeacherGender];
    [aCoder encodeDouble:_endWeek forKey:kCourseTeacherlistEndWeek];
}

- (id)copyWithZone:(NSZone *)zone
{
    CourseTeacherlist *copy = [[CourseTeacherlist alloc] init];
    
    if (copy) {

        copy.roomName = [self.roomName copyWithZone:zone];
        copy.teacherMajor = [self.teacherMajor copyWithZone:zone];
        copy.teacherName = [self.teacherName copyWithZone:zone];
        copy.endPhase = self.endPhase;
        copy.evenodd = self.evenodd;
        copy.roomCode = [self.roomCode copyWithZone:zone];
        copy.week = self.week;
        copy.teacherNo = [self.teacherNo copyWithZone:zone];
        copy.beginPhase = self.beginPhase;
        copy.beginWeek = self.beginWeek;
        copy.teacherGender = [self.teacherGender copyWithZone:zone];
        copy.endWeek = self.endWeek;
    }
    
    return copy;
}


@end
