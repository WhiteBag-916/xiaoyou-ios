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
#import "JoinInModelTest.h"
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


-(void)setModel:(ActivityModelTest *)model
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
    CGFloat height = 1000;
    if (indexPath.row == 0 && IS_IPHONE_5)
    {
        if ([self.model.acBrief containsString:@"在习近平总书记"]) {
            return SCALE_NUM(1000);
        }
        else if ([self.model.acBrief containsString:@"西班牙建筑风格"]) {
            return SCALE_NUM(1130);
        }
        else if ([self.model.acBrief containsString:@"过好大学每一"]) {
            return SCALE_NUM(800);
        }
        return SCALE_NUM(1000);
        //height = [tableView fd_heightForCellWithIdentifier:@"activitydetail" cacheByIndexPath:indexPath configuration:^(ActivityDetailCell *cell) {
            //[cell setData:_feedListArray[indexPath.row]];
        //}];
    }
    if (indexPath.row == 0 && IS_IPHONE_6)
    {
        if ([self.model.acBrief containsString:@"在习近平总书记"]) {
            return SCALE_NUM(850);
        }
        else if ([self.model.acBrief containsString:@"西班牙建筑风格"]) {
            return SCALE_NUM(860);
        }
        else if ([self.model.acBrief containsString:@"过好大学每一"]) {
            return SCALE_NUM(700);
        }
        return SCALE_NUM(810);
    }
    if (indexPath.row == 0 && IS_IPHONE_6P)
    {
        //放大模式
        if ([UIScreen mainScreen].bounds.size.width == 320.0) {
            
        }
        
        if ([self.model.acBrief containsString:@"在习近平总书记"]) {
            return SCALE_NUM(750);
        }
        else if ([self.model.acBrief containsString:@"西班牙建筑风格"]) {
            return SCALE_NUM(800);
        }
        else if ([self.model.acBrief containsString:@"过好大学每一"]) {
            return SCALE_NUM(650);
        }
        return SCALE_NUM(740);
    }
    else if (indexPath.row == 1) {
        return SCALE_NUM(270);
    }
    else
    {
        if (indexPath.row == 0)
            return SCALE_NUM(1000);
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
    JoinInModelTest *m1 = [[JoinInModelTest alloc]init];
    m1.headImageUrl = @"http://img.qqbody.com/uploads/allimg/120624/091A44245-6.jpg";
    m1.nameStr = @"王亚楠";
    m1.sexStr = @"女";
    m1.tagsArr = @[@"托福GRE",@"考研",@"留学"];
    
    JoinInModelTest *m2 = [[JoinInModelTest alloc]init];
    m2.headImageUrl = @"http://img1.touxiang.cn/uploads/20130925/25-072725_605.jpg";
    m2.nameStr = @"李哲";
    m2.sexStr = @"男";
    m2.tagsArr = @[@"运动",@"创业",@"雅思",@"名企实习"];
    
    JoinInModelTest *m3 = [[JoinInModelTest alloc]init];
    m3.headImageUrl = @"http://img.sj33.cn/uploads/allimg/200801/2008012001210907.jpg";
    m3.nameStr = @"王欣欣";
    m3.sexStr = @"女";
    m3.tagsArr = @[@"外资企业",@"互联网公司",@"雅思",@"考研",@"创业"];
    
    return [NSArray arrayWithObjects:m1,m2,m3, nil];
}


@end
