//
//  addFriendPushInfoListModel.h
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface addFriendPushInfoListModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double idRead;
@property (nonatomic, assign) id content;
@property (nonatomic, assign) id isRemind;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) id time;
@property (nonatomic, strong) NSString *sendstudentNo;
@property (nonatomic, assign) double flag;
@property (nonatomic, strong) NSString *relation;
@property (nonatomic, strong) NSString *reciveStudentNo;
@property (nonatomic, assign) id isDel;
@property (nonatomic, assign) id isSheild;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
