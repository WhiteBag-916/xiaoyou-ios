//
//  ProfileInfo.h
//
//  Created by   on 15/8/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface ProfileInfo : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *tagModels;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *selfIntro;
@property (nonatomic, assign) double praiseCount;
@property (nonatomic, strong) NSArray *feedInfo;
@property (nonatomic, assign) double commentCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
