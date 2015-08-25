//
//  FeedDetail.h
//
//  Created by   on 15/8/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"

@class Feed, Author;

@interface FeedDetail : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *commentListItems;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) Feed *feed;
@property (nonatomic, strong) Author *author;
@property (nonatomic, strong) NSArray *praisePeoples;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
