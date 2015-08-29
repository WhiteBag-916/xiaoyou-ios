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
+ (void)report {
    YCommonAlertView *alert = [[YCommonAlertView alloc] initWithTitle:nil message:@"是否确认举报？" buttonTitles:@"确认",@"取消", nil];
    [alert clickedButtonHandler:^(NSInteger index) {
        [alert hide];
        if (index == 0) {
            if ([YUtils IsEnableConnection]) {
                [YUtils showTitle:@"举报成功"];
            } else {
                [YUtils showTitle:@"无网络连接"];
            }
        }
    }];
    [alert show];
}
@end
