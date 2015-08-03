//
//  YManager.m
//  YFramework
//
//  Created by abc on 15/4/17.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YManager.h"
#import "YManagerCenter.h"
#import "YQueue.h"

@implementation YManager

- (instancetype)init
{
    if (self == [super init])
    {
        //初始化时自动注册到Center
        [[YManagerCenter defaultCenter] registerManager:self];
    }
    return self;
}

- (void)postNotificationOnMainThreadName:(NSString *)aName
                                  object:(id)anObject
                                userInfo:(NSDictionary *)aUserInfo
{
    [YQueue dispatchInMainQueueWithBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:aName
                                                            object:anObject
                                                          userInfo:aUserInfo];
    }];
}

- (void)postNotificationName:(NSString *)aName
                      object:(id)anObject
                    userInfo:(NSDictionary *)aUserInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:aName
                                                        object:anObject
                                                      userInfo:aUserInfo];
}
#pragma makr - ManagerProtocol
- (void)initSource
{ //子类业务操作
}
- (void)clearSource
{ //子类业务操作
}
- (void)appDidLogin:(NSDictionary *)loginInfo
{ //子类业务操作
}
- (void)appDidLogout
{ //子类业务操作
}

@end
