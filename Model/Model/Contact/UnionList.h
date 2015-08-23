//
//  UnionList.h
//
//  Created by HuiYin  on 15/8/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface UnionList : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double unionListIdentifier;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *thirdCode;
@property (nonatomic, assign) double linkType;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
