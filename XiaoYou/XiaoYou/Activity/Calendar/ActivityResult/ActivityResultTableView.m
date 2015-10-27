//
//  ActivityResultTableView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/16.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityResultTableView.h"
#import "AvailableCell.h"
#import "ActivityDetailViewController.h"
#import "ActivityManager.h"
#import "ActivityInfoModel.h"
#import "ActivityImageTextModels.h"
#import "UITableView+FDTemplateLayoutCell.h"

#define REUSEID_AVAILABEL_CELL @"AvailableCell"
#define KPAGENUM 10

@interface ActivityResultTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation ActivityResultTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[AvailableCell class] forCellReuseIdentifier:REUSEID_AVAILABEL_CELL];
        _currentIndex = 0;
    }
    return self;
}

-(NSMutableArray *)dataSouceArr
{
    if (!_dataSouceArr) {
        _dataSouceArr = [NSMutableArray array];
    }
    return _dataSouceArr;
}

#pragma mark - 继承者
- (BOOL)showHeaderRefresh
{
    return YES;
}

- (BOOL)showFooterRefresh
{
    return YES;
}

- (void)loadData {
    [self beginLoadNewData];
}

- (void)loadNewData
{
    _currentIndex = 0;
    [self sendRequest];
}

- (void)loadMoreData
{
    _currentIndex = self.dataSouceArr.count;
    [self sendRequest];
}

- (void)sendRequest{
    [[ActivityManager sharedInstance] getCurrentUseAvailableListLimitStart:_currentIndex limitEnd:_currentIndex+KPAGENUM dic:_requestDic block:^(YActionMessage *message) {
        if (message.isSuccess) {
            if ([self isHeaderRefresh]) {
                [self.dataSouceArr removeAllObjects];
            }
            
//            NSLog(@"this is message = %@",message);
            
            
            [self.dataSouceArr addObjectsFromArray:message.object];
            
            
            [self hiddenFooter:NO];
            if ([message.object count] < KPAGENUM) {
                [self showNoticeNoMoreData];
            }
            [self reloadData];
            _currentIndex += KPAGENUM;
        } else {
            [YUtils showTitle:message.desc];
        }
        if ([self isHeaderRefresh]) {
            [self stopLoadNewData];
        } else
        {
            [self stopLoadMoreData];
        }
    }];
    
    
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSouceArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AvailableCell * cell = [tableView dequeueReusableCellWithIdentifier:REUSEID_AVAILABEL_CELL forIndexPath:indexPath];
    [cell setData:_dataSouceArr[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
     if ([cell isKindOfClass:[AvailableCell class]]) {
        [self gotoDetailWithCellType];
    }
}

-(void)gotoDetailWithCellType
{
    ActivityDetailViewController *activityDetailVC = [[ActivityDetailViewController alloc]init];
    [self.viewController.navigationController pushViewController:activityDetailVC animated:YES needHiddenBottomBar:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat height;
    
    height = [tableView fd_heightForCellWithIdentifier:REUSEID_AVAILABEL_CELL cacheByIndexPath:indexPath configuration:^(AvailableCell *cell) {
        [cell setData:_dataSouceArr[indexPath.row]];
    }];
    return height;
    
}

@end
