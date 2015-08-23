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

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
