//
//  ScheduleListTableView.m
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ScheduleListTableView.h"
#import "ScheduleCell.h"
#define SCHEREUSEID             @"schedulecell"
#define CELL_BACKGROUND_COLOR   @""
@interface ScheduleListTableView ()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation ScheduleListTableView

-(instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.sectionFooterHeight = 0.1;
        self.sectionHeaderHeight = 30;
        self.tableHeaderView.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.sectionFooterHeight = 0.1;
        self.sectionHeaderHeight = 30;
        self.tableHeaderView.backgroundColor = [UIColor redColor];
    }
    return self;
}


#pragma mark 协议方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:SCHEREUSEID];
    if (!cell) {
        cell = [[ScheduleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SCHEREUSEID];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
