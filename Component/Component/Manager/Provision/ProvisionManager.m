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

#define kProvisionManagerSyncQueue @"kProvisionManagerSyncQueue"

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
    
}

- (void)appDidLogout
{

}

//更新个人常用信息
- (void)updateLoginInfo:(LoginResp *)loginResp
{
    [YShareData defaultData][kShareData_LoginInfo] = loginResp;
    [YShareData defaultData][kShareData_StudentNo] = loginResp.studentNo;
    [YShareData defaultData][kShareData_Token] = loginResp.token;
    [YShareData defaultData][kShareData_SchoolIcon] = loginResp.icon;
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
                [self updateLoginInfo:message.object];
                
                [YShareData defaultData][kShareData_LoginAccount] = action.studentNo;
                
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

@end
