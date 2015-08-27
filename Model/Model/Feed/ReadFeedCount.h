//
//  ReadFeedCount.h
//
//  Created by   on 15/8/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface ReadFeedCount : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double delCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
