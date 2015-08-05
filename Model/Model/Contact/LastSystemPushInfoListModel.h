//
//  LastSystemPushInfoListModel.h
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"

@class PushInfo;

@interface LastSystemPushInfoListModel : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) PushInfo *pushInfo;
@property (nonatomic, assign) double count;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
