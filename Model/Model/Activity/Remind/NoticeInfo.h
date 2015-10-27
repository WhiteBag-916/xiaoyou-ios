//
//  Obj.h
//
//  Created by sheng  on 15/10/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"
#import "ProfileInfo.h"

@interface NoticeInfo :  YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double enrollTime;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *activityOrganizer;
@property (nonatomic, assign) BOOL activityOwner;
@property (nonatomic, assign) double activityPublishedId;
@property (nonatomic, strong) NSString *activityName;
@property (nonatomic, assign) double activityEndTime;
@property (nonatomic, strong) NSString *checkStatus;
@property (nonatomic, assign) double activityStartTime;
@property (nonatomic, strong) ProfileInfo *activityUser;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
