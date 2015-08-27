//
//  GroupFeedList.h
//
//  Created by   on 15/8/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"

@class GroupModel;

@interface GroupFeedList : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) GroupModel *groupModel;
@property (nonatomic, strong) NSArray *groupFeeds;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
