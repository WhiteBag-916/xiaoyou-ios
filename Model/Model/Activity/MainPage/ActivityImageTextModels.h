//
//  ActivityImageTextModels.h
//
//  Created by   on 15/10/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface ActivityImageTextModels : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *opUser;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) double activityId;
@property (nonatomic, assign) double activityImageTextModelsIdentifier;
@property (nonatomic, assign) double updateTime;
@property (nonatomic, assign) double displayOrder;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) double createTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
