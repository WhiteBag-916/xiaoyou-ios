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
#import "ActivityManager.h"
#import "ActivityDetailModel.h"

#define REUSEID_DETAILCELL @"ActivityDetailCell"
@interface ActivityDetailListView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *activityDetailArray;

@end

@implementation ActivityDetailListView

-(instancetype)init
{
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[ActivityDetailCell class] forCellReuseIdentifier:REUSEID_DETAILCELL];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[ActivityDetailCell class] forCellReuseIdentifier:REUSEID_DETAILCELL];
    }
    return self;
}

-(NSMutableArray *)activityDetailArray
{
    if (!_activityDetailArray) {
        _activityDetailArray = [NSMutableArray array];
    }
    return _activityDetailArray;
}


-(void)sendRequest
{
    //NSString *publishID = [NSString stringWithFormat:@"%f",_model.activityPublishedId];
    [[ActivityManager sharedInstance] findActivityDetailInfo:0 limitEnd:10 activityPublishedId:@"4" getDetail:YES block:^(YActionMessage *message) {
        if (message.isSuccess) {
            
            
            [self.activityDetailArray addObject:message.object];
            [self reloadData];
        }
    }];
}


#pragma mark -协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.activityDetailArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{;
    
//    height = [tableView fd_heightForCellWithIdentifier:REUSEID_AVAILABEL_CELL cacheByIndexPath:indexPath configuration:^(AvailableCell *cell) {
//        [cell setData:_availableListArray[indexPath.row-2]];
//    }];
//    return height;
    
    //return 1000;
    CGFloat height;
//    if (indexPath.row == 0)
//        return SCALE_NUM(140);
//    else if (indexPath.row == 1)
//        return SCALE_NUM(85);
//    else {
        height = [tableView fd_heightForCellWithIdentifier:REUSEID_DETAILCELL cacheByIndexPath:indexPath configuration:^(ActivityDetailCell *cell) {
            [cell setData:self.activityDetailArray[0]];
        }];
        return height;
//    }
//    return 1100;

//    if (indexPath.row == 0 && IS_IPHONE_5)
//    {
//        if ([self.model.acBrief containsString:@"在习近平总书记"]) {
//            return SCALE_NUM(1000);
//        }
//        else if ([self.model.acBrief containsString:@"西班牙建筑风格"]) {
//            return SCALE_NUM(1130);
//        }
//        else if ([self.model.acBrief containsString:@"过好大学每一"]) {
//            return SCALE_NUM(800);
//        }
//        return SCALE_NUM(1000);
//        //height = [tableView fd_heightForCellWithIdentifier:@"activitydetail" cacheByIndexPath:indexPath configuration:^(ActivityDetailCell *cell) {
//            //[cell setData:_feedListArray[indexPath.row]];
//        //}];
//    }
//    if (indexPath.row == 0 && IS_IPHONE_6)
//    {
//        if ([self.model.acBrief containsString:@"在习近平总书记"]) {
//            return SCALE_NUM(850);
//        }
//        else if ([self.model.acBrief containsString:@"西班牙建筑风格"]) {
//            return SCALE_NUM(860);
//        }
//        else if ([self.model.acBrief containsString:@"过好大学每一"]) {
//            return SCALE_NUM(700);
//        }
//        return SCALE_NUM(810);
//    }
//    if (indexPath.row == 0 && IS_IPHONE_6P)
//    {
//        //放大模式
//        if ([UIScreen mainScreen].bounds.size.width == 320.0) {
//            
//        }
//        
//        if ([self.model.acBrief containsString:@"在习近平总书记"]) {
//            return SCALE_NUM(750);
//        }
//        else if ([self.model.acBrief containsString:@"西班牙建筑风格"]) {
//            return SCALE_NUM(800);
//        }
//        else if ([self.model.acBrief containsString:@"过好大学每一"]) {
//            return SCALE_NUM(650);
//        }
//        return SCALE_NUM(740);
//    }
//    else if (indexPath.row == 1) {
//        return SCALE_NUM(270);
//    }
//    else
//    {
//        if (indexPath.row == 0)
//            return SCALE_NUM(1000);
//        return SCALE_NUM(200);
//        //height = [tableView fd_heightForCellWithIdentifier:@"joinincell" cacheByIndexPath:indexPath configuration:^(ActivityJoinInCell *cell) {
//            //[cell setData:_feedListArray[indexPath.row]];
//        //}];
//    }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        ActivityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEID_DETAILCELL];
        if (self.activityDetailArray.count != 0)
            [cell setData:self.activityDetailArray[indexPath.row]];
        return cell;
    }
    else if (indexPath.row == 1)
    {
        ActivityJoinInCell *cell;
        cell = [ActivityJoinInCell cellWithTableView:tableView cellType:IS_TOPVIEW];
        //[cell setData:self.myDataSource2[indexPath.row-1]];
        return cell;
    }
    else
    {
        ActivityJoinInCell *cell;
        cell = [ActivityJoinInCell cellWithTableView:tableView cellType:NOT_TOPVIEW];
        //[cell setData:self.myDataSource2[indexPath.row-1]];
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
