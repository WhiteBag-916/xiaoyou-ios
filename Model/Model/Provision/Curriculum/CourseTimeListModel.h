//
//  CourseTimeListModel.h
//
//  Created by   on 15/10/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface CourseTimeListModel : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double phase;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *internalBaseClassDescription;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, assign) double createTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
