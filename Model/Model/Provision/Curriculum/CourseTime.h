//
//  CourseTime.h
//
//  Created by   on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface CourseTime : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double phase;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, assign) double courseTimeIdentifier;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, assign) double updateTime;
@property (nonatomic, strong) NSString *courseTimeDescription;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, assign) double createTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
