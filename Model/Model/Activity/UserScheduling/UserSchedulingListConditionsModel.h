//
//  UserSchedulingListConditionsModel.h
//
//  Created by   on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface UserSchedulingListConditionsModel : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double datePeriod;
@property (nonatomic, strong) NSString *notifyShowContent;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
