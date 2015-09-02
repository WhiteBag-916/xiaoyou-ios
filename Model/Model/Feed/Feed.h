//
//  Feed.h
//
//  Created by   on 15/8/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface Feed : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double feedIdentifier;
@property (nonatomic, assign) double praiseCount;
@property (nonatomic, strong) NSString *sortOrder2;
@property (nonatomic, assign) double allCount;
@property (nonatomic, strong) NSString *sendGroupId;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *sortOrder1;
@property (nonatomic, assign) double commentCount;
@property (nonatomic, assign) double createTimeMiles;
@property (nonatomic, strong) NSString *sendId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) BOOL isPraise;
@property (nonatomic, strong) NSString *snapImg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
