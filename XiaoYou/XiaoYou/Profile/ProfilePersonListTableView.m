
//
//  ProfilePersonListTableView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfilePersonListTableView.h"
#import "ProfilePersonListTableViewCell.h"
@interface ProfilePersonListTableView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) int type;
@property (nonatomic, strong) NSString *feedId;
@property (nonatomic, strong) NSArray *personListArray;
@end

@implementation ProfilePersonListTableView
- (id)initWIthType:(int)type {
    self = [super init];
    if (self) {
        _type = type;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[ProfilePersonListTableViewCell class] forCellReuseIdentifier:kProfilePersonListTableViewCell];
        self.tableFooterView = [UIView new];
        self.backgroundColor = KCOLORGREEN_f2f2f2;
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
    
}

- (void)loadMoreData
{
    
}

- (void)loadDataWithFeedId:(NSString *)feedId {
    _feedId = feedId;
    [self reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _personListArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfilePersonListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kProfilePersonListTableViewCell];
    [cell setData:nil];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KCELLHEIGHT;
}
@end
