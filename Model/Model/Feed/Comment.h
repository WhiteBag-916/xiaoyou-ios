//
//  Comment.h
//
//  Created by   on 15/8/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface Comment : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double replyCount;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) double commentIdentifier;
@property (nonatomic, assign) double feedId;
@property (nonatomic, assign) double praiseCount;
@property (nonatomic, assign) id toUserId;
@property (nonatomic, assign) double createTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
