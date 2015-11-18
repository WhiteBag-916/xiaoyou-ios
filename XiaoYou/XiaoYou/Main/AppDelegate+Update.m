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

#define APP_URL @"http://itunes.apple.com/lookup?id=1024046567"

@interface AppDelegate ()<UIAlertViewDelegate>

@end

@implementation AppDelegate (Update)

-(void)isNeedToUpDate
{
//    self.checkLastVersionModel = [[CheckLastVersionModel alloc] init];
//    self.checkLastVersionModel.version = @"3.1";
//    self.checkLastVersionModel.about = @"请更新";
//    self.checkLastVersionModel.appPath = @"http://www.baidu.com";
//    self.checkLastVersionModel.compulsoryRenewal = YES;
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ 版本更新",self.checkLastVersionModel.version] message:self.checkLastVersionModel.about delegate:self cancelButtonTitle:@"稍后更新" otherButtonTitles:@"现在更新", nil];
//    [alert show];
    [[ProvisionManager sharedInstance] checkLastVersion:^(YActionMessage *message) {
        if (message.isSuccess)
        {
            self.checkLastVersionModel = message.object;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ 版本更新",self.checkLastVersionModel.version] message:self.checkLastVersionModel.about delegate:self cancelButtonTitle:@"稍后更新" otherButtonTitles:@"现在更新", nil];
            [alert show];
            
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
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
