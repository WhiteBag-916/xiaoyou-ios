//
//  GroupDetail.h
//
//  Created by   on 15/8/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"

@class GroupModel;

@interface GroupDetail : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *groupMemebers;
@property (nonatomic, strong) GroupModel *groupModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
