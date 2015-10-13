//
//  AvailableListView.h
//  XiaoYou
//
//  Created by sheng on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableView.h"
#import "YViewController.h"
//cell类型
typedef enum : NSUInteger {
    DEFAULT,
    SCHEDULECARD_CELL,
    STUDYROOM_CELL,
    SCROUGECOURSE_CELL
} CELLTYPE;
@interface AvailableListView : YTableView

@property (nonatomic, weak) YViewController *superVC;

@end
