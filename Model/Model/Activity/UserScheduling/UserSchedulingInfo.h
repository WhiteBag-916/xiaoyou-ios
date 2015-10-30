//
//  UserSchedulingInfo.h
//
//  Created by   on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface UserSchedulingInfo : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *opUser;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, assign) double endTime;
@property (nonatomic, assign) double updateTime;
@property (nonatomic, assign) double noticeTimePeriod;
@property (nonatomic, assign) double startTime;
@property (nonatomic, assign) double createTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
