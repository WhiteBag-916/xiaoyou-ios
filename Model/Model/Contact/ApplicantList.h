//
//  ApplicantList.h
//
//  Created by   on 15/8/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"

@class Author;

@interface ApplicantList : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double groupId;
@property (nonatomic, assign) double applyId;
@property (nonatomic, assign) double status;
@property (nonatomic, strong) Author *author;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
