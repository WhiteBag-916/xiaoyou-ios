//
//  RemindCell.h
//  XiaoYou
//
//  Created by sheng on 15/9/25.
//  Copyright © 2015年 xc. All rights reserved.
//

/**
 自己申请活动的提醒，包括下面描述的3个状态
 */
#import <UIKit/UIKit.h>
#import "YTableViewCell.h"
#import "NotifyInfoModel.h"
#import "NoticeInfo.h"
//提醒的5个状态
typedef enum : NSUInteger {
    AUDIT_PASSED,       //审核通过
    AUDIT_NOT_PASSED,   //审核未通过
    NOT_NEED_CHECK,     //不需要审核
    SOMEONE_JOININ,     //有人参加你发布的活动
    NEED_CHECK          //需要审核
} CELL_TYPE;

@interface PassRemindCell : YTableViewCell

@property (nonatomic,assign) CELL_TYPE cellType;

+(PassRemindCell*)passRemindCellWithTableView:(UITableView*)tableView;

-(void)setData:(id)model;

//-(void)setNotifyData:(NotifyInfoModel*)model;

@end
