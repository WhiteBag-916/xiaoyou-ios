//
//  ProfileInfo.h
//
//  Created by   on 15/8/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface ProfileInfo : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *tagModels;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, strong) NSString *headPic;
@property (nonatomic, strong) NSString *selfIntro;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *studentNo;
@property (nonatomic, assign) double praiseCount;
@property (nonatomic, strong) NSArray *lastFeeds;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, assign) double commentCount;
@property (nonatomic, assign) double coolCount;
@property (nonatomic, strong) NSArray *tagsCommon;
@property (nonatomic, strong) NSArray *propetiesCommon;
@property (nonatomic, assign) double feedCount;
@property (nonatomic, assign) BOOL isCool;
@property (nonatomic, strong) NSArray *queryCodes;
@property (nonatomic, strong) NSArray *managerGroups;
@property (nonatomic, assign) double unreadAlterCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
