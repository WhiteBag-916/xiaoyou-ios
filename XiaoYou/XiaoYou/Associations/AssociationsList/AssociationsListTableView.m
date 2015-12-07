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
#import "GroupAllList.h"
#import "AssociationsSearchViewController.h"

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
        
        [self registerClass:[AssociationsListTableViewCell class]
     forCellReuseIdentifier:kAssociationsListTableViewCell];
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
    if (![_filterStr isEqualToString:filterStr]) {
        _filterStr = filterStr;
        [self loadData];
    }
}

//搜索
- (void)resetArrayBySearch:(NSString *)searchStr {
    _searchStr = searchStr;
    if (_searchStr.length > 0) {
        [self sendRequest];
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
    [[FeedManager sharedInstance] groupList:cnt
                                   limitEnd:cnt + KPAGENUM
                                       name:_searchStr
                                  queryCode:_filterStr
                                      block:^(YActionMessage *message) {
        if (message.isSuccess) {
            if (_searchStr != nil) {
                [self searchMessage:message];
            } else {
                [self dealMessage:message];
            }
        } else {
            [YUtils showTitleOn:self title:message.desc];
        }
        
        [self stopLoad];
    }];
}

- (void)dealMessage:(YActionMessage *)message {
    [self hiddenFooter:NO];
    if ([self isHeaderRefresh]) {
        [_associationsListArray removeAllObjects];
    }
    [_associationsListArray addObjectsFromArray:[message.object groupList]];
    if ([[message.object groupList] count] < KPAGENUM) {
        [self showNoticeNoMoreData];
    }
    [self reloadData];
}

- (void)searchMessage:(YActionMessage *)message {
    if ([_searchStr isEqualToString:[message.object searchKey]]) {
        
        if ([self isFooterRefresh]) {
            [_associationsListArray addObjectsFromArray:[message.object groupList]];
            if ([[message.object groupList] count] < KPAGENUM) {
                [self showNoticeNoMoreData];
            }
            
            [self reloadData];
        } else {
            //如果一条数据也没有，则显示nodata
            AssociationsSearchViewController *vc
            = (AssociationsSearchViewController *)self.viewController;
            if ([[message.object groupList] count] <= 0) {
                [vc hiddenNodata:NO];
            } else {
                [vc hiddenNodata:YES];
                [self hiddenFooter:NO];
                [_associationsListArray removeAllObjects];
                [_associationsListArray addObjectsFromArray:[message.object groupList]];
                if ([[message.object groupList] count] < KPAGENUM) {
                    [self showNoticeNoMoreData];
                }
                
                [self reloadData];
            }
        }
        
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _associationsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AssociationsListTableViewCell *cell = [tableView
                                           dequeueReusableCellWithIdentifier:kAssociationsListTableViewCell];
    [cell resetData:_associationsListArray[indexPath.row] isDetail:NO];
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
    
    GroupModel *model = _associationsListArray[indexPath.row];
    
    [YAnalysis trackEvent:@"社团头像_社团汇总" withPara:@{@"名称":model.groupName}];
    
    AssociationsDetailViewController *associationsDetailViewController
    = [[AssociationsDetailViewController alloc] initWithId:[NSString stringWithFormat:@"%g"
                                                            , model.internalBaseClassIdentifier]
                                                      name:model.groupName];
    [_superVC.navigationController pushViewController:associationsDetailViewController
                                             animated:YES
                                  needHiddenBottomBar:YES];
}

@end
