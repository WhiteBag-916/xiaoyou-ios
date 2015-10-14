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

typedef enum : NSUInteger {
    WAIT_SELECT,
    AGREED,
    IGNORED,
} CELL_TYPE;

@interface ApplyRemindCell : UITableViewCell

+(ApplyRemindCell*)cellWithTableView:(UITableView*)tableView;

@property (nonatomic,assign) CELL_TYPE cellType;

@end
