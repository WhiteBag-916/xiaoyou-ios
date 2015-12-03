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

@interface AppDelegate ()<UIAlertViewDelegate>

@end

@implementation AppDelegate (Update)

-(void)isNeedToUpDate
{

    [[ProvisionManager sharedInstance] checkLastVersion:^(YActionMessage *message) {
        if (message.isSuccess)
        {
            self.checkLastVersionModel = message.object;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ 版本更新",self.checkLastVersionModel.version]
                                                            message:self.checkLastVersionModel.about
                                                           delegate:self
                                                  cancelButtonTitle:@"稍后更新"
                                                  otherButtonTitles:@"现在更新", nil];
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
