//
//  RemindListTableView.m
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RemindListTableView.h"
#import "RemindHeadView.h"
#import "RemindCell.h"
#define REMINDVIEWCELL  @"remindCell"
#define REMINDHEADVIEW  @"remindHeadView"
#define HEADCELL_HEIGHT SCALE_NUM(33)

@interface RemindListTableView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)NSArray *remindListArray;
@end
@implementation RemindListTableView

-(instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[RemindCell class] forCellReuseIdentifier:REMINDVIEWCELL];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView.height = HEADCELL_HEIGHT;
        [self registerClass:[RemindCell class] forCellReuseIdentifier:REMINDVIEWCELL];
    }
    return self;
}



#pragma mark 协议方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
    /*CGFloat height = [tableView fd_heightForCellWithIdentifier:REMINDVIEWCELL cacheByIndexPath:indexPath configuration:^(RemindCell *cell) {
        [cell setData:self.remindListArray[indexPath.section]];
    }];
    return height;*/
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return SCALE_NUM(33);
//}

//返回header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    RemindHeadView *headView = [RemindHeadView remindHeadViewWithTableView:tableView];
    return headView;
}

//不显示footer,设置高度只能设置为0.1,如果返回0则是默认高度44
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RemindCell *cell = [tableView dequeueReusableCellWithIdentifier:REMINDVIEWCELL];
    if (!cell) {
        cell = [[RemindCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REMINDVIEWCELL];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

@end
