//
//  ResultCommon.h
//
//  Created by   on 15/5/1
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFoundation.h"
#import "YModel+ActionMessage.h"

@interface ResultCommon : YModel <YModelActionMessage, NSCoding, NSCopying>

@property (nonatomic, assign) double code;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *url;//上传头像返回的url

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

