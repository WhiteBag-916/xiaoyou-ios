//
//  Result.h
//
//  Created by   on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface Result : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double roomCount;
@property (nonatomic, strong) NSString *schoolArea;
@property (nonatomic, strong) NSString *buildName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
