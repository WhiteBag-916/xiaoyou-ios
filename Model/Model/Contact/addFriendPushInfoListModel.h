//
//  addFriendPushInfoListModel.h
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface addFriendPushInfoListModel : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double idRead;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *isRemind;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *sendstudentNo;
@property (nonatomic, assign) double flag;
@property (nonatomic, strong) NSString *relation;
@property (nonatomic, strong) NSString *reciveStudentNo;
@property (nonatomic, strong) NSString *isDel;
@property (nonatomic, strong) NSString *isSheild;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
