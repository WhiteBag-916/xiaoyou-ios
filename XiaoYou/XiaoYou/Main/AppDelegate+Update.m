//
//  AppDelegate+Update.m
//  XiaoYou
//
//  Created by 尹先森 on 15/11/16.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AppDelegate+Update.h"
#import "ASIHTTPRequest.h"

#define APP_URL @"http://itunes.apple.com/lookup?id=1024046567"

@interface AppDelegate ()<UIAlertViewDelegate>

@end

@implementation AppDelegate (Update)

-(void)isNeedToUpDate
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSLog(@"%@",infoDic);
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    NSURL * url = [NSURL URLWithString:APP_URL];
    //1.创建网络请求（GET）
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    //设置网络请求的延时为10秒钟
    request.timeOutSeconds=10;
    //2.发送请求(同步请求)
    [request startSynchronous];
    //3.检测服务器返回的结果
    if (request.error) {
        //请求出错，比如超时
        NSLog(@"请求超时，错误信息为%@",request.error);
    }else//请求成功
    {
        //将服务器返回的数据解析为字典
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableLeaves error:Nil];
        NSLog(@"%@",dictionary);
        NSArray *infoArray = [dictionary objectForKey:@"results"];
        if ([infoArray count]) {
            NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
            NSString *lastVersion = [releaseInfo objectForKey:@"version"];
            
            if (![lastVersion isEqualToString:currentVersion]) {
                NSString * itunesUrl = [releaseInfo objectForKey:@"trackViewUrl"];
                [[NSUserDefaults standardUserDefaults] setObject:itunesUrl forKey:@"trackViewUrl"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？\n男性不更新娶不到媳妇，女性不更新找不到男票\n当然如果你是中性可以选择不更新" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
                alert.tag = 10000;
                [alert show];
            }
            else
            {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"此版本为最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                alert.tag = 10001;
//                [alert show];
                return;
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10000) {
        if (buttonIndex==1) {
            NSURL *url = [NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"trackViewUrl"]];
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}

@end
