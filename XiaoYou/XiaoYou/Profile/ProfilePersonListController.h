//
//  ProfilePersonListController.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YViewController.h"

typedef NS_ENUM(int, PersonListType) {
    /**
     *  @author 李思良, 15-09-01
     *
     *  @brief  个人敬酒人列表
     */
    PersonListMyRespect     = 0,
    /**
     *  @author 李思良, 15-09-01
     *
     *  @brief  个人点赞人列表
     */
    PersonListMyCool        = 1,
    /**
     *  @author 李思良, 15-09-01
     *
     *  @brief  feed敬酒人列表
     */
    PersonListFeedRespect   = 2,
    /**
     *  @author,刘德胜
     */
    PersonListWhoJoinInThisActivity = 3
};

@interface ProfilePersonListController : YViewController
/**
 *  @author 李思良, 15-09-01
 *
 *  @brief  个人列表使用
 *
 */
- (id)initWithType:(int)type;
/**
 *  @author 李思良, 15-09-01
 *
 *  @brief  feed敬酒人列表使用
 */
- (id)initWithType:(int)type feedId:(NSString *)feedId;

@end
