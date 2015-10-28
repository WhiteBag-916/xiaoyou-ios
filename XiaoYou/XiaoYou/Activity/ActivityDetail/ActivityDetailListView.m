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

#define REUSEID_DETAILCELL  @"ActivityDetailCell"
#define REUSEID_JOINCELL    @"ActivityJoinInCell"
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
        [self registerClass:[ActivityJoinInCell class] forCellReuseIdentifier:REUSEID_JOINCELL];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[ActivityDetailCell class] forCellReuseIdentifier:REUSEID_DETAILCELL];
        [self registerClass:[ActivityJoinInCell class] forCellReuseIdentifier:REUSEID_JOINCELL];
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
    [_activityDetailArray removeAllObjects];
    [[ActivityManager sharedInstance] findActivityDetailInfo:0 limitEnd:10 activityPublishedId:self.publishID getDetail:YES block:^(YActionMessage *message) {
        if (message.isSuccess) {
            
            [self.activityDetailArray addObject:message.object];
            [self reloadData];
        }
    }];
}


#pragma mark -协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.activityDetailArray.count == 0)
        return 0;
    else {
        ActivityDetailModel *model = self.activityDetailArray[0];
        return 1 + model.enrollActivityUserInfos.count ;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{;
    CGFloat height;
    if (indexPath.row == 0) {
        height = [tableView fd_heightForCellWithIdentifier:REUSEID_DETAILCELL cacheByIndexPath:indexPath        configuration:^(ActivityDetailCell *cell) {
                [cell setData:self.activityDetailArray[indexPath.row]];
        }];
    }
    else
    {
        height = 300;
//        height = [tableView fd_heightForCellWithIdentifier:REUSEID_DETAILCELL cacheByIndexPath:indexPath        configuration:^(ActivityJoinInCell *cell) {
//            [cell setData:self.activityDetailArray[indexPath.row]];
//        }];

    }
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
    else
    {
        ActivityJoinInCell *cell;
#pragma mark 此处以后要考虑复用
        //cell = [tableView dequeueReusableCellWithIdentifier:REUSEID_JOINCELL];
        CELLTYPE type = indexPath.row == 1? IS_TOPVIEW : NOT_TOPVIEW;
        cell = [[ActivityJoinInCell alloc]initWithType:type];
        
        ActivityDetailModel *model = self.activityDetailArray[0];
        [cell setData:model.enrollActivityUserInfos[indexPath.row-1]];
        return cell;
    }
    return nil;
}


//-(NSArray *)getDataSource {
//    JoinInModelTest *m1 = [[JoinInModelTest alloc]init];
//    m1.headImageUrl = @"http://img.qqbody.com/uploads/allimg/120624/091A44245-6.jpg";
//    m1.nameStr = @"王亚楠";
//    m1.sexStr = @"女";
//    m1.tagsArr = @[@"托福GRE",@"考研",@"留学"];
//    
//    JoinInModelTest *m2 = [[JoinInModelTest alloc]init];
//    m2.headImageUrl = @"http://img1.touxiang.cn/uploads/20130925/25-072725_605.jpg";
//    m2.nameStr = @"李哲";
//    m2.sexStr = @"男";
//    m2.tagsArr = @[@"运动",@"创业",@"雅思",@"名企实习"];
//    
//    JoinInModelTest *m3 = [[JoinInModelTest alloc]init];
//    m3.headImageUrl = @"http://img.sj33.cn/uploads/allimg/200801/2008012001210907.jpg";
//    m3.nameStr = @"王欣欣";
//    m3.sexStr = @"女";
//    m3.tagsArr = @[@"外资企业",@"互联网公司",@"雅思",@"考研",@"创业"];
//    
//    return [NSArray arrayWithObjects:m1,m2,m3, nil];
//}

@end
