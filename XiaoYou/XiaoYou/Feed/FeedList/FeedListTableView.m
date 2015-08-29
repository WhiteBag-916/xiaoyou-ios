//
//  FeedListTableView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/7.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedListTableView.h"
#import "FeedListTableViewCell.h"
#import "FeedListViewController.h"
#import "FeedManager.h"
#import "FeedInfo.h"
#import "Feed.h"

#define KPAGENUM 6
@interface FeedListTableView ()
<UITableViewDataSource
,UITableViewDelegate>

@property (nonatomic, strong) NSString *filter;
@property (nonatomic, strong) NSMutableArray *feedListArray;

@end

@implementation FeedListTableView
- (id)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        _filter = @"";
        [self registerClass:[FeedListTableViewCell class] forCellReuseIdentifier:kFeedListTableViewCell];
        self.tableFooterView = [[UIView alloc] init];
        _feedListArray = [NSMutableArray array];
        self.fd_debugLogEnabled = false;
    }
    return self;
}


- (id)initWithFilter:(NSString *)filter {
    self = [super init];
    if (self) {
        _filter = filter;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[FeedListTableViewCell class] forCellReuseIdentifier:kFeedListTableViewCell];
        self.tableFooterView = [[UIView alloc] init];
        _feedListArray = [NSMutableArray array];
        self.fd_debugLogEnabled = false;
    }
    return self;
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
    //mod by xiongchen
    NSString *lastID;
    if (![self isHeaderRefresh]) {
        lastID = [NSString stringWithFormat:@"%g", [[_feedListArray.lastObject feed] feedIdentifier]];
    }
    [[FeedManager sharedInstance] feedList:lastID size:KPAGENUM queryCode:_filter block:^(YActionMessage *message) {
        if (message.isSuccess) {
            if ([self isHeaderRefresh]) {
                [_feedListArray removeAllObjects];
            }
            [self hiddenFooter:false];
            [_feedListArray addObjectsFromArray:message.object];
            if ([message.object count] < KPAGENUM) {
                [self showNoticeNoMoreData];
            }
            [self reloadData];
            
        } else {
            [YUtils showTitle:message.desc];
        }
        if ([self isHeaderRefresh]) {
            [self stopLoadNewData];
        } else {
            [self stopLoadMoreData];
        }
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _feedListArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFeedListTableViewCell];
    [cell setData:_feedListArray[indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //计算高度
    CGFloat height = [tableView fd_heightForCellWithIdentifier:kFeedListTableViewCell cacheByIndexPath:indexPath configuration:^(FeedListTableViewCell *cell) {
        [cell setData:_feedListArray[indexPath.row]];
    }];
    return height;
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_parent goToDetail:[NSString stringWithFormat:@"%d", (int)[(FeedInfo *)_feedListArray[indexPath.row] feed].feedIdentifier]];
}


@end
