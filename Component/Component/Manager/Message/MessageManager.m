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

}


@end
