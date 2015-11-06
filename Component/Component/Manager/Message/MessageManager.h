//
//  MessageManager.h
//  Component
//
//  Created by 熊宸 on 15/7/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YManager.h"
#import "YAction.h"

extern NSString *const KSYSTEM_MESSAGEID;
extern NSString *const KFRIEND_APPLYID;
extern NSString *const KGROUP_APPLYID;

//USER_SCHEDULING(15, "用户日程提醒"),
//ACTIVITY_ENROLL_CHECK_PASS(13, "活动报名审核提醒通过"),
//ACTIVITY_ENROLL_NO_CHECK(14, "活动报名审核提醒未通过"),
//ACTIVITY_ENROLL(16, "用户报名活动提醒"),
//ACTIVITY_PUBLISH(17, "活动发布提醒"),
//ACTIVITY_NOTIFY(18, "活动通知提醒");
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
    ACTIVITY_ENROLL_CHECK_PASS=13,  //活动报名审核通过
    ACTIVITY_ENROLL_NO_CHECK=14,    //活动报名审核未通过 铃铛
    SCHEDULE_REMIND=15,             //用户自建日程提醒----
    ACTIVITY_ENROLL=16,             //用户报名活动提醒----
    ACTIVITY_PUBLISH=17,            //活动发布提醒()
    ACTIVITY_NOTIFY=18              //活动通知提醒()
} PUSH_Message_TYPE;

typedef void (^ForbiddenGroupBlock)(BOOL isSuccess);

@interface MessageManager : YManager<YManager>
AS_SINGLETON(MessageManager);

- (void)getMessageListData:(ActionCompleteBlock)block;
//获取发送建议
- (void)getSuggestList:(ActionCompleteBlock)block;
// 统计未读消息数
-(void)setupUnreadMessageCount;

//删除会话
- (void)delConversationByChatter:(NSString *)chatter;

//设置群消息不提醒
- (void)forbiddenGroupByThirdCode:(NSString *)thirdCode block:(ForbiddenGroupBlock)block;

//判断是否已屏蔽
- (BOOL)isForbiddenGroupByThirdCode:(NSString *)thirdCode;

/*********************************************************************
 函数名称 :interestList
 函数描述 :好看接口列表查询
 参数 : publishDay:查询起始日期(yyyyMMdd) maxSize:查询数量(不传默认最多10天)
 返回值 : N/A
 作者 : XiongChen
 *********************************************************************/
- (void)interestList:(NSInteger)publishDay maxSize:(NSInteger)maxSize block:(ActionCompleteBlock)block;

@end
