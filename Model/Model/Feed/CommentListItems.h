//
//  CommentListItems.h
//
//  Created by   on 15/8/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"

@class Comment, Author;

@interface CommentListItems : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) Comment *comment;
@property (nonatomic, strong) Author *author;
@property (nonatomic, strong) Author *replyUser;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
