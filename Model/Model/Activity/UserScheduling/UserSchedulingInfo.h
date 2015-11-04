//
//  UserSchedulingInfo.h
//
//  Created by   on 15/11/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface UserSchedulingInfo : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *opUser;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) double updateTime;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) double endTime;
@property (nonatomic, assign) double noticeTimePeriod;
@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double startTime;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *content;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
