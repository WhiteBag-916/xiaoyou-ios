//
//  YCommonReport.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/27.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YCommonReport.h"
#import "YCommonAlertView.h"
#import "YUtils+Component.h"
@implementation YCommonReport
+ (void)reportWithType:(NSString *)type andData:(NSDictionary *)data {
    [YAnalysis trackEvent:type withPara:data];
    YCommonAlertView *alert = [[YCommonAlertView alloc] initWithTitle:nil message:@"是否确认举报？" buttonTitles:@"取消", @"确认",nil];
    [alert clickedButtonHandler:^(NSInteger index) {
        [alert hide];
        if (index == 1) {
            if ([YUtils IsEnableConnection]) {
                [YAnalysis trackEvent:[NSString stringWithFormat:@"确定_%@", type]
                             withPara:data];
                [YUtils showTitle:@"举报成功"];
            } else {
                [YUtils showTitle:@"无网络连接"];
            }
        } else {
            [YAnalysis trackEvent:[NSString stringWithFormat:@"关闭_%@", type]
                         withPara:data];
        }
    }];
    [alert show];
}
@end
