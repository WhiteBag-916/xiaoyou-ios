//
//  SenderListModel.h
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface SenderListModel : YModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *flag;
@property (nonatomic, assign) double badgeValue;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *sendStudentNo;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
