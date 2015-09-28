//
//  RemindHeadView.m
//  XiaoYou
//
//  Created by sheng on 15/9/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#define REUSERID @"ReminHeadView"
#import "RemindHeadView.h"

@implementation RemindHeadView

+(RemindHeadView *)remindHeadViewWithTableView:(UITableView *)tableView
{
    UITableViewHeaderFooterView *remindHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:REUSERID];
    if (!remindHeadView) {
        remindHeadView = [[RemindHeadView alloc]initWithReuseIdentifier:REUSERID];
    }
    remindHeadView.backgroundColor = [UIColor colorWithRed:247/255 green:247/255 blue:247/255 alpha:0];
    return (RemindHeadView*)remindHeadView;
}

@end
