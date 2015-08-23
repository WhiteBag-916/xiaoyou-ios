//
//  Author.h
//
//  Created by   on 15/8/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"

@class Tags, ClassCodes, GroupCodes;

@interface Author : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, strong) NSString *headPic;
@property (nonatomic, strong) NSString *studentNo;
@property (nonatomic, strong) Tags *tagCodes;
@property (nonatomic, strong) ClassCodes *classCodes;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) GroupCodes *groupCodes;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
