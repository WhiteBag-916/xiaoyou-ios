//
//  GroupApplyTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "GroupApplyTableView.h"
#import "GroupApplyTableViewCell.h"
#import "ContactManager.h"

@interface GroupApplyTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSMutableArray *groupApplyArray;

@end

@implementation GroupApplyTableView

- (instancetype)initWithGroupId:(NSString *)groupId
{
    self = [super init];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _groupId = groupId;
        _groupApplyArray = [NSMutableArray array];
        
        [self registerClass:[GroupApplyTableViewCell class] forCellReuseIdentifier:kGroupApplyTableViewCell];
    }
    return self;
}

-(void)refreshTableView:(NSMutableArray *) dataSouceArr
{
    [self reloadData];
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
    [[ContactManager sharedInstance] applyListApply:_groupId block:^(YActionMessage *message) {
        if (message.isSuccess) {
            _groupApplyArray = [NSMutableArray arrayWithArray:message.object];
            [self reloadData];
        } else {
            [YUtils showTitleOn:self title:message.desc];
        }
        
        [self stopLoad];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _groupApplyArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GroupApplyTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kGroupApplyTableViewCell forIndexPath:indexPath];
    cell.superVC = self.superVC;
    [cell setCellInfo:_groupApplyArray[indexPath.row]];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 167;
}


@end
