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
}
- (void)clearSource
{
}

- (void)appDidLogin:(NSDictionary *)loginInfo
{
    
}

- (void)appDidLogout
{

}

- (void)goLogin:(ActionCompleteBlock)block
{
    LoginAction* action = [[LoginAction alloc] init];
    action.password = @"320621";
    action.schoolCode = @"4";
    action.deviceId = @"20082020184";
    action.studentNo = @"2008202018";
    action.platform = @"2";
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        block(message);
        if (message.isSuccess)
        {
        }
    }];
}

@end
