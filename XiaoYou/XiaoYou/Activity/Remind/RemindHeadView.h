//
//  RemindHeadView.h
//  XiaoYou
//
//  Created by sheng on 15/9/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeInfo.h"
#import "NotifyInfoModel.h"

@interface RemindHeadView : UITableViewHeaderFooterView

+(RemindHeadView*)remindHeadViewWithTableView:(UITableView*)tableView;

-(void)setData:(NoticeInfo*)model;

-(void)setNotifyData:(NotifyInfoModel*)model;

@end
