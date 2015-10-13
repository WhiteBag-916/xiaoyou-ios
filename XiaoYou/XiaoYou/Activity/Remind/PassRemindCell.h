//
//  RemindCell.h
//  XiaoYou
//
//  Created by sheng on 15/9/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemindInfo.h"
@interface PassRemindCell : UITableViewCell


+(PassRemindCell*)passRemindCellWithTableView:(UITableView*)tableView;

-(void)setData:(RemindInfo*)remindInfo;

@end
