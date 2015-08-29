//
//  ForbiddenList.h
//
//  Created by   on 15/8/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface ForbiddenList : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *forbiddenList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
