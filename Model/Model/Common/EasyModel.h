//
//  EasyModel.h
//
//  Created by   on 15/8/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface EasyModel : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *noticeUrl;
@property (nonatomic, strong) NSString *time;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
