//
//  BaseClass.h
//
//  Created by sheng  on 15/11/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"

@interface AvailableTimeModel : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *scheduling;
@property (nonatomic, assign) double availableBuilding;
@property (nonatomic, strong) NSArray *activityList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
