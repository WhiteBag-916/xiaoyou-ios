//
//  ProvisionManager.m
//  Component
//
//  Created by 熊宸 on 15/7/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProvisionManager.h"
#import "YFoundation.h"
#import "LoginAction.h"
#import "YShareDataDefine.h"
#import "YManagerCenter.h"
#import "LoginResp.h"
#import "SchoolListAction.h"
#import "YDirectory+Data.h"
#import "TagListAction.h"
#import "CommonImgUpload.h"
#import "ProfileInfo.h"
#import "ProfileAction.h"
#import "YNotificationDefine.h"
#import "ImageUploadModel.h"
#import "MyCommentPersonsAction.h"
#import "MyPraisePersonsAction.h"
#import "MyCoolPersonsAction.h"
#import "UpdateSelfIntroAction.h"
#import "ModifyPasswordAction.h"
#import "ReceiveAuthCodeAction.h"
#import "YDirectory+Data.h"
#import "CommonAction.h"
#import "YUtils+Component.h"
#import "ReceiveMobileAuthCodeAction.h"
#import "RegAction.h"
#import "RegNoticeAction.h"
#import "Tags.h"
#import "CheckLastVersionAction.h"
#import "YAnalysis.h"

#define kProvisionManagerSyncQueue @"kProvisionManagerSyncQueue"

@interface ProvisionManager ()

@property (nonatomic, strong) ProfileInfo *profileInfo; //个人信息,尽量用profile
@property (nonatomic, strong) LoginResp *loginResp;     //登录信息

@end

@implementation ProvisionManager

DEF_SINGLETON(ProvisionManager);

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

- (void)initSource
{
    //注册一个同步队列,用于同步执行流程或者维护缓存数据(sqlite缓存或者内存缓存)
    [YQueue registerSyncQueueWithType:kProvisionManagerSyncQueue];
}
- (void)clearSource
{
    [YQueue unregisterSyncQueueWithType:kProvisionManagerSyncQueue];
}

- (void)appDidLogin:(NSDictionary *)loginInfo
{
    [YShareData defaultData][kShareData_LoginPassword] = [[NSUserDefaults standardUserDefaults] objectForKey:kShareData_LoginPassword];
    
    [self initProfileData];
    
    [self getProfileInfo:^(YActionMessage *message) {
        
    }];
    
    [self resetUnreadAlterCount:[[[NSUserDefaults standardUserDefaults] objectForKey:kShareData_UnreadAlterCount] integerValue]];
}

- (void)appDidLogout:(NSDictionary *)logoutInfo
{
    //清理数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kShareData_Token];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kShareData_StudentNo];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kShareData_SchoolCode];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kShareData_UnreadAlterCount];
    
    _loginResp = nil;
    _profileInfo = nil;
    [self delPassword];
    
    //删除文件
    NSString *cachePath = [[YDirectory fileCache] stringByAppendingString:NSStringFromClass([LoginResp class])];
    [YDirectory removeFolders:cachePath];
    cachePath = [[YDirectory fileCache] stringByAppendingString:NSStringFromClass([ProfileInfo class])];
    [YDirectory removeFolders:cachePath];
    
    //发送通知,告知界面刷新
    [self postNotificationOnMainThreadName:kNotification_Profile_Logout
                                    object:nil
                                  userInfo:nil];
}

- (BOOL)initLoginData {
    NSString *cachePath = [[YDirectory fileCache] stringByAppendingString:NSStringFromClass([LoginResp class])];
    if ([YDirectory isExistsPath:cachePath]) {
        //如果文件存在
        self.loginResp = [LoginResp instanceWithFile:cachePath];
        
        return YES;
    }
    
    return NO;
}

//更新个人常用信息
- (void)updateLoginInfo
{
    [YShareData defaultData][kShareData_StudentNo] = _loginResp.studentNo;
    [YShareData defaultData][kShareData_Token] = _loginResp.token;
    [YShareData defaultData][kShareData_SchoolName] = _loginResp.schoolName;
    [YShareData defaultData][kShareData_SchoolCode] = _loginResp.schoolCode;
    [YShareData defaultData][kShareData_SchoolIcon] = _loginResp.schoolLogoPath;
}

