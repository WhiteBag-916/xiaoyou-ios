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

@interface GroupApplyTableView ()
<UITableViewDataSource,UITableViewDelegate>

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
        self.groupApplyArray = [NSMutableArray array];
        
        [self registerClass:[GroupApplyTableViewCell class]
     forCellReuseIdentifier:kGroupApplyTableViewCell];
    }
    return self;
}
#pragma mark - 刷新界面
-(void)refreshTableView:(NSArray *) dataSouceArr
{
    self.groupApplyArray = [NSMutableArray arrayWithArray:dataSouceArr];
    [self reloadData];
}

- (NSArray *)getData {
    return _groupApplyArray;
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
    
    [self hiddenFooter:YES];
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
            
            if (0 == [_groupApplyArray count]) {
                [self hiddenFooter:NO];
                [self showNoticeNoMoreData];
            }
        } else {
            [YUtils showTitleOn:self title:message.desc];
        }
        
        [self stopLoad];
    }];
}

#pragma mark - UITableViewDataSource和UITableViewDataDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _groupApplyArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GroupApplyTableViewCell * cell =
    [self dequeueReusableCellWithIdentifier:kGroupApplyTableViewCell forIndexPath:indexPath];
    cell.superVC = self.superVC;
    [cell setCellInfo:_groupApplyArray[indexPath.row]];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(174);
}


@end
