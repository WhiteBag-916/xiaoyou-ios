//
//  FriendList.h
//
//  Created by HuiYin  on 15/8/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"



@interface FriendList : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userIcon;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSArray *relationship;
@property (nonatomic, strong) NSArray *groups;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
