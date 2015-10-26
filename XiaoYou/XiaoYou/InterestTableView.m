//
//  InterestTableView.m
//  XiaoYou
//
//  Created by 李思良 on 15/10/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "InterestTableView.h"
#import "InterestTableViewCell.h"
#import "InterestSeperatorCell.h"
#import "YWebViewController.h"
#import "NSDate+Category.h"
#import "FeedManager.h"

#define KPAGENUM 8

@interface InterestTableView() <UITableViewDataSource, UITableViewDelegate>
@property (copy, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSDateFormatter *formatter;
@end

@implementation InterestTableView

- (id)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[InterestTableViewCell class] forCellReuseIdentifier:KInterestCell];
        [self registerClass:[InterestSeperatorCell class] forCellReuseIdentifier:KInterestSeperatorCell];
        [self beginLoadMoreData];
        _dataArray = [NSMutableArray array];
        _formatter = [NSDateFormatter new];
        _formatter.dateFormat = @"MM月dd日";
    }
    return self;
}

- (NSMutableArray *)createData {
    NSMutableArray *array = [NSMutableArray array];
    return array;
}
- (void)loadNewData
{
    [self sendRequest];
}

- (void)loadMoreData
{
    [self sendRequest];
}
- (BOOL)showHeaderRefresh
{
    return YES;
}

- (BOOL)showFooterRefresh
{
    return YES;
}
- (void)sendRequest {

    NSString *lastDate;
    if ([self isHeaderRefresh]) {
        lastDate = [[NSDate date] dayDescription];
    } else {
        
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        NSMutableArray *data = [NSMutableArray array];
        InterestModel *model = [[InterestModel alloc] init];
        model.picture = @"";
        model.time = [NSDate dateWithTimeIntervalSinceNow:-100000 * i];
        model.title = @"校园资讯";
        model.source = @"来源";
        model.url = @"https://www.baidu.com";
        [data addObject:model];
        [array addObject:data];
    }
    YActionMessage *message = [[YActionMessage alloc] initWithType:@"" errorCode:0 desc:@"" object:array];
    [self dealWithMessage:message];
}
- (void)dealWithMessage:(YActionMessage *)message {
    if (message.isSuccess) {
        if ([self isHeaderRefresh]) {
            [_dataArray removeAllObjects];
        }
        [self hiddenFooter:false];
        [_dataArray addObjectsFromArray:message.object];
        if ([message.object count] == 0) {
            [self showNoticeNoMoreData];
        }
        [self reloadData];
        
    } else {
        [YUtils showTitle:message.desc];
    }
    if ([self isHeaderRefresh]) {
        [self stopLoadNewData];
    } else {
        [self stopLoadMoreData];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray[section] count] * 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row % 2 == 1) {
        cell = [self dequeueReusableCellWithIdentifier:KInterestCell];
        [(InterestTableViewCell *)cell setData:_dataArray[indexPath.section][indexPath.row/2]];
    } else {
        cell = [self dequeueReusableCellWithIdentifier:KInterestSeperatorCell];
        if (indexPath.row == 0) {
            [(InterestSeperatorCell *)cell updateState:[_formatter stringFromDate:[(InterestModel *) _dataArray[indexPath.section][indexPath.row/2] time]]];
        } else {
            [(InterestSeperatorCell *)cell updateState:@""];
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return 42;
    }
    return [tableView fd_heightForCellWithIdentifier:KInterestCell cacheByIndexPath:indexPath configuration:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 1) {
        YWebViewController *web = [[YWebViewController alloc] initWithUrl:@"https://www.baidu.com" andTitle:@"百度" canClick:true];
        [_parent.navigationController pushViewController:web animated:true];
    }
}
@end
