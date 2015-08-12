//
//  Groups.h
//
//  Created by HuiYin  on 15/8/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"



@interface Groups : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *groupName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
