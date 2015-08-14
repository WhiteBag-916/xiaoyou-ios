//
//  LoginResp.h
//
//  Created by   on 15/7/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"

@interface LoginResp : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *studentName;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *college;
@property (nonatomic, strong) NSString *grad;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *admissionNo;
@property (nonatomic, strong) NSString *provinceCode;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, strong) NSString *identityCard;
@property (nonatomic, strong) NSString *schoolName;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *village;
@property (nonatomic, strong) NSString *studentNo;
@property (nonatomic, strong) NSString *streetCode;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, assign) double provisionInfoIdentifier;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *studentClass;
@property (nonatomic, strong) NSString *faculty;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
