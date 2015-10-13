//
//  AvailableListView.m
//  XiaoYou
//
//  Created by sheng on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AvailableListView.h"
#import "AvailableCell.h"
#import "ScheduleCardCell.h"
#import "StudyRoomCell.h"
#import "ScroungeCourseCell.h"
#import "RemindViewController.h"

@interface AvailableListView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AvailableListView

-(instancetype)init
{
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }
    
    return self;
}


#pragma mark 协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
        return SCALE_NUM(140);
    else if (indexPath.row == 1)
        return 85;
    else if (indexPath.row == 6) {
        return 85;
    }
    return SCALE_NUM(400);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ScheduleCardCell *cell = [ScheduleCardCell cellWithTableView:tableView];
        return cell;
    }
    else if (indexPath.row == 1) {
        StudyRoomCell *cell = [StudyRoomCell cellWithTableView:tableView];
        return cell;
    }
    else if (indexPath.row == 6) {
        ScroungeCourseCell *cell = [ScroungeCourseCell cellWithTableView:tableView];
        return cell;
    }
    else
    {
        AvailableCell *cell = [AvailableCell cellWithTableView:tableView];
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


/*-(void)gotoDetailWithCellType:(CELLTYPE)type
{
    //日程
    if (type == SCHEDULECARD_CELL) {
        RemindViewController *remindVC = [[RemindViewController alloc]init];
    }
    //空闲教室
    else if (type == STUDYROOM_CELL) {
        
    }
    //可以蹭的课
    else if (type == SCHEDULECARD_CELL) {
        
    }
}*/


@end
