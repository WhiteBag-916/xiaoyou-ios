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
#import "MessageManager.h"

@interface FriendApplyTableView ()
<UITableViewDataSource,UITableViewDelegate>

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
        
        [self registerClass:[FriendApplyTableViewCell class]
     forCellReuseIdentifier:kFriendApplyTableViewCell];
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
    
    [self hiddenFooter:YES];
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
            
            if (0 == [_dataSourceArr count]) {
                [self hiddenFooter:NO];
                [self showNoticeNoMoreData];
                
                [[EaseMob sharedInstance].chatManager removeConversationByChatter:_chatter
                                                                   deleteMessages:YES
                                                                      append2Chat:NO];
            }
        } else {
            [YUtils showTitleOn:self title:message.desc];
        }
        
        [self stopLoad];
    }];
}

#pragma mark - 刷新界面

-(void)refreshTableView:(NSArray *) dataSouceArr
{
    _dataSourceArr = (NSMutableArray *)dataSouceArr;
    [self reloadData];
}

#pragma mark - UITableViewDelegate和UITableViewDataSouce

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendApplyTableViewCell * cell =
    [self dequeueReusableCellWithIdentifier:kFriendApplyTableViewCell forIndexPath:indexPath];
    
    cell.superVC = self.superVC;
    [cell setCellInfo:_dataSourceArr[indexPath.row]];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(174);
}

-(NSArray *)getDataSource
{
    return _dataSourceArr;
}


@end