//更新登录信息
- (void)saveLoginInfo
{
    //存文件
    NSString *cachePath = [[YDirectory fileCache] stringByAppendingString:NSStringFromClass([LoginResp class])];
    [_loginResp writeToFile:cachePath];
}

//初始化个人数据,自动登录
- (void)initProfileData{
    //
    NSString *cachePath = [[YDirectory fileCache] stringByAppendingString:NSStringFromClass([ProfileInfo class])];
    self.profileInfo = [ProfileInfo instanceWithFile:cachePath];
}

- (void)setProfileInfo:(ProfileInfo *)profileInfo {
    _profileInfo = profileInfo;
    [YAnalysis collectUserInfo:profileInfo];
    [YShareData defaultData][kShareData_UserID] = _profileInfo.uid;
}

//减少feed提醒未读数
- (void)delUnreadAlterCount:(NSInteger)delCount {
    NSInteger nowCount = [[YShareData defaultData][kShareData_UnreadAlterCount] integerValue];
    [self resetUnreadAlterCount:MAX(nowCount-delCount, 0)];
}

//增加feed提醒未读数
- (void)addUnreadAlterCount:(NSInteger)addCount {
    NSInteger nowCount = [[YShareData defaultData][kShareData_UnreadAlterCount] integerValue];
    [self resetUnreadAlterCount:nowCount+addCount];
}

//重置feed提醒未读数
- (void)resetUnreadAlterCount:(NSInteger)allCount {
    [YShareData defaultData][kShareData_UnreadAlterCount] = @(allCount);
    
    [[NSUserDefaults standardUserDefaults] setObject:@(allCount) forKey:kShareData_UnreadAlterCount];
    
    //发送通知,告知界面刷新
    [self postNotificationOnMainThreadName:KNotification_Update_UnreadAlterCount
                                    object:nil
                                  userInfo:nil];
}

- (NSString *)getUserId {
    return _profileInfo.uid;
}
//获取登录信息
- (LoginResp *)getLoginInfo {
    return _loginResp;
}

//获取个人信息
- (ProfileInfo *)getProfile {
    return _profileInfo;
}

//删除个人信息里的群tag
- (NSString *)delQueryCodesByGroupCode:(NSString *)groupCode {
    __block NSString *groupName;
    NSMutableArray *queryCodesArray = [_profileInfo.queryCodes mutableCopy];
    [queryCodesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([[obj internalBaseClassIdentifier] isEqualToString:groupCode]) {
            [queryCodesArray removeObjectAtIndex:idx];
            groupName = [obj name];
            *stop = YES;
        }
    }];
    
    if (groupName.length > 0) {
        _profileInfo.queryCodes = [NSArray arrayWithArray:queryCodesArray];
        [self saveProfileInfo];
    }
    
    return groupName;
}

//获取个人标签
- (NSArray *)profileTags {
    return _profileInfo.tagModels;
}

//更新个人常用信息
- (void)saveProfileInfo
{
    //存文件
    NSString *cachePath = [[YDirectory fileCache] stringByAppendingString:NSStringFromClass([ProfileInfo class])];
    [_profileInfo writeToFile:cachePath];
}

//存密码
- (void)savePassword:(NSString *)password {
    [YShareData defaultData][kShareData_LoginPassword] = password;
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:kShareData_LoginPassword];
}

//清理密码
- (void)delPassword {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kShareData_LoginPassword];
}

- (void)setLoginResp:(LoginResp *)loginResp {
    _loginResp = loginResp;
    
    [self updateLoginInfo];
}

