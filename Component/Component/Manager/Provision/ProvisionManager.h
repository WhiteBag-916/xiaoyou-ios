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

@interface ProvisionManager : YManager<YManager>
AS_SINGLETON(ProvisionManager);

//初始化登录数据,自动登录
- (void)initLoginData;
//初始化个人数据,自动登录
- (void)initProfileData;
//获取个人信息
- (ProfileInfo *)getProfile;
//获取个人标签
- (NSArray *)profileTags;
//登录
- (void)goLogin:(NSString *)account password:(NSString *)password block:(ActionCompleteBlock)block;
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
- (void)getProfileInfo;
//更新缓存标签
- (void)updateTagList:(NSArray *)tagList;
//评论过我的人
- (void)myCommentPersons:(ActionCompleteBlock)block;
//点赞过我的人
- (void)myPraisePersons:(ActionCompleteBlock)block;

@end
