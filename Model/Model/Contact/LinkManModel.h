//
//  LinkManModel.h
//
//  Created by HuiYin  on 15/8/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface LinkManModel : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *classList;
@property (nonatomic, strong) NSArray *linkManList;
@property (nonatomic, strong) NSArray *unionList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
