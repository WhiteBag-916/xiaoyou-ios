//
//  CourseTimeListModel.h
//
//  Created by   on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface CourseTimeListModel : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *firstTime;
@property (nonatomic, assign) double maxWeek;
@property (nonatomic, strong) NSArray *courseTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
