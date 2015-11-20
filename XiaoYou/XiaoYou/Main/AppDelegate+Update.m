//
//  AppDelegate+Update.m
//  XiaoYou
//
//  Created by 尹先森 on 15/11/16.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AppDelegate+Update.h"
#import "ASIHTTPRequest.h"
#import "ProvisionManager.h"
#import "Reachability.h"

@interface AppDelegate ()<UIAlertViewDelegate>

@end

@implementation AppDelegate (Update)

-(void)isNeedToUpDate
{

    [[ProvisionManager sharedInstance] checkLastVersion:^(YActionMessage *message) {
        if (message.isSuccess)
        {
            self.checkLastVersionModel = message.object;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ 版本更新",self.checkLastVersionModel.version] message:self.checkLastVersionModel.about delegate:self cancelButtonTitle:@"稍后更新" otherButtonTitles:@"现在更新", nil];
            alert.tag = 9999990;
            [alert show];
            
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1 && alertView.tag == 9999990) {
        
        Reachability *reachability = [Reachability reachabilityWithHostName:@"www.xiaoyou.com"];  // 测试服务器状态
        
        NSInteger reachabilityStatusNum = [reachability currentReachabilityStatus];
        switch(reachabilityStatusNum) {
            case NotReachable:
                
                break;
            case ReachableViaWWAN:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"当前非wifi网络状态是否继续更新？"] message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                alert.tag = 9999991;
                [alert show];
                break;
            }
            case ReachableViaWiFi:
            {
                NSURL *url = [NSURL URLWithString:self.checkLastVersionModel.appPath];
                [[UIApplication sharedApplication]openURL:url];
            }   break;
        }
    }
    else if(buttonIndex==1 && alertView.tag == 9999991)
    {
        NSURL *url = [NSURL URLWithString:self.checkLastVersionModel.appPath];
        [[UIApplication sharedApplication]openURL:url];
    }
    else
    {
        //强制更新
        if (self.checkLastVersionModel.compulsoryRenewal)
        {
            exit(0);
        }
    }
}

@end
