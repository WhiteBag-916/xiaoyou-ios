//
//  CourseTeacherlist.h
//
//  Created by   on 15/11/3
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface CourseTeacherlist : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, strong) NSString *teacherMajor;
@property (nonatomic, strong) NSString *teacherName;
@property (nonatomic, assign) double endPhase;
@property (nonatomic, assign) BOOL evenodd;
@property (nonatomic, strong) NSString *roomCode;
@property (nonatomic, assign) double week;
@property (nonatomic, strong) NSString *teacherNo;
@property (nonatomic, assign) double beginPhase;
@property (nonatomic, assign) double beginWeek;
@property (nonatomic, strong) NSString *teacherGender;
@property (nonatomic, assign) double endWeek;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
