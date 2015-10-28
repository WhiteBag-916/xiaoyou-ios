//
//  RemindCell.h
//  XiaoYou
//
//  Created by sheng on 15/9/25.
//  Copyright © 2015年 xc. All rights reserved.
//

/**
 自己申请活动的提醒，包括下面描述的5个状态
 */
#import <UIKit/UIKit.h>
#import "NoticeInfo.h"
#import "YTableViewCell.h"
//提醒的5个状态
typedef enum : NSUInteger {
    ALREADY_SUBMIT,     //已经提交
    AUDIT_PASSED,       //审核通过
    AUDIT_NOT_PASSED,   //审核未通过
    SUCESSED_JOININ,    //成功参加活动
    SOMEONE_JOININ      //有人参加你发布的活动
} CELL_TYPE;

@interface PassRemindCell : YTableViewCell

@property (nonatomic,assign) CELL_TYPE cellType;

+(PassRemindCell*)passRemindCellWithTableView:(UITableView*)tableView;

-(void)setData:(NoticeInfo*)model;

@end
