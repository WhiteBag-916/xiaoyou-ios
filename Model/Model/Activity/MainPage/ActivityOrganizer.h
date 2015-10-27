//
//  ActivityOrganizer.h
//
//  Created by   on 15/10/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface ActivityOrganizer : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *headPic;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *userType;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
