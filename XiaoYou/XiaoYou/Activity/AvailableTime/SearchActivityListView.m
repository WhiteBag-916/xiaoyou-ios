//
//  SearchActivityListView.m
//  XiaoYou
//
//  Created by sheng on 15/10/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "SearchActivityListView.h"
#import "AvailableCell.h"
#import "YActionMessage.h"

#define kSearchActivityListViewCell @"AvailableCell"
#define KPAGENUM 15
@interface SearchActivityListView ()
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *activitysListArray;
@property (nonatomic, strong) NSString *filterStr;
@property (nonatomic, strong) NSString *searchStr;

@end

@implementation SearchActivityListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _activitysListArray = [NSMutableArray array];
        
        [self registerClass:[AvailableCell class] forCellReuseIdentifier:kSearchActivityListViewCell];
    }
    return self;
}

- (void)resetArray:(NSArray *)array {
    _activitysListArray = [NSMutableArray arrayWithArray:array];
    [self reloadData];
}

- (NSArray *)tableViewData {
    return _activitysListArray;
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
        [_activitysListArray removeAllObjects];
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
    NSInteger cnt = _activitysListArray.count;
    if ([self isHeaderRefresh] || _searchStr.length > 0) {
        cnt = 0;
    }
//    [[FeedManager sharedInstance] groupList:cnt limitEnd:cnt + KPAGENUM name:_searchStr queryCode:_filterStr block:^(YActionMessage *message) {
//        if (nil != _searchStr) {
//            if ([_searchStr isEqualToString:[message.object searchKey]]) {
//                [self searchMessage:message];
//            }
//        } else {
//            [self dealMessage:message];
//        }
//    }];
}

- (void)dealMessage:(YActionMessage *)message {
    if (message.isSuccess) {
        [self hiddenFooter:NO];
        if ([self isHeaderRefresh]) {
            [_activitysListArray removeAllObjects];
        }
        [_activitysListArray addObjectsFromArray:[message.object groupList]];
        if ([[message.object groupList] count] < KPAGENUM) {
            [self showNoticeNoMoreData];
        }
        [self reloadData];
        
    } else {
        [YUtils showTitleOn:self title:message.desc];
    }
    
    [self stopLoad];
}

- (void)searchMessage:(YActionMessage *)message {
//    if (message.isSuccess && [_searchStr isEqualToString:[message.object searchKey]]) {
//        [self hiddenFooter:NO];
//        [_activitysListArray removeAllObjects];
//        [_activitysListArray addObjectsFromArray:[message.object groupList]];
//        if ([[message.object groupList] count] < KPAGENUM) {
//            [self showNoticeNoMoreData];
//        }
//        
//        [self reloadData];
//    } else {
//        [YUtils showTitle:message.desc];
//    }
    
    [self stopLoad];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _activitysListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    AssociationsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAssociationsListTableViewCell];
//    [cell resetData:_associationsListArray[indexPath.row]];
//    return cell;
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(90);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    GroupModel *model = _associationsListArray[indexPath.row];
//    
//    AssociationsDetailViewController *associationsDetailViewController = [[AssociationsDetailViewController alloc] initWithId:[NSString stringWithFormat:@"%g", model.internalBaseClassIdentifier] name:model.groupName];
//    [_superVC.navigationController pushViewController:associationsDetailViewController animated:YES needHiddenBottomBar:YES];
}

@end
