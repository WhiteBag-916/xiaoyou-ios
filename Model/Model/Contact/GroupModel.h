//
//  GroupModel.h
//
//  Created by   on 15/8/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface GroupModel : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double groupModelIdentifier;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, strong) NSString *groupModelDescription;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *groupIcon;
@property (nonatomic, strong) NSString *hot;
@property (nonatomic, strong) NSString *keyWords;
@property (nonatomic, strong) NSString *schoolName;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *thirdId;
@property (nonatomic, strong) NSString *cacheVersion;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
