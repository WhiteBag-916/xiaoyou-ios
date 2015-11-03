//
//  FindMyCourseViewModel.m
//
//  Created by   on 15/11/3
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FindMyCourseViewModel.h"
#import "FindMyCourseModel.h"
#import "CourseTeacherlist.h"

@interface FindMyCourseViewModel ()


@end

@implementation FindMyCourseViewModel

@synthesize courseName = _courseName;
@synthesize teacherGender = _teacherGender;
@synthesize schoolCode = _schoolCode;
@synthesize courseYear = _courseYear;
@synthesize courseCode = _courseCode;
@synthesize roomName = _roomName;
@synthesize courseSemester = _courseSemester;
@synthesize teacherName = _teacherName;
@synthesize endPhase = _endPhase;
@synthesize teacherMajor = _teacherMajor;
@synthesize evenodd = _evenodd;
@synthesize roomCode = _roomCode;
@synthesize beginPhase = _beginPhase;
@synthesize teacherNo = _teacherNo;
@synthesize endWeek = _endWeek;
@synthesize week = _week;
@synthesize beginWeek = _beginWeek;
@synthesize departmentName = _departmentName;

- (instancetype)initByCourseModel:(FindMyCourseModel *)findMyCourseModel index:(NSInteger)listIndex {
    if (self = [super init]) {
        self.courseName = findMyCourseModel.courseName;
        self.courseYear = findMyCourseModel.courseYear;
        self.courseSemester = findMyCourseModel.courseSemester;
        self.courseCode = findMyCourseModel.courseCode;
        self.schoolCode = findMyCourseModel.schoolCode;
        self.departmentName = findMyCourseModel.departmentName;
        
        CourseTeacherlist *list = findMyCourseModel.courseTeacherlist[listIndex];
        self.roomName = list.roomName;
        self.teacherMajor = list.teacherMajor;
        self.teacherName = list.teacherName;
        self.endPhase = list.endPhase;
        self.evenodd = list.evenodd;
        self.roomCode = list.roomCode;
        self.week = list.week;
        self.teacherNo = list.teacherNo;
        self.beginPhase = list.beginPhase;
        self.beginWeek = list.beginWeek;
        self.teacherGender = list.teacherGender;
        self.endWeek = list.endWeek;
        
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    FindMyCourseViewModel *copy = [[FindMyCourseViewModel alloc] init];
    
    if (copy) {
        
        copy.courseName = [self.courseName copyWithZone:zone];
        copy.teacherGender = [self.teacherGender copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.courseYear = [self.courseYear copyWithZone:zone];
        copy.courseCode = [self.courseCode copyWithZone:zone];
        copy.roomName = [self.roomName copyWithZone:zone];
        copy.courseSemester = [self.courseSemester copyWithZone:zone];
        copy.teacherName = [self.teacherName copyWithZone:zone];
        copy.endPhase = self.endPhase;
        copy.teacherMajor = [self.teacherMajor copyWithZone:zone];
        copy.evenodd = self.evenodd;
        copy.roomCode = [self.roomCode copyWithZone:zone];
        copy.beginPhase = self.beginPhase;
        copy.teacherNo = [self.teacherNo copyWithZone:zone];
        copy.endWeek = self.endWeek;
        copy.week = self.week;
        copy.beginWeek = self.beginWeek;
        copy.departmentName = [self.departmentName copyWithZone:zone];
    }
    
    return copy;
}


@end
