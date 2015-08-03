//
//  LoginResp.h
//
//  Created by   on 15/7/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFoundation.h"
#import "YModel+ActionMessage.h"

@interface LoginResp : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *studentName;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *college;
@property (nonatomic, strong) NSString *grad;
@property (nonatomic, assign) id country;
@property (nonatomic, assign) id admissionNo;
@property (nonatomic, strong) NSString *provinceCode;
@property (nonatomic, assign) id countryCode;
@property (nonatomic, assign) id street;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, strong) NSString *identityCard;
@property (nonatomic, strong) NSString *schoolName;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, assign) id village;
@property (nonatomic, strong) NSString *studentNo;
@property (nonatomic, assign) id streetCode;
@property (nonatomic, assign) id score;
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
