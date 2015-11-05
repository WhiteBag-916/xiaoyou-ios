//
//  ScheduleNotifyCell.h
//  XiaoYou
//
//  Created by sheng on 15/11/3.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"
#import "NotifyInfoModel.h"

@interface ScheduleNotifyCell : YTableViewCell


+(ScheduleNotifyCell*)cellWithTableView:(UITableView*)tableView;

-(void)setData:(NotifyInfoModel*)model;

@end
