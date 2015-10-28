//
//  ApplyRemindCell.h
//  XiaoYou
//
//  Created by sheng on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

/**
 *  别人申请的Cell，包括同意、忽略，以及同意，忽略选项
 *
 *  @param ApplyRemindCell nil
 *
 *  @return nil
 */
#import <UIKit/UIKit.h>
#import "NoticeInfo.h"
#import "YTableViewCell.h"
typedef enum : NSUInteger {
    WAIT_SELECT,        //等待选择
    AGREED,             //同意
    IGNORED,            //忽略
} APPLY_CELL_TYPE;

@interface ApplyRemindCell : YTableViewCell

+(ApplyRemindCell*)cellWithTableView:(UITableView*)tableView;

@property (nonatomic,assign) APPLY_CELL_TYPE cellType;

-(void)setData:(NoticeInfo*)model;

@end
