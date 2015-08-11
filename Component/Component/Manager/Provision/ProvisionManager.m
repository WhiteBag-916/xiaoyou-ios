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
    [YShareData defaultData][kShareData_SchoolCode] = loginResp.schoolCode;
    [YShareData defaultData][kShareData_SchoolIcon] = loginResp.icon;
}

- (void)goLogin:(ActionCompleteBlock)block
{
    LoginAction* action = [[LoginAction alloc] init];
    action.password = @"480155";
    action.schoolCode = @"4";
    action.deviceId = @"20082020184";
    action.studentNo = @"15140220000";
    action.platform = @"2";
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //子线程处理数据
        [YQueue dispatchInSyncQueueWithQueueType:kProvisionManagerSyncQueue block:^{
            if (message.isSuccess)
            {
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

@end
