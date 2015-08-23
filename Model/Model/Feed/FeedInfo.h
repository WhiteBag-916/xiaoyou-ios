//
//  FeedInfo.h
//
//  Created by   on 15/8/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"

@class Author, Feed;

@interface FeedInfo : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) Author *author;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) Feed *feed;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
