//
//  ProfileFeedListView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfileFeedListView.h"
#import "ProfileFeedCell.h"
#import "FeedManager.h"
#import "FeedInfo.h"
#import "Feed.h"
#import "ProfilePublishViewController.h"

#define KPAGENUM 15

@interface ProfileFeedListView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *feedArray;
@property (nonatomic, strong) NSString *userId;
@end

@implementation ProfileFeedListView
- (id)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[ProfileFeedCell class] forCellReuseIdentifier:KProfileFeedCell];
        self.tableFooterView = [UIView new];
        self.backgroundColor = KCOLORWHITE;
        _feedArray = [NSMutableArray array];
        self.fd_debugLogEnabled = false;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
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
- (void)loadData:(NSString *)userId {
    _userId = userId;
    [self beginLoadNewData];
}
- (void)loadNewData
{
    [self sendRequest:true];
}

- (void)loadMoreData
{
    [self sendRequest:false];
}

- (void)sendRequest:(BOOL)isRefresh {
    int cnt = isRefresh?0:(int)_feedArray.count;
    [[FeedManager sharedInstance] getMyFeed:_userId limitStart:cnt limitEnd:cnt + KPAGENUM block:^(YActionMessage *message) {
        if (message.isSuccess) {
            if ([self isHeaderRefresh]) {
                [_feedArray removeAllObjects];
            }
            [self hiddenFooter:false];
            [_feedArray addObjectsFromArray:message.object];
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
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _feedArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:KProfileFeedCell];
    [cell setData:_feedArray[indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //计算高度
    CGFloat height = [tableView fd_heightForCellWithIdentifier:KProfileFeedCell cacheByIndexPath:indexPath configuration:^(ProfileFeedCell *cell) {
        [cell setData:_feedArray[indexPath.row]];
    }];
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //前往feed详情
    [YAnalysis trackEvent:@"FEED_我的FEED" withPara:nil];
    [_parent goToDetail:[NSString stringWithFormat:@"%d", (int)[(FeedInfo *)_feedArray[indexPath.row] feed].feedIdentifier]];
}
@end
