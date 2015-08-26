//
//  ProfilePersonListTableView.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"

typedef NS_ENUM(NSInteger, ProfilePersonListType) {
    ProfilePersonListTypeRespect = 0,
    ProfilePersonListTypeCool,
    ProfilePersonListTypeFind,              //找人
    ProfilePersonListTypeFeedPerson,        //人脉里的人
};

@interface ProfilePersonListTableView : YTableView
- (id)initWIthType:(int)type;
- (void)loadData;
- (void)loadDataWithFind:(NSDictionary *)condition;
- (void)loadDataWithQueryCode:(NSString *)queryCode;
- (void)loadDataWithFeedId:(NSString *)feedId;

@end
