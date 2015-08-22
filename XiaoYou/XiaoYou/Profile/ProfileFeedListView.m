//
//  ProfileFeedListView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfileFeedListView.h"
#import "ProfileFeedCell.h"
@interface ProfileFeedListView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *feedArray;
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
        self.fd_debugLogEnabled = false;
    }
    return self;
}
- (void)loadData:(NSArray *)data {
    _feedArray = [NSArray arrayWithArray:data];
    [self reloadData];
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
    [cell setData];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //计算高度
    CGFloat height = [tableView fd_heightForCellWithIdentifier:KProfileFeedCell cacheByIndexPath:indexPath configuration:^(ProfileFeedCell *cell) {
        [cell setData];
    }];
    return height;
}
@end
