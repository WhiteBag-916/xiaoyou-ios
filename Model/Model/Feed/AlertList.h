//
//  AlertList.h
//
//  Created by   on 15/8/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface AlertList : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL isRead;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) double affectId;
@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double lastReadTime;
@property (nonatomic, strong) NSString *hedPic;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
