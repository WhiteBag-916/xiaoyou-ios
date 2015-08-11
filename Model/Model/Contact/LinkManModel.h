//
//  LinkManModel.h
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface LinkManModel : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *faculty;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *college;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *linkStudentName;
@property (nonatomic, strong) NSString *grad;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *studentClass;
@property (nonatomic, strong) NSString *isShield;
@property (nonatomic, strong) NSString *linkStudentNo;
@property (nonatomic, strong) NSString *isRemind;
@property (nonatomic, strong) NSString *schoolName;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *myStudentNo;

@property (nonatomic, strong) NSString *studentName;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *provinceCode;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *identityCard;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *village;
@property (nonatomic, strong) NSString *streetCode;
@property (nonatomic, strong) NSString *studentNo;
@property (nonatomic, assign) NSString *token;
@property (nonatomic, strong) NSString *cityCode;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
