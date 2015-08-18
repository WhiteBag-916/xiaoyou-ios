//
//  FeedContactTableView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedContactTableView.h"
#import "FeedContactTableViewCell.h"

@interface FeedContactTableView ()
<UITableViewDataSource
,UITableViewDelegate>

@end

@implementation FeedContactTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerClass:[FeedContactTableViewCell class] forCellReuseIdentifier:kFeedContactTableViewCell];
        self.tableFooterView = [[UIView alloc] init];
        self.fd_debugLogEnabled = false;
    }
    return self;
}

- (void)loadData:(NSArray *)data {
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFeedContactTableViewCell];
    
    [cell setData];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(111);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
