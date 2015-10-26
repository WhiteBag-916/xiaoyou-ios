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

@interface InterestTableView() <UITableViewDataSource, UITableViewDelegate>
@property (copy, nonatomic) NSMutableArray *dataArray;
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
    }
    return self;
}

- (NSMutableArray *)createData {
    NSMutableArray *array = [NSMutableArray array];
    return array;
}

- (BOOL)showHeaderRefresh
{
    return YES;
}

- (BOOL)showFooterRefresh
{
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row % 2 == 1) {
        cell = [self dequeueReusableCellWithIdentifier:KInterestCell];
        InterestModel *model = [[InterestModel alloc] init];
        model.picture = @"";
        model.time = [NSDate dateWithTimeIntervalSinceNow:-1000];
        model.title = @"校园资讯";
        model.source = @"来源";
        model.url = @"https://www.baidu.com";
        [(InterestTableViewCell *)cell setData:model];
    } else {
        cell = [self dequeueReusableCellWithIdentifier:KInterestSeperatorCell];
        if (indexPath.row == 0) {
            [(InterestSeperatorCell *)cell updateState:@"12月12日"];
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
