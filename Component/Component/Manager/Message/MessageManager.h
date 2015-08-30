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
    FRIEND_APPLY,
    GROUP_APPLY,
    ADD_COMMENT,
    ADD_PRAOSE,
    REPLY_COMMENT,
    REPLY_PRAOSE,
    FORBIDDEN_ME,
    UNFORBIDDEN_ME,
} PUSH_Message_TYPE;

@interface MessageManager : YManager<YManager>
AS_SINGLETON(MessageManager);

- (void)getMessageListData:(ActionCompleteBlock)block;

// 统计未读消息数
-(void)setupUnreadMessageCount;

//删除会话
- (void)delConversationByChatter:(NSString *)chatter;

@end
