//
//  ProfilePersonListController.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YViewController.h"

typedef NS_ENUM(int, PersonListType) {
    PersonListMyRespect     = 0,
    PersonListMyCool        = 1,
    PersonListFeedRespect   = 2,
    PersonListOtherCool     = 3,
};

@interface ProfilePersonListController : YViewController

- (id)initWithType:(int)type;

- (id)initWithType:(int)type feedId:(NSString *)feedId;

@end
