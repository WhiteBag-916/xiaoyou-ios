//
//  ProvisionManager.h
//  Component
//
//  Created by 熊宸 on 15/7/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YManager.h"
#import "YAction.h"

@interface ProvisionManager : YManager<YManager>
AS_SINGLETON(ProvisionManager);

//初始化登录数据,自动登录
- (void)initLoginData;
//登录
- (void)goLogin:(NSString *)account password:(NSString *)password block:(ActionCompleteBlock)block;
//获取学校列表
- (void)schoolListReq:(NSString *)schoolName block:(ActionCompleteBlock)block;
//忘记密码
- (void)forgotPasswordReq:(NSString *)studentNo block:(ActionCompleteBlock)block;

@end
