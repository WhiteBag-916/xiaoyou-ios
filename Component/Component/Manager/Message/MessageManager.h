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
} PUSH_Message_TYPE;

@interface MessageManager : YManager<YManager>
AS_SINGLETON(MessageManager);

- (void)getMessageListData:(ActionCompleteBlock)block;
//获取发送建议
- (void)getSuggestList:(ActionCompleteBlock)block;;
// 统计未读消息数
-(void)setupUnreadMessageCount;

//删除会话
- (void)delConversationByChatter:(NSString *)chatter;

@end
