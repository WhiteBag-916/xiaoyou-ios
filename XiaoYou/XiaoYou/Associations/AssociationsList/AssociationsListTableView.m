//
//  AssociationsListTableView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/16.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AssociationsListTableView.h"
#import "AssociationsListTableViewCell.h"
#import "AssociationsDetailViewController.h"
#import "FeedManager.h"
#import "GroupModel.h"

#define KPAGENUM 15

@interface AssociationsListTableView ()
<UITableViewDataSource
,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *associationsListArray;
@property (nonatomic, strong) NSString *filterStr;
@property (nonatomic, strong) NSString *searchStr;

@end

@implementation AssociationsListTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _associationsListArray = [NSMutableArray array];
        
        [self registerClass:[AssociationsListTableViewCell class] forCellReuseIdentifier:kAssociationsListTableViewCell];
    }
    return self;
}

- (void)resetArray:(NSArray *)array {
    _associationsListArray = [NSMutableArray arrayWithArray:array];
    [self reloadData];
}

- (NSArray *)tableViewData {
    return _associationsListArray;
}

//筛选
- (void)resetArrayByFilter:(NSString *)filterStr {
    _filterStr = filterStr;
    [self loadData];
}

//搜索
- (void)resetArrayBySearch:(NSString *)searchStr {
    _searchStr = searchStr;
    if (_searchStr.length > 0) {
        [self loadData];
    } else {
        [_associationsListArray removeAllObjects];
        [self reloadData];
    }
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
    [self sendRequest];
}

- (void)loadMoreData
{
    [self sendRequest];
}
- (void)sendRequest {
    NSInteger cnt = _associationsListArray.count;
    if ([self isHeaderRefresh]) {
        cnt = 0;
    }
    [[FeedManager sharedInstance] groupList:cnt limitEnd:cnt + KPAGENUM name:_searchStr queryCode:_filterStr block:^(YActionMessage *message) {
        [self dealMessage:message];
    }];
}

- (void)dealMessage:(YActionMessage *)message {
    if ([self isHeaderRefresh]) {
        [_associationsListArray removeAllObjects];
    }
    if (message.isSuccess) {
        [_associationsListArray addObjectsFromArray:message.object];
        if ([message.object count] < KPAGENUM) {
            [self showNoticeNoMoreData];
        }
        [self reloadData];
        
    } else {
        [YUtils showTitleOn:self title:message.desc];
    }
    if ([self isHeaderRefresh]) {
        [self stopLoadNewData];
    } else {
        [self stopLoadMoreData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _associationsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AssociationsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAssociationsListTableViewCell];
    [cell resetData:_associationsListArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(90);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AssociationsDetailViewController *associationsDetailViewController = [[AssociationsDetailViewController alloc] initWithId:[NSString stringWithFormat:@"%g", [_associationsListArray[indexPath.row] groupModelIdentifier]]];
    [_superVC.navigationController pushViewController:associationsDetailViewController animated:YES needHiddenBottomBar:YES];
}

@end
