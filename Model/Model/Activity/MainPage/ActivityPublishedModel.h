//
//  ActivityPublishedModel.h
//
//  Created by sheng  on 15/10/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface ActivityPublishedModel : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL enrollCheck;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, assign) double actStartTime;
@property (nonatomic, strong) NSString *actCreateUserSource;
@property (nonatomic, assign) double updateTime;
@property (nonatomic, assign) BOOL enroll;
@property (nonatomic, assign) double enrollEndTime;
@property (nonatomic, strong) NSString *actCreateUserId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double version;
@property (nonatomic, strong) NSString *activityDirection;
@property (nonatomic, assign) double activityId;
@property (nonatomic, strong) NSString *checkOperator;
@property (nonatomic, assign) double activityPublishedModelIdentifier;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) double actEndTime;
@property (nonatomic, strong) NSString *checkType;
@property (nonatomic, strong) NSString *publishType;
@property (nonatomic, strong) NSString *opUser;
@property (nonatomic, assign) double enrollStartTime;
@property (nonatomic, strong) NSString *checkStatus;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *address;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
