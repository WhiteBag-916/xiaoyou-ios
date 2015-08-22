//
//  LinkManList.h
//
//  Created by HuiYin  on 15/8/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LinkManList : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double linkManListIdentifier;
@property (nonatomic, strong) NSString *faculty;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, strong) NSString *thirdCode;
@property (nonatomic, strong) NSString *studentNo;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *college;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *isShield;
@property (nonatomic, strong) NSString *isRemind;
@property (nonatomic, assign) double linkType;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gender;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
