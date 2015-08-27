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
    [self sendRequest];
}

- (void)loadMoreData
{
    [self sendRequest];
}

- (void)sendRequest {
    [[FeedManager sharedInstance] getMyFeed:_userId limitStart:_feedArray.count limitEnd:_feedArray.count + KPAGENUM block:^(YActionMessage *message) {
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
@end
