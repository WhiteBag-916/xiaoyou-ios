//
//  ProvisionManager.h
//  Component
//
//  Created by 熊宸 on 15/7/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YManager.h"
#import "YAction.h"

@class ProfileInfo;
@class LoginResp;

@interface ProvisionManager : YManager<YManager>
AS_SINGLETON(ProvisionManager);

//获取用户uid
- (NSString *)getUserId;
//初始化登录数据,自动登录
- (void)initLoginData;
//初始化个人数据,自动登录
- (void)initProfileData;
//获取个人信息
- (ProfileInfo *)getProfile;
//删除个人信息里的群tag
- (NSString *)delQueryCodesByGroupCode:(NSString *)groupCode;
//减少feed提醒未读数
- (void)delUnreadAlterCount:(NSInteger)delCount;
//增加feed提醒未读数
- (void)addUnreadAlterCount:(NSInteger)addCount;
//重置feed提醒未读数
- (void)resetUnreadAlterCount:(NSInteger)allCount;
//获取登录信息
- (LoginResp *)getLoginInfo;
//获取个人标签
- (NSArray *)profileTags;
//登录
- (void)goLogin:(NSString *)account password:(NSString *)password block:(ActionCompleteBlock)block;
//注册
- (void)reg:(NSString *)account password:(NSString *)password mobilePhone:(NSString *)mobilePhone block:(ActionCompleteBlock)block;
//获取学校列表
- (void)schoolListReq:(NSString *)schoolName block:(ActionCompleteBlock)block;
//忘记密码
- (void)forgotPasswordReq:(NSString *)studentNo block:(ActionCompleteBlock)block;
//获取标签
- (void)getTagList:(ActionCompleteBlock)block;
//上传头像
- (void)uploadHeadImage:(NSString *)path block:(ActionCompleteBlock)block;
//上传标签
- (void)uploadTagCodes:(NSString *)tagCodes block:(ActionCompleteBlock)block;
//获取个人Profile信息
- (void)getProfileInfo:(ActionCompleteBlock)block;
//更新缓存标签
- (void)updateTagList:(NSArray *)tagList;
//评论过我的人
- (void)myCommentPersons:(ActionCompleteBlock)block;
//点赞过我的人
- (void)myPraisePersons:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block;
//认为我很酷的人
- (void)myCoolPersons:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block;
//修改签名
- (void)UpdateSelfIntro:(NSString *)selfIntro block:(ActionCompleteBlock)block;
//修改密码
- (void)ModifyPassword:(NSString *)password oldPassWord:(NSString *)oldPassWord block:(ActionCompleteBlock)block;
//绑定手机验证码获取
- (void)receiveAuthCode:(NSString *)mobilePhone needUserToken:(BOOL)needUserToken block:(ActionCompleteBlock)block;
//绑定手机
- (void)receiveMobileAuthCode:(NSString *)mobilePhone authCode:(NSString *)authCode block:(ActionCompleteBlock)block;
//登出
- (void)logout;
//注册须知
- (void)regNotice:(ActionCompleteBlock)block;
//重置密码
- (void)resetPwd:(NSString *)authCode password:(NSString *)password block:(ActionCompleteBlock)block;

@end
