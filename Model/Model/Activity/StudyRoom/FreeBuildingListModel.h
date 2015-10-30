//
//  FreeBuildingListModel.h
//
//  Created by   on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface FreeBuildingListModel : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *filter;
@property (nonatomic, strong) NSArray *result;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
