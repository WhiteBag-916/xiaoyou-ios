//
//  Author.h
//
//  Created by   on 15/8/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"

@class ProvinceCode;

@interface Author : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) ProvinceCode *provinceCode;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, strong) NSArray *tagsCommon;//Tags
@property (nonatomic, strong) NSString *headPic;
@property (nonatomic, strong) NSString *tagCodes;
@property (nonatomic, strong) NSString *studentNo;
@property (nonatomic, strong) NSArray *propetiesCommon;//Tags
@property (nonatomic, strong) NSArray *classCodes;//ProvinceCode
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *groupCodes;//ProvinceCode
@property (nonatomic, strong) NSString *gender;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
