//
//  CourseDetail.h
//
//  Created by   on 15/11/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface CourseDetail : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *unicode;
@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, assign) double week;
@property (nonatomic, assign) double begWeek;
@property (nonatomic, assign) double updateTime;
@property (nonatomic, strong) NSString *teacherGender;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, strong) NSString *departmentName;
@property (nonatomic, strong) NSString *teacherName;
@property (nonatomic, assign) double endTime;
@property (nonatomic, strong) NSString *teacherNo;
@property (nonatomic, assign) double endPhase;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *courseName;
@property (nonatomic, assign) double begPhase;
@property (nonatomic, assign) double weekPosition;
@property (nonatomic, strong) NSString *teacherMajor;
@property (nonatomic, assign) double endWeek;
@property (nonatomic, strong) NSString *roomCode;
@property (nonatomic, assign) double startTime;
@property (nonatomic, assign) double createTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
