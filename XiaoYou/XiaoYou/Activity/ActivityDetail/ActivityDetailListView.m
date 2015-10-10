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
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500;
    CGFloat height;
    if (indexPath.row == 0)
    {
        height = [tableView fd_heightForCellWithIdentifier:@"activitydetail" cacheByIndexPath:indexPath configuration:^(ActivityDetailCell *cell) {
            //[cell setData:_feedListArray[indexPath.row]];
        }];
    }
    else
    {
        height = [tableView fd_heightForCellWithIdentifier:@"joinincell" cacheByIndexPath:indexPath configuration:^(ActivityJoinInCell *cell) {
            //[cell setData:_feedListArray[indexPath.row]];
        }];
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
    else
    {
        ActivityJoinInCell *cell = [ActivityJoinInCell cellWithTableView:tableView];
        return cell;
    }
    return nil;
}

@end