- (void)loginSuccess:(YActionMessage*)message {
    //存文件
    self.loginResp = message.object;
    [self saveLoginInfo];
    //存token
    [[NSUserDefaults standardUserDefaults] setObject:_loginResp.token forKey:kShareData_Token];
    [[NSUserDefaults standardUserDefaults] setObject:_loginResp.schoolCode forKey:kShareData_SchoolCode];
    [[NSUserDefaults standardUserDefaults] setObject:_loginResp.studentNo forKey:kShareData_StudentNo];
    
    //抛登录成功
    [[YManagerCenter defaultCenter] notifyAppLogined:nil];
}

//注册
- (void)reg:(NSString *)account password:(NSString *)password mobilePhone:(NSString *)mobilePhone block:(ActionCompleteBlock)block {
    RegAction* action = [[RegAction alloc] init];
    action.password = password;
    action.schoolCode = [YShareData defaultData][kShareData_SchoolCode];
    action.studentNo = account;
    action.platform = @"2";
    action.mobilePhone = mobilePhone;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //子线程处理数据
        [YQueue dispatchInSyncQueueWithQueueType:kProvisionManagerSyncQueue block:^{
            if (message.isSuccess)
            {
                [self savePassword:action.password];
                
                [self loginSuccess:message];
            }
            
            //主线程处理界面
            [YQueue dispatchInMainQueueWithBlock:^{
                block(message);
            }];
        }];
    }];
}

- (void)goLogin:(NSString *)account password:(NSString *)password block:(ActionCompleteBlock)block
{
    LoginAction* action = [[LoginAction alloc] init];
    action.password = password;
    action.schoolCode = [YShareData defaultData][kShareData_SchoolCode];
    action.studentNo = account;
    action.platform = @"2";
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //子线程处理数据
        [YQueue dispatchInSyncQueueWithQueueType:kProvisionManagerSyncQueue block:^{
            if (message.isSuccess)
            {
                [self savePassword:action.password];
                
                [self loginSuccess:message];
            }
            
            //主线程处理界面
            [YQueue dispatchInMainQueueWithBlock:^{
                block(message);
            }];
        }];
    }];
}

//获取学校列表
- (void)schoolListReq:(NSString *)schoolName block:(ActionCompleteBlock)block {
    SchoolListAction* action = [[SchoolListAction alloc] init];
    action.schoolName = schoolName;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//忘记密码
- (void)forgotPasswordReq:(NSString *)studentNo block:(ActionCompleteBlock)block {
    CommonAction* action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"schoolCode": [YShareData defaultData][kShareData_SchoolCode],
                                              @"studentNo": studentNo}];
    action.url = [YUtils getUrl:api_login_forgetPwd];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//获取标签
- (void)getTagList:(ActionCompleteBlock)block {
    TagListAction* action = [[TagListAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//上传头像
- (void)uploadHeadImage:(NSString *)path block:(ActionCompleteBlock)block {
    CommonImgUpload* action = [[CommonImgUpload alloc] init];
    action.uploadType = @"user";
    action.needSnap = @"true";
    action.imagePath = path;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        if (message.isSuccess) {
            ImageUploadModel *uploadImage = (ImageUploadModel *)message.object;
            //更改缓存
            if (nil != _profileInfo) {
                _profileInfo.headPic = [uploadImage.snapImages objectAtIndex:0];
                [self saveProfileInfo];
            }
            if (nil != _loginResp) {
                _loginResp.icon = [uploadImage.snapImages objectAtIndex:0];
                [self saveLoginInfo];
            }
        }
        //主线程处理界面
        block(message);
    }];
}

//上传标签
- (void)uploadTagCodes:(NSString *)tagCodes block:(ActionCompleteBlock)block {
    CommonAction* action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"tagCodes" : tagCodes} needUserToken:YES];
    action.url = [YUtils getUrl:api_login_addTag];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//获取个人Profile信息
- (void)getProfileInfo:(ActionCompleteBlock)block {
    ProfileAction* action = [[ProfileAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        if (message.isSuccess) {
            self.profileInfo = message.object;
            [self saveProfileInfo];
            
            [self resetUnreadAlterCount:_profileInfo.unreadAlterCount];
        }
        //主线程处理界面
        block(message);
//        //发送通知,告知界面刷新
        [self postNotificationOnMainThreadName:kNotification_Profile_GetProfile
                                        object:nil
                                      userInfo:@{kNotification_Request_Message:message}];
    }];
}

