//
//  FunnyListView.m
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityListView.h"
#import "ActivityCell.h"
#import "YVIew+Ext.h"
#import "ActivityDetailViewController.h"
#import "YNavigationController.h"
@interface ActivityListView ()<UITableViewDataSource,UITableViewDelegate>
@end

@implementation ActivityListView

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
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 312;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCell *cell = [ActivityCell cellWithTableView:tableView];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityDetailViewController *detailVC = [[ActivityDetailViewController alloc]init];
    [self.viewController.navigationController pushViewController:detailVC animated:YES needHiddenBottomBar:YES];
}

@end
