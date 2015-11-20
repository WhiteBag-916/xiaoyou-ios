//
//  CheckLastVersionModel.h
//
//  Created by   on 15/11/18
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface CheckLastVersionModel : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double releaseTime;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, assign) BOOL compulsoryRenewal;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *appPath;
@property (nonatomic, strong) NSString *about;
@property (nonatomic, strong) NSString *appPlatform;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
