//
//  ScheduleCardCell.h
//  XiaoYou
//
//  Created by sheng on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

/**
 *  有空模块-你的日程卡
 */
#import "YTableViewCell.h"
#import "YTableViewCell.h"
@interface ScheduleCardCell : YTableViewCell


+(ScheduleCardCell*)cellWithTableView:(UITableView*)tableView;

-(void)setData:(NSArray*)scheduleArr;

-(void)setMessageNotReadIsVisible:(BOOL)isVisible Text:(NSString*)text;

@end
