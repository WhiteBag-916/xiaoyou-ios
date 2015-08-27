//
//  FriendApplyTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FriendApplyTableView.h"
#import "FriendApplyTableViewCell.h"

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
        
        [self registerClass:[FriendApplyTableViewCell class] forCellReuseIdentifier:kFriendApplyTableViewCell];
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
    [self sendRequest];
}

- (void)sendRequest {
    //mod by xiongchen
//    NSString *lastID;
//    if (![self isHeaderRefresh]) {
//        lastID = [NSString stringWithFormat:@"%g", [[_feedListArray.lastObject feed] feedIdentifier]];
//    }
//    [[FeedManager sharedInstance] feedList:lastID size:KPAGENUM queryCode:_filter block:^(YActionMessage *message) {
//        if (message.isSuccess) {
//            if ([self isHeaderRefresh]) {
//                [_feedListArray removeAllObjects];
//            }
//            [self hiddenFooter:false];
//            [_feedListArray addObjectsFromArray:message.object];
//            if ([message.object count] < KPAGENUM) {
//                [self showNoticeNoMoreData];
//            }
//            [self reloadData];
//            
//        } else {
//            [YUtils showTitleOn:self title:message.desc];
//        }
//        if ([self isHeaderRefresh]) {
//            [self stopLoadNewData];
//        } else {
//            [self stopLoadMoreData];
//        }
//    }];
}

-(void)refreshTableView:(NSMutableArray *) dataSouceArr
{
    _dataSourceArr = dataSouceArr;
    [self reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FriendApplyTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kFriendApplyTableViewCell forIndexPath:indexPath];
    [cell setCellInfo:_dataSourceArr[indexPath.row]];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 167;
}


@end
