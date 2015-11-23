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
    SCHEDULECARD_CELL,  //日程
    STUDYROOM_CELL,     //空闲教室
    SCROUGECOURSE_CELL, //蹭课
    ACTIVITY_DETAIL_CELL//活动详情
} CELLTYPE;
@interface AvailableListView : YTableView

-(void)loadData;

-(void)reloadNotifyMessageWithTableView;

@property (nonatomic,strong) NSMutableArray *availableListArray;

@end
