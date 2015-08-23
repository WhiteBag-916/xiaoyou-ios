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
#import "ForgotPasswordAction.h"
#import "YDirectory+Data.h"
#import "TagListAction.h"
#import "UploadHeadImageAction.h"
#import "UploadTagCodes.h"
#import "ProfileInfo.h"
#import "ProfileAction.h"
#import "YNotificationDefine.h"
#import "UploadImage.h"
#import "MyCommentPersonsAction.h"
#import "MyPraisePersonsAction.h"
#import "EaseMob.h"

#define kProvisionManagerSyncQueue @"kProvisionManagerSyncQueue"

@interface ProvisionManager ()

@property (nonatomic, strong) ProfileInfo *profileInfo; //个人信息

@end

@implementation ProvisionManager

DEF_SINGLETON(ProvisionManager);

- (instancetype)init
{
    if (self == [super init]) {
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
    [self loginEaseMob];
    
    [self initProfileData];
    
    [self getProfileInfo];
}

- (void)appDidLogout
{

}

- (void)initLoginData {
    NSString *cachePath = [[YDirectory fileCache] stringByAppendingString:NSStringFromClass([LoginResp class])];
    LoginResp* loginResp = [LoginResp instanceWithFile:cachePath];
    [self updateLoginInfo:loginResp];
}

//更新个人常用信息
- (void)updateLoginInfo:(LoginResp *)loginResp
{
    [YShareData defaultData][kShareData_LoginInfo] = loginResp;
    [YShareData defaultData][kShareData_StudentNo] = loginResp.studentNo;
    [YShareData defaultData][kShareData_Token] = loginResp.token;
    [YShareData defaultData][kShareData_SchoolIcon] = loginResp.icon;
    [YShareData defaultData][kShareData_LoginAccount] = loginResp.studentNo;
    [YShareData defaultData][kShareData_SchoolName] = loginResp.schoolName;
    [YShareData defaultData][kShareData_SchoolCode] = loginResp.schoolCode;
}

//初始化个人数据,自动登录
- (void)initProfileData{
    NSString *cachePath = [[YDirectory fileCache] stringByAppendingString:NSStringFromClass([ProfileInfo class])];
    _profileInfo = [ProfileInfo instanceWithFile:cachePath];
}

//获取个人信息
- (ProfileInfo *)getProfile {
    return _profileInfo;
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
                //存文件
                NSString *cachePath = [[YDirectory fileCache] stringByAppendingString:NSStringFromClass([LoginResp class])];
                LoginResp* loginResp = ((LoginResp*)(message.object));
                [loginResp writeToFile:cachePath];
                //存token
                [[NSUserDefaults standardUserDefaults] setObject:loginResp.token forKey:kShareData_Token];
                
                [self updateLoginInfo:message.object];
                
                //抛登录成功
                [[YManagerCenter defaultCenter] notifyAppLogined:nil];
            }
            
            //主线程处理界面
            [YQueue dispatchInMainQueueWithBlock:^{
                block(message);
                
                YLogD(@"%@", [YShareData defaultData][kShareData_LoginInfo]);
            }];
        }];
    }];
}

- (void)loginEaseMob {
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[NSString stringWithFormat:@"4_%@",[YShareData defaultData][kShareData_StudentNo]] password:[NSString stringWithFormat:@"4_%@",[YShareData defaultData][kShareData_StudentNo]] completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            YLogD(@"登陆成功");
        }
    } onQueue:nil];
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
    ForgotPasswordAction* action = [[ForgotPasswordAction alloc] init];
    action.studentNo = studentNo;
    
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
    UploadHeadImageAction* action = [[UploadHeadImageAction alloc] init];
    action.imagePath = path;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        if (message.isSuccess) {
            //更改缓存
            if (nil != _profileInfo) {
                UploadImage *uploadImage = (UploadImage *)message.object;
                _profileInfo.headPic = uploadImage.url;
                [self saveProfileInfo];
            }
        }
        //主线程处理界面
        block(message);
    }];
}

//上传标签
- (void)uploadTagCodes:(NSString *)tagCodes block:(ActionCompleteBlock)block {
    UploadTagCodes* action = [[UploadTagCodes alloc] init];
    action.tagCodes = tagCodes;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//获取个人Profile信息
- (void)getProfileInfo {
    ProfileAction* action = [[ProfileAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        if (message.isSuccess) {
            _profileInfo = message.object;
            [self saveProfileInfo];
        }
        //发送通知,告知界面刷新
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

//点赞过我的人
- (void)myPraisePersons:(ActionCompleteBlock)block {
    MyPraisePersonsAction* action = [[MyPraisePersonsAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

@end
