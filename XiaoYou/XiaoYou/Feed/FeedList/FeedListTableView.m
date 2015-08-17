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
@interface FeedListTableView ()
<UITableViewDataSource
,UITableViewDelegate>

@property (nonatomic, strong) NSArray *feedListArray;

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
        _feedListArray = [NSArray array];
        self.fd_debugLogEnabled = false;
    }
    return self;
}

- (void)loadData:(NSArray *)data {
    _feedListArray = [NSArray arrayWithArray:data];
    [self reloadData];
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
    [cell setData];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //计算高度
    CGFloat height = [tableView fd_heightForCellWithIdentifier:kFeedListTableViewCell cacheByIndexPath:indexPath configuration:^(FeedListTableViewCell *cell) {
        [cell setData];
    }];
    return height;
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_parent goToDetail:@"233"];
}


@end
