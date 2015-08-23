//
//  MessageManager.m
//  Component
//
//  Created by 熊宸 on 15/7/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "MessageManager.h"
#import "YFoundation.h"
#import "MessageListAction.h"
#import "YShareDataDefine.h"
#import "YManagerCenter.h"
#import "EaseMob.h"

#define kMessageManagerSyncQueue @"kMessageManagerSyncQueue"

typedef enum : NSUInteger {
    SYSTEM_MESSAGE,
    FRIEND_APPLY,
    GROUP_APPLY,
} PUSH_Message_TYPE;


@interface MessageManager ()<EMChatManagerDelegate>



@end

@implementation MessageManager

DEF_SINGLETON(MessageManager);

- (instancetype)init
{
    if (self == [super init]) {
    }
    return self;
}



- (void)getMessageListData:(ActionCompleteBlock)block
{
    MessageListAction * action = [[MessageListAction alloc] init];
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //子线程处理数据
        [YQueue dispatchInSyncQueueWithQueueType:kMessageManagerSyncQueue block:^{
            if (message.isSuccess)
            {
                
            }
            
            //主线程处理界面
            [YQueue dispatchInMainQueueWithBlock:^{
                block(message);
            }];
        }];
    }];
}

- (void)initSource
{
    //注册一个同步队列,用于同步执行流程或者维护缓存数据(sqlite缓存或者内存缓存)
    [YQueue registerSyncQueueWithType:kMessageManagerSyncQueue];
}
- (void)clearSource
{
    [YQueue unregisterSyncQueueWithType:kMessageManagerSyncQueue];
}

-(void)registerNotifications
{
    [self unregisterNotifications];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)appDidLogin:(NSDictionary *)loginInfo
{
    [self registerNotifications];
}

- (void)appDidLogout
{
    [self unregisterNotifications];
}

-(void)didReceiveMessage:(EMMessage *)message
{
    [message updateMessageExtToDB];
    
//    if ([message.messageBodies[0][@"ext"][@"server_flag"] isEqualToString:@"true"])
//    {
//        switch ([message.messageBodies[0][@"msg"][@"msg"][@"type"] integerValue])
//        {
//            case SYSTEM_MESSAGE:
//                NSLog(@"系统消息推送");
//                break;
//            case FRIEND_APPLY:
//                NSLog(@"好友申请推送");
//                break;
//            case GROUP_APPLY:
//                NSLog(@"入社申请推送");
//                break;
//                
//            default:
//                break;
//        }
//    }
    
}


//自动登录
/*!
 @method
 @brief 用户将要进行自动登录操作的回调
 @discussion
 @param loginInfo 登录的用户信息
 @param error     错误信息
 @result
 */
- (void)willAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    
}

/*!
 @method
 @brief 用户自动登录完成后的回调
 @discussion
 @param loginInfo 登录的用户信息
 @param error     错误信息
 @result
 */
- (void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    
}


//重连
/*!
 @method
 @brief 将要发起自动重连操作时发送该回调
 @discussion
 @result
 */
- (void)willAutoReconnect
{
    
}

/*!
 @method
 @brief 自动重连操作完成后的回调（成功的话，error为nil，失败的话，查看error的错误信息）
 @discussion
 @result
 */
- (void)didAutoReconnectFinishedWithError:(NSError *)error
{
    
}


@end
