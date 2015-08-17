//
//  FeedDetailTableView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedDetailTableView.h"
#import "FeedListTableViewCell.h"
@interface FeedDetailTableView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSArray *commentListArray;

@end

@implementation FeedDetailTableView

- (id)init {
    self = [super init];
    if (self) {
        [self registerClass:[FeedListTableViewCell class] forCellReuseIdentifier:KCommentTableViewCell];
        [self registerClass:[FeedListTableViewCell class] forCellReuseIdentifier:kFeedDetailTableViewCell];
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [[UIView alloc] init];
    }
    return self;
}

- (void)loadData:(NSArray *)data {
    _commentListArray = [NSArray arrayWithArray:@[]];
    _data = [NSDictionary dictionary];
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_data == nil) {
        return 0;
    } else {
        return _commentListArray.count + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedListTableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kFeedDetailTableViewCell];
        [cell setData];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:KCommentTableViewCell];
        [cell setData];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //计算高度
    CGFloat height;
    if (indexPath.row == 0) {
        height = [tableView fd_heightForCellWithIdentifier:kFeedDetailTableViewCell cacheByIndexPath:indexPath configuration:^(FeedListTableViewCell *cell) {
            [cell setData];
        }];
    } else {
        height = [tableView fd_heightForCellWithIdentifier:KCommentTableViewCell cacheByIndexPath:indexPath configuration:^(FeedListTableViewCell *cell) {
            [cell setData];
        }];
    }
    return height;
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
