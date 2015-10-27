//
//  ActivityCoverageModels.h
//
//  Created by   on 15/10/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface ActivityCoverageModels : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double activityId;
@property (nonatomic, strong) NSString *coverageType;
@property (nonatomic, assign) double activityCoverageModelsIdentifier;
@property (nonatomic, assign) double updateTime;
@property (nonatomic, assign) BOOL isRepeatPush;
@property (nonatomic, strong) NSString *pushStatus;
@property (nonatomic, strong) NSString *coverage;
@property (nonatomic, assign) double createTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
