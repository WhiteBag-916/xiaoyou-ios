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

@property (nonatomic, strong) NSMutableArray *feedListArray;

@end

@implementation FeedListTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    [_feedListArray removeAllObjects];
    [self sendRequest];
}

- (void)loadMoreData
{
    [self sendRequest];
}
- (void)sendRequest {
    [[FeedManager sharedInstance] feedList:_feedListArray.count limitEnd:_feedListArray.count + KPAGENUM queryCode:@"" block:^(YActionMessage *message) {
        if (_feedListArray.count == 0) {
            [self stopLoadNewData];
        } else {
            [self stopLoadMoreData];
        }
        if (message.isSuccess) {
            [self hiddenFooter:false];
            [_feedListArray addObjectsFromArray:message.object];
            if ([message.object count] < KPAGENUM) {
                [self showNoticeNoMoreData];
            }
            [self reloadData];
            
        } else {
            [YUtils showTitleOn:self title:message.desc];
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
