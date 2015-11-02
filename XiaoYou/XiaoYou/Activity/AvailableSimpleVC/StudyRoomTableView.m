//
//  StudyRoomTableView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "StudyRoomTableView.h"
#import "StudyRoomTableViewCell.h"
#import "AvailableSimpleViewController.h"
#import "ActivityManager.h"
#import "FreeBuildingListModel.h"
#import "Tags.h"
#import "Result.h"

@interface StudyRoomTableView ()
<UITableViewDataSource
,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataSouceArr;
@property(nonatomic,strong)NSMutableArray * dataSouceArrOriginal;

@end

@implementation StudyRoomTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self sendRequest];
        
        [self registerClass:[StudyRoomTableViewCell class] forCellReuseIdentifier:kStudyRoomTableViewCell];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView:) name:KNotification_Study_Room_Filtrate object:nil];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)refreshTableView:(NSNotification *) info
{
    NSLog(@"%@",info.object);
    
    NSArray * tempArr = [NSArray arrayWithArray:self.dataSouceArrOriginal];
    
    [self.dataSouceArr removeAllObjects];
    if ([info.object[@"schoolName"] isEqualToString:@"全部"])
    {
        [self.dataSouceArr addObjectsFromArray:self.dataSouceArrOriginal];
    }
    else
    {
        for (int i = 0 ; i < tempArr.count ; i++)
        {
            Result * resultModel = tempArr[i];
            if ([info.object[@"schoolName"] isEqualToString:resultModel.schoolArea])
            {
                [self.dataSouceArr addObject:resultModel];
            }
        }
    }
    NSLog(@"%@",self.dataSouceArr);
    [self reloadData];
}
-(NSMutableArray *)dataSouceArr
{
    if (!_dataSouceArr) {
        _dataSouceArr = [NSMutableArray array];
    }
    return _dataSouceArr;
}

-(NSMutableArray *)campusDataSouceArr
{
    if (!_campusDataSouceArr) {
        _campusDataSouceArr = [NSMutableArray array];
    }
    return _campusDataSouceArr;
}

#pragma mark - 继承者
- (BOOL)showHeaderRefresh
{
    return NO;
}

- (BOOL)showFooterRefresh
{
    return NO;
}

- (void)loadData {
    [self beginLoadNewData];
}

- (void)loadNewData
{
    [self sendRequest];
}

- (void)loadMoreData
{
    [self sendRequest];
}

- (void)sendRequest{
    
    [YUtils showHUDWithTitle];
    [[ActivityManager sharedInstance] freeBuildingList:^(YActionMessage *message) {
        
        [YUtils hiddenProgressHUD];
        
        if (message.isSuccess)
        {
            FreeBuildingListModel * model = message.object;
            self.dataSouceArrOriginal = [NSMutableArray arrayWithArray:model.result];
            self.dataSouceArr = [NSMutableArray arrayWithArray:model.result];
            [self reloadData];
            
            self.campusDataSouceArr = (NSMutableArray *)model.filter;
        }
        else
        {
            [YUtils showTitle:message.desc hideAfter:2];
        }
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSouceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudyRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStudyRoomTableViewCell];
    [cell initData:_dataSouceArr[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AvailableSimpleViewController *vc = [[AvailableSimpleViewController alloc] initWithType:AvailableSimpleTypeStudyRoomDetail];
    vc.num = indexPath.row;
    Result * model = _dataSouceArr[indexPath.row];
    vc.buildName = model.buildName;
    [self.viewController.navigationController pushViewController:vc animated:YES needHiddenBottomBar:YES];
    return;
}
@end
