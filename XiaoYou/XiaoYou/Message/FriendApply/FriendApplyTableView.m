//
//  FriendApplyTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FriendApplyTableView.h"
#import "FriendApplyTableViewCell.h"
#import "ContactManager.h"

@interface FriendApplyTableView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataSourceArr;

@end

@implementation FriendApplyTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _dataSourceArr = [NSMutableArray array];
        
        [self registerClass:[FriendApplyTableViewCell class] forCellReuseIdentifier:kFriendApplyTableViewCell];
    }
    return self;
}

#pragma mark - 继承者
- (BOOL)showHeaderRefresh
{
    return YES;
}

- (void)loadData {
    [self beginLoadNewData];
}

- (void)loadNewData
{
    [self sendRequest];
}

- (void)sendRequest {
    [[ContactManager sharedInstance] getFriendApplyList:^(YActionMessage *message) {
        if (message.isSuccess) {
            _dataSourceArr = [NSMutableArray arrayWithArray:message.object];
            [self reloadData];
        } else {
            [YUtils showTitleOn:self title:message.desc];
        }
        
        [self stopLoad];
    }];
}

-(void)refreshTableView:(NSArray *) dataSouceArr
{
    _dataSourceArr = dataSouceArr;
    [self reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendApplyTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kFriendApplyTableViewCell forIndexPath:indexPath];
    
    cell.superVC = self.superVC;
    [cell setCellInfo:_dataSourceArr[indexPath.row]];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 174;
}

-(NSArray *)getDataSource
{
    return _dataSourceArr;
}


@end
