//
//  FindMyCourseViewModel.h
//
//  Created by   on 15/11/3
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FindMyCourseModel;

@interface FindMyCourseViewModel : NSObject<NSCopying>

@property (nonatomic, strong) NSString *courseName;
@property (nonatomic, strong) NSString *teacherGender;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, strong) NSString *courseYear;
@property (nonatomic, strong) NSString *courseCode;
@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, strong) NSString *courseSemester;
@property (nonatomic, strong) NSString *teacherName;
@property (nonatomic, assign) double endPhase;
@property (nonatomic, strong) NSString *teacherMajor;
@property (nonatomic, assign) BOOL evenodd;
@property (nonatomic, strong) NSString *roomCode;
@property (nonatomic, assign) double beginPhase;
@property (nonatomic, strong) NSString *teacherNo;
@property (nonatomic, assign) double endWeek;
@property (nonatomic, assign) double week;
@property (nonatomic, assign) double beginWeek;
@property (nonatomic, strong) NSString *departmentName;

- (instancetype)initByCourseModel:(FindMyCourseModel *)findMyCourseModel index:(NSInteger)listIndex;

@end