//更新缓存标签
- (void)updateTagList:(NSArray *)tagList {
    if (nil != _profileInfo) {
        _profileInfo.tagModels = [NSArray arrayWithArray:tagList];
        
        [self saveProfileInfo];
    }
}

//评论过我的人,Author
- (void)myCommentPersons:(ActionCompleteBlock)block {
    MyCommentPersonsAction* action = [[MyCommentPersonsAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//点赞过我的人,Author
- (void)myPraisePersons:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block {
    MyPraisePersonsAction* action = [[MyPraisePersonsAction alloc] init];
    action.limitStart = limitStart;
    action.limitEnd = limitEnd;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//认为我很酷的人,Author
- (void)myCoolPersons:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block {
    MyCoolPersonsAction* action = [[MyCoolPersonsAction alloc] init];
    action.limitStart = limitStart;
    action.limitEnd = limitEnd;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//修改签名
- (void)UpdateSelfIntro:(NSString *)selfIntro block:(ActionCompleteBlock)block {
    UpdateSelfIntroAction* action = [[UpdateSelfIntroAction alloc] init];
    action.selfIntro = selfIntro;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        if (message.isSuccess) {
            _profileInfo.selfIntro = action.selfIntro;
            [self saveProfileInfo];
        }
        
        //主线程处理界面
        block(message);
    }];
}

//修改密码
- (void)ModifyPassword:(NSString *)password oldPassWord:(NSString *)oldPassWord block:(ActionCompleteBlock)block {
    ModifyPasswordAction* action = [[ModifyPasswordAction alloc] init];
    action.password = password;
    action.oldPassWord = oldPassWord;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        if (message.isSuccess) {
            [self savePassword:action.password];
        }
        //主线程处理界面
        block(message);
    }];
}

//绑定手机验证码获取
- (void)receiveAuthCode:(NSString *)mobilePhone needUserToken:(BOOL)needUserToken block:(ActionCompleteBlock)block {
    ReceiveAuthCodeAction* action = [[ReceiveAuthCodeAction alloc] init];
    action.mobilePhone = mobilePhone;
    action.needUserToken = needUserToken;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//绑定手机
- (void)receiveMobileAuthCode:(NSString *)mobilePhone authCode:(NSString *)authCode block:(ActionCompleteBlock)block {
    ReceiveMobileAuthCodeAction* action = [[ReceiveMobileAuthCodeAction alloc] init];
    action.mobilePhone = mobilePhone;
    action.authCode = authCode;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        if (message.isSuccess) {
            _loginResp.mobilePhone = action.mobilePhone;
            [self saveLoginInfo];
        }
        
        //主线程处理界面
        block(message);
    }];
}

//登出
- (void)logout {
    CommonAction* action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:nil needUserToken:YES];
    action.url = [YUtils getUrl:api_user_logOut];
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
    }];
    
    //抛登出
    [[YManagerCenter defaultCenter] notifyAppLogouted:@{@"logoutBySelf":@YES}];
}

//注册须知
- (void)regNotice:(ActionCompleteBlock)block {
    RegNoticeAction* action = [[RegNoticeAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        block(message);
    }];
}

//重置密码
- (void)resetPwd:(NSString *)authCode password:(NSString *)password block:(ActionCompleteBlock)block {
    CommonAction* action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"authCode" : authCode, @"studentNo":[YShareData defaultData][kShareData_StudentNo], @"schoolCode":[YShareData defaultData][kShareData_SchoolCode], @"password":password}];
    action.url = [YUtils getUrl:api_login_resetPwd];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//查询最新版本接口
- (void)checkLastVersion:(ActionCompleteBlock)block {    
    CheckLastVersionAction* action = [[CheckLastVersionAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

@end
