//
//  NewsList.h
//
//  Created by   on 15/11/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface NewsList : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, assign) double publishTime;
@property (nonatomic, assign) double updateTime;
@property (nonatomic, assign) double newsListIdentifier;
@property (nonatomic, strong) NSString *coverImg;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, assign) double publishDay;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) double createTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
