//
//  Obj.h
//
//  Created by sheng  on 15/10/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"

@class ActivityPublishedModelTest;

@interface AvailableListModelTest : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) ActivityPublishedModelTest *activityPublishedModel;
@property (nonatomic, strong) NSArray *activityCoverageModels;
@property (nonatomic, strong) NSArray *activityImageTextModels;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
