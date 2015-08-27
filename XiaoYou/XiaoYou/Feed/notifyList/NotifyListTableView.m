//
//  NotifyListTableView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "NotifyListTableView.h"
#import "NotifyListTableViewCell.h"
#import "AlertList.h"
#import "FeedManager.h"
#import "FeedDetailViewController.h"
#import "AlertList.h"

#define KPAGENUM 10

@interface NotifyListTableView ()
<UITableViewDataSource
,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *notifyListArray;

@end

@implementation NotifyListTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.notifyListArray = [NSMutableArray array];
        
        [self registerClass:[NotifyListTableViewCell class] forCellReuseIdentifier:kNotifyListTableViewCell];
    }
    return self;
}

//清除所有数据
- (void)readAll {
    if (_notifyListArray.count > 0) {
        [_notifyListArray removeAllObjects];
        [self reloadData];
        
        //发请求
        [[FeedManager sharedInstance] readAll:^(YActionMessage *message) {
            YLogD(@"readAll:%@", message.desc);
        }];
    }
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

- (void)loadMoreData
{
    [self sendRequest];
}
- (void)sendRequest {
    //mod by xiongchen
    NSString *lastID;
    if (![self isHeaderRefresh]) {
        lastID = [NSString stringWithFormat:@"%g", [_notifyListArray.lastObject affectId]];
    }
    [[FeedManager sharedInstance] alertList:lastID size:KPAGENUM block:^(YActionMessage *message) {
        if (message.isSuccess) {
            if ([self isHeaderRefresh]) {
                [_notifyListArray removeAllObjects];
            }
            [self hiddenFooter:false];
            [_notifyListArray addObjectsFromArray:message.object];
            if ([message.object count] < KPAGENUM) {
                [self showNoticeNoMoreData];
            }
            [self reloadData];
            
        } else {
            [YUtils showTitleOn:self title:message.desc];
        }
        if ([self isHeaderRefresh]) {
            [self stopLoadNewData];
        } else {
            [self stopLoadMoreData];
        }
    }];
}

//清除当前界面存在这个feedid的数据
- (void)delArrayByAffectId:(NSInteger)affectId {
    for (int i = 0; i < _notifyListArray.count; ++i) {
        if ([_notifyListArray[i] affectId] == affectId) {
            [_notifyListArray removeObjectAtIndex:i];
            --i;
        }
    }
    
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _notifyListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotifyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNotifyListTableViewCell];
    
    [cell initData:_notifyListArray[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(51);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedDetailViewController *feedDetailViewController = [[FeedDetailViewController alloc] initWithFeedId:[NSString stringWithFormat:@"%g", [_notifyListArray[indexPath.row] affectId]]];
    [_superVC.navigationController pushViewController:feedDetailViewController animated:YES needHiddenBottomBar:YES];
    
    //清除当前界面存在这个feedid的数据
    [self delArrayByAffectId:[_notifyListArray[indexPath.row] affectId]];
}

@end
