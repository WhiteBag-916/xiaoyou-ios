//
//  ActivityDetailModel.h
//
//  Created by   on 15/10/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"
#import "ActivityOrganizer.h"
#import "ActivityTypeInfo.h"
#import "ActivityInfoModel.h"

@interface ActivityDetailModel : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL enroll;
@property (nonatomic, strong) NSArray *enrollActivityUserInfos;
@property (nonatomic, strong) ActivityOrganizer *activityOrganizer;
@property (nonatomic, strong) ActivityTypeInfo *activityTypeInfo;
@property (nonatomic, strong) ActivityInfoModel *activityPublishedDto;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
