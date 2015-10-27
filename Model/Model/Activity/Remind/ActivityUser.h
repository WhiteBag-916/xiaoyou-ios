//
//  ActivityUser.h
//
//  Created by sheng  on 15/10/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityCode, ProvinceCode;

@interface ActivityUser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *faculty;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSArray *tagCodes;
@property (nonatomic, strong) NSArray *groupCodes;
@property (nonatomic, strong) NSString *studentNo;
@property (nonatomic, strong) CityCode *cityCode;
@property (nonatomic, strong) NSString *college;
@property (nonatomic, strong) NSString *grad;
@property (nonatomic, strong) NSArray *propetiesCommon;
@property (nonatomic, strong) NSString *friendStatus;
@property (nonatomic, strong) NSArray *tagsCommon;
@property (nonatomic, strong) ProvinceCode *provinceCode;
@property (nonatomic, strong) NSArray *classCodes;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *headPic;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
