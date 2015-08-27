//
//  GroupAllList.h
//
//  Created by   on 15/8/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface GroupAllList : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *groupList;
@property (nonatomic, strong) NSString *searchKey;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
