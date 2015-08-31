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
    SYSTEM_MESSAGE = 1,
    FRIEND_APPLY=2,
    GROUP_APPLY=3,
    ADD_COMMENT=4,
    ADD_PRAOSE=5,
    REPLY_COMMENT=6,
    REPLY_PRAOSE=7,
    FORBIDDEN_ME=8,
    UNFORBIDDEN_ME=9,
    KICKGROUP=10,
} PUSH_Message_TYPE;

@interface MessageManager : YManager<YManager>
AS_SINGLETON(MessageManager);

- (void)getMessageListData:(ActionCompleteBlock)block;

// 统计未读消息数
-(void)setupUnreadMessageCount;

//删除会话
- (void)delConversationByChatter:(NSString *)chatter;

@end
