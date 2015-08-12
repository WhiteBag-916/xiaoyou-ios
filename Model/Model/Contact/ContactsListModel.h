//
//  ContactsListModel.h
//
//  Created by HuiYin  on 15/8/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"



@interface ContactsListModel : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *friendList;
@property (nonatomic, strong) NSArray *groupList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
