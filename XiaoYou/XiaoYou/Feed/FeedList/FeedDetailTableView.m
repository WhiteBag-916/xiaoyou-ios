//
//  FeedDetailTableView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedDetailTableView.h"
#import "FeedListTableViewCell.h"
#import "YCommonActionSheet.h"
#import "FeedDetailViewController.h"
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
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)loadData:(NSArray *)data {
    _commentListArray = [NSArray arrayWithArray:@[@"2"]];
    _data = [NSDictionary dictionary];
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_data == nil) {
        return 0;
    } else {
        return _commentListArray.count + 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedListTableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kFeedDetailTableViewCell];
        [cell setData:nil];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:KCommentTableViewCell];
        [cell setData:nil];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //计算高度
    CGFloat height;
    if (indexPath.row == 0) {
        height = [tableView fd_heightForCellWithIdentifier:kFeedDetailTableViewCell cacheByIndexPath:indexPath configuration:^(FeedListTableViewCell *cell) {
            [cell setData:nil];
        }];
    } else {
        height = [tableView fd_heightForCellWithIdentifier:KCommentTableViewCell cacheByIndexPath:indexPath configuration:^(FeedListTableViewCell *cell) {
            [cell setData:nil];
        }];
    }
    return height;
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) {
        int index = (int)indexPath.row - 1;
        if ([_commentListArray[index] isEqualToString:@"3"]) {
            [self openTool];
        } else {
            [self openReply:index];
        }
    }
}
- (void)openReply:(int)index {
    [self.parent openInputWithId:_commentListArray[index] name:_commentListArray[index]];
}
- (void)openTool {
    
    YActionSheetItem *item1 = [YActionSheetItem itemWithType:YCommonActionSheetItemTypeShare title:@"分享这条动态至" extraData:@{@"tag":@"互联网",@"content":@"balabala",@"pic":@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg"}];
    
    
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"举报"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                            
                                                        }];
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item2] title:nil];
    [sheet show];
}
@end
