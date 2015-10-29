//
//  FreeBuildingDetailModel.h
//
//  Created by   on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface FreeBuildingDetailModel : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, strong) NSString *roomCode;
@property (nonatomic, strong) NSArray *courseLists;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
