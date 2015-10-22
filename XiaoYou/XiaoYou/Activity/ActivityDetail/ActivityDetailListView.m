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
#import "JoinInModel.h"
@interface ActivityDetailListView ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,retain) NSArray *myDataSource2;
@end

@implementation ActivityDetailListView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}


-(void)setModel:(ActivityModel *)model
{
    _model = model;
    _myDataSource2 = [self getDataSource];
    [self reloadData];
}



#pragma mark -协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{;
    CGFloat height;
    if (indexPath.row == 0 && IS_IPHONE_5)
    {
        return SCALE_NUM(1000);
        //height = [tableView fd_heightForCellWithIdentifier:@"activitydetail" cacheByIndexPath:indexPath configuration:^(ActivityDetailCell *cell) {
            //[cell setData:_feedListArray[indexPath.row]];
        //}];
    }
    if (indexPath.row == 0 && IS_IPHONE_6)
    {
        return SCALE_NUM(810);
    }
    if (indexPath.row == 0 && IS_IPHONE_6P)
    {
        return SCALE_NUM(740);
    }
    else if (indexPath.row == 1) {
        return SCALE_NUM(270);
    }
    else
    {
        return SCALE_NUM(200);
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
        [cell setData:self.model];
        return cell;
    }
    else if (indexPath.row == 1)
    {
        ActivityJoinInCell *cell;
        cell = [ActivityJoinInCell cellWithTableView:tableView cellType:IS_TOPVIEW];
        [cell setData:self.myDataSource2[indexPath.row-1]];
        return cell;
    }
    else
    {
        ActivityJoinInCell *cell;
        cell = [ActivityJoinInCell cellWithTableView:tableView cellType:NOT_TOPVIEW];
        [cell setData:self.myDataSource2[indexPath.row-1]];
        return cell;
    }
    return nil;
}


-(NSArray *)getDataSource {
    JoinInModel *m1 = [[JoinInModel alloc]init];
    m1.headImageUrl = @"http://img.qqbody.com/uploads/allimg/120624/091A44245-6.jpg";
    m1.nameStr = @"王亚楠";
    m1.sexStr = @"女";
    m1.tagsArr = @[@"托福GRE",@"考研",@"留学"];
    
    JoinInModel *m2 = [[JoinInModel alloc]init];
    m2.headImageUrl = @"http://img.qqbody.com/uploads/allimg/120624/091A44245-6.jpg";
    m2.nameStr = @"李哲";
    m2.sexStr = @"男";
    m2.tagsArr = @[@"运动",@"创业",@"雅思",@"名企实习"];
    
    JoinInModel *m3 = [[JoinInModel alloc]init];
    m3.headImageUrl = @"http://img.qqbody.com/uploads/allimg/120624/091A44245-6.jpg";
    m3.nameStr = @"王欣欣";
    m3.sexStr = @"女";
    m3.tagsArr = @[@"外资企业",@"互联网公司",@"雅思",@"考研",@"创业"];
    
    return [NSArray arrayWithObjects:m1,m2,m3, nil];
}


@end
