//
//  ImageUploadModel.h
//
//  Created by   on 15/10/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface ImageUploadModel : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *snapImages;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
