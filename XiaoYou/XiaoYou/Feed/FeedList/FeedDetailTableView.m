//
//  FeedDetailTableView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedDetailTableView.h"
#import "FeedListTableViewCell.h"
#import "YCommonActionSheet.h"
#import "FeedDetailViewController.h"
#import "FeedManager.h"
#import "FeedDetail.h"
#import "FeedInfo.h"
#import "Feed.h"
@interface FeedDetailTableView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSMutableArray *commentListArray;
@property (nonatomic, strong) NSString *feedId;
@property (nonatomic, strong) FeedInfo *feedInfo;
@property (nonatomic, strong) NSMutableDictionary *shareData;
@end

@implementation FeedDetailTableView

- (id)initWithFeedId:(NSString *)feedId {
    self = [super init];
    if (self) {
        _feedId = feedId;
        [self registerClass:[FeedListTableViewCell class] forCellReuseIdentifier:KCommentTableViewCell];
        [self registerClass:[FeedListTableViewCell class] forCellReuseIdentifier:kFeedDetailTableViewCell];
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [[UIView alloc] init];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        _commentListArray = [NSMutableArray array];
    }
    return self;
}

- (void)loadData {
    [YUtils showHUDAddedTo:self title:@"正在加载"];
    [[FeedManager sharedInstance] getFeedDetailByID:_feedId block:^(YActionMessage *message) {
        [YUtils hiddenProgressHUD:self];
        if (message.isSuccess) {
            [self dealData:message.object];
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
}

- (void)dealData:(FeedDetail *)info {
    _feedInfo = [FeedInfo new];
    _feedInfo.tags = info.tags;
    _feedInfo.author = info.author;
    _feedInfo.feed = info.feed;
    _feedInfo.praisePeoples = info.praisePeoples;
    NSString *tag = (_feedInfo.tags.count == 0?@"校友观点":[_feedInfo.tags[0] name]);
    NSString *content = (_feedInfo.feed.content.length == 0?@"":_feedInfo.feed.content);
    _shareData = [NSMutableDictionary dictionaryWithObjectsAndKeys:tag,@"tag",content,@"content", nil];
    _commentListArray = [NSMutableArray arrayWithArray:info.commentListItems];
    [self reloadData];
}

#pragma mark - 继承者
- (BOOL)showFooterRefresh
{
    return YES;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_feedInfo == nil) {
        return 0;
    } else {
        return _commentListArray.count + 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedListTableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kFeedDetailTableViewCell];
        [cell setData:_feedInfo];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:KCommentTableViewCell];
        [cell setData:nil];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //计算高度
    CGFloat height;
    if (indexPath.row == 0) {
        height = [tableView fd_heightForCellWithIdentifier:kFeedDetailTableViewCell cacheByIndexPath:indexPath configuration:^(FeedListTableViewCell *cell) {
            [cell setData:_feedInfo];
        }];
    } else {
        height = [tableView fd_heightForCellWithIdentifier:KCommentTableViewCell cacheByIndexPath:indexPath configuration:^(FeedListTableViewCell *cell) {
            [cell setData:nil];
        }];
    }
    return height;
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) {
        int index = (int)indexPath.row - 1;
        if ([_commentListArray[index] isEqualToString:@"3"]) {
            [self openTool];
        } else {
            [self openReply:index];
        }
    }
}
- (void)openReply:(int)index {
    [self.parent openInputWithId:_commentListArray[index] name:_commentListArray[index]];
}
- (void)openTool {
    
    YActionSheetItem *item1 = [YActionSheetItem itemWithType:YCommonActionSheetItemTypeShare title:@"分享这条动态至" extraData:@{@"tag":@"互联网",@"content":@"balabala",@"pic":@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg"}];
    
    
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"举报"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                            
                                                        }];
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item2] title:nil];
    [sheet show];
}
@end
