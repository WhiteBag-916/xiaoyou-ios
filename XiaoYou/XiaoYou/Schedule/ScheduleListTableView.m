//
//  ScheduleListTableView.m
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ScheduleListTableView.h"
#import "ScheduleCell.h"

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
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
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
    ScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa"];
    if (!cell) {
        cell = [[ScheduleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    }
    return cell;
}
@end
