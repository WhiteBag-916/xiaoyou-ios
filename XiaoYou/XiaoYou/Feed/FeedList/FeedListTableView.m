//
//  FeedListTableView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/7.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedListTableView.h"
#import "FeedListTableViewCell.h"

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
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _feedListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFeedListTableViewCell];
    [cell setData];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //计算高度
    CGFloat height = [tableView fd_heightForCellWithIdentifier:kFeedListTableViewCell cacheByIndexPath:indexPath configuration:^(FeedListTableViewCell *cell) {
        [cell setData];
    }];
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
