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

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

