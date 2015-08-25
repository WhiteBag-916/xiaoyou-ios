
//
//  ProfilePersonListTableView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfilePersonListTableView.h"
#import "ProfilePersonListTableViewCell.h"
#import "ProvisionManager.h"

#define KPAGENUM 15

@interface ProfilePersonListTableView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) int type;
@property (nonatomic, strong) NSString *feedId;
@property (nonatomic, strong) NSMutableArray *personListArray;
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
        _personListArray = [NSMutableArray array];
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
    [_personListArray removeAllObjects];
    [self sendRequest];
}

- (void)loadMoreData
{
    [self sendRequest];
}
- (void)sendRequest {
    if (_type == 0) {
        [[ProvisionManager sharedInstance] myPraisePersons:_personListArray.count limitEnd:_personListArray.count + KPAGENUM block:^(YActionMessage *message) {
            [self dealMessage:message];
        }];
    }
    
    if (_type == 1) {
        [[ProvisionManager sharedInstance] myCoolPersons:_personListArray.count limitEnd:_personListArray.count + KPAGENUM block:^(YActionMessage *message) {
            [self dealMessage:message];
        }];
    }
}
- (void)dealMessage:(YActionMessage *)message {
    if (_personListArray.count == 0) {
        [self stopLoadNewData];
    } else {
        [self stopLoadMoreData];
    }
    if (message.isSuccess) {
        [_personListArray addObjectsFromArray:message.object];
        if ([message.object count] < KPAGENUM) {
            [self showNoticeNoMoreData];
        }
        [self reloadData];
        
    } else {
        [YUtils showTitleOn:self title:message.desc];
    }
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
    [cell setData:_personListArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KCELLHEIGHT;
}
@end
