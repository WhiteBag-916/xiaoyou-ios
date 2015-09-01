//
//  SuggestListModel.h
//
//  Created by HuiYin  on 15/9/1
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface SuggestListModel : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *suggest;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
