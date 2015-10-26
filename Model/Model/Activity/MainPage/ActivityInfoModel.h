//
//  ActivityInfoModel.h
//
//  Created by   on 15/10/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityPublishedModel.h"
#import "YModel.h"


@interface ActivityInfoModel : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *activityImageTextModels;
@property (nonatomic, strong) ActivityPublishedModel *activityPublishedModel;
@property (nonatomic, strong) NSArray *activityCoverageModels;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
