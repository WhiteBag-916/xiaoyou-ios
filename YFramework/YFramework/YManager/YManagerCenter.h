//
//  YDirectory.m
//  YFramework
//
//  Created by abc on 15/4/18.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YObject.h"
#import "YManager.h"

/**
 *  @author Abc
 *
 *  组件的管理中心,统一管理组件通用消息的触发
 */
@interface YManagerCenter : YObject
+ (YManagerCenter *)defaultCenter;

/**
 *  @author Abc
 *
 *  注册一个组件到管理中心
 *
 *  @param manager 组件
 */
- (void)registerManager:(YManager<YManager> *)manager;

/**
 *  @author Abc
 *
 *  反注册
 */
- (void)unregisterAllManager;

/**
 *  @author Abc
 *
 *  App登录成功后调用,用来触发所有组件的:appDidLogin:方法
 *
 *  @param loginInfo 登录成功信息
 */
- (void)notifyAppLogined:(NSDictionary *)loginInfo;

/**
 *  @author Abc
 *
 *  App注销后调用,用来触发所有组件的appDidLogout方法
 */
- (void)notifyAppLogouted;
@end
