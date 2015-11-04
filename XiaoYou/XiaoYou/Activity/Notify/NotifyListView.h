//
//  NotifyListView.h
//  XiaoYou
//
//  Created by sheng on 15/11/2.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableView.h"
typedef enum : NSUInteger {
    SYSTEM_MESSAGE = 1,     //系统消息
    FRIEND_APPLY=2,         //好友申请
    GROUP_APPLY=3,          //社团申请
    ADD_COMMENT=4,          //feed评论
    ADD_PRAOSE=5,           //feed敬酒
    REPLY_COMMENT=6,        //回复评论
    REPLY_PRAOSE=7,         //评论敬酒
    FORBIDDEN_ME=8,         //对我消息不提醒
    UNFORBIDDEN_ME=9,       //解除对我消息不提醒
    KICKGROUP=10,           //踢出群
    DELETEUSER=11,          //被好友删除
    
#pragma mark 活动推送提醒
    ACTIVITY_PUSH=12,               //活动推送
    ACTIVITY_ENROLL_CHECK_PASS=13,  //活动报名审核通过
    ACTIVITY_ENROLL_NO_CHECK=14,    //活动报名审核未通过
    SCHEDULE_REMIND=15,             //用户自建日程提醒----
    ACTIVITY_ENROLL=16,             //用户报名活动提醒----
    ACTIVITY_PUBLISH=17,            //活动发布提醒,,,
    ACTIVITY_NOTIFY=18              //活动通知提醒
} MODEL_TYPE;
@interface NotifyListView : YTableView

@property (nonatomic,strong) NSMutableArray *notifyListArray;

@end
