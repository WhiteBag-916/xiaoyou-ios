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
#import "Message/MessageManager.h"
#import "InterestModel.h"
#import "NewsList.h"

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
        [self beginLoadNewData];
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
        lastDate = @"0";//[[NSDate date] dayDescription];
    } else {
        lastDate = [self getYesterdayFrom:(NSInteger)[(NewsList *)[[[_dataArray lastObject] newsList] lastObject]publishTime]/1000];
    }
    [[MessageManager sharedInstance] interestList:[lastDate integerValue] maxSize:KPAGENUM block:^(YActionMessage *message) {
        if (message.isSuccess) {
            if ([self isHeaderRefresh]) {
                [_dataArray removeAllObjects];
                
                //更新消息列表的数据
                if ([message.object count] > 0) {
                    NewsList *model = [(InterestModel *)message.object[0] newsList][0];
                    [self updateMessageList:model];
                }
                
            }
            [self hiddenFooter:false];
            if (message.object != nil) {
                [_dataArray addObjectsFromArray:message.object];
            }
            if ([message.object count] < KPAGENUM) {
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
    }];
}

- (void)updateMessageList:(NewsList *)model {
    NSMutableDictionary * ext = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"GoodLookMessage"]];
    NSMutableDictionary *pushExt;
    if (nil != ext[@"em_apns_ext"]) {
        pushExt = [NSMutableDictionary dictionaryWithDictionary:ext[@"em_apns_ext"]];
        pushExt[@"em_push_title"] = model.title;
    } else {
        pushExt = [@{@"em_push_title":model.title} mutableCopy];
    }
    [ext setObject:pushExt forKey:@"em_apns_ext"];
    [ext setObject:[NSNumber numberWithDouble:model.publishTime] forKey:@"timestamp"];
    [[NSUserDefaults standardUserDefaults] setObject:ext forKey:@"GoodLookMessage"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[(InterestModel *)_dataArray[section] newsList] count] * 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row % 2 == 1) {
        cell = [self dequeueReusableCellWithIdentifier:KInterestCell];
        [(InterestTableViewCell *)cell setData:[(InterestModel *)_dataArray[indexPath.section] newsList][indexPath.row/2]];
    } else {
        cell = [self dequeueReusableCellWithIdentifier:KInterestSeperatorCell];
        if (indexPath.row == 0) {
            [(InterestSeperatorCell *)cell updateState:[_formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(NSInteger)[(NewsList *) [(InterestModel *)_dataArray[indexPath.section] newsList][indexPath.row/2] publishTime]/1000]]];
        } else {
            [(InterestSeperatorCell *)cell updateState:@""];
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        if (indexPath.row == 0) {
            return 60;
        }
        return 40;
    }
    return [tableView fd_heightForCellWithIdentifier:KInterestCell cacheByIndexPath:indexPath configuration:^(id cell) {
        [(InterestTableViewCell *)cell setData:[(InterestModel *)_dataArray[indexPath.section] newsList][indexPath.row/2]];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 1) {
        [MobClick event:@"event17"];
        NewsList *item = (NewsList *) [(InterestModel *)_dataArray[indexPath.section] newsList][indexPath.row/2];
        YWebViewController *web = [[YWebViewController alloc] initWithUrl:item.link andTitle:item.title canClick:false];
        [_parent.navigationController pushViewController:web animated:true];
    }
}
- (NSString *)getYesterdayFrom:(NSInteger)time {
    return [[NSDate dateWithTimeIntervalSince1970:(time-24*60*60)] dayDescription];
    
}
@end
