//
//  FriendsCondition.h
//
//  Created by   on 15/8/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface FriendsCondition : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *pramsName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
