//
//  RemindInfo.h
//  Model
//
//  Created by sheng on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YModel.h"

@interface RemindInfo : YModel<NSCoding, NSCopying>

@property (nonatomic,copy) NSString *remindTimeString;
@property (nonatomic,copy) NSString *headImageUrl;
@property (nonatomic,copy) NSString *remindTitle;
@property (nonatomic,copy) NSString *remindName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
