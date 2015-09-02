//
//  ClassList.h
//
//  Created by   on 15/9/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface ClassList : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double gid;
@property (nonatomic, strong) NSString *thirdCode;
@property (nonatomic, strong) NSString *schoolCode;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *isRemind;
@property (nonatomic, assign) double linkType;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
