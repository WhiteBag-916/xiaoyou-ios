//
//  FunnyDetailListView.m
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityDetailListView.h"
#import "ActivityDetailCell.h"
#import "ActivityJoinInCell.h"
@interface ActivityDetailListView ()<UITableViewDataSource,UITableViewDelegate>



@end

@implementation ActivityDetailListView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}


#pragma mark -协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{;
    CGFloat height;
    if (indexPath.row == 0)
    {
        return 500;
        //height = [tableView fd_heightForCellWithIdentifier:@"activitydetail" cacheByIndexPath:indexPath configuration:^(ActivityDetailCell *cell) {
            //[cell setData:_feedListArray[indexPath.row]];
        //}];
    }
    else
    {
        return 250;
        //height = [tableView fd_heightForCellWithIdentifier:@"joinincell" cacheByIndexPath:indexPath configuration:^(ActivityJoinInCell *cell) {
            //[cell setData:_feedListArray[indexPath.row]];
        //}];
    }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        ActivityDetailCell *cell = [ActivityDetailCell cellWithTableView:tableView];
        return cell;
    }
    else if (indexPath.row == 1)
    {
        ActivityJoinInCell *cell;
        cell = [ActivityJoinInCell cellWithTableView:tableView cellType:IS_TOPVIEW];
        return cell;
    }
    else
    {
        ActivityJoinInCell *cell;
        cell = [ActivityJoinInCell cellWithTableView:tableView cellType:NOT_TOPVIEW];
        return cell;
    }
    return nil;
}

@end
