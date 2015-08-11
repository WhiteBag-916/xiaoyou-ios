//
//  GroupListModel.h
//
//  Created by HuiYin  on 15/8/11
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface GroupListModel : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *groupIcon;
@property (nonatomic, strong) NSString *groupType;
@property (nonatomic, strong) NSString *groupTypeName;
@property (nonatomic, assign) BOOL isChat;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
