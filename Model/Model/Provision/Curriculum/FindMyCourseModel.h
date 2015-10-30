//
//  FindMyCourseModel.h
//
//  Created by   on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface FindMyCourseModel : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *courseYear;
@property (nonatomic, strong) NSString *courseSemester;
@property (nonatomic, strong) NSString *courseName;
@property (nonatomic, strong) NSString *courseCode;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, strong) NSArray *courseTeacherlist;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
