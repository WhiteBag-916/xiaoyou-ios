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
#import "Comment.h"
#import "Author.h"
#import "CommentListItems.h"
#import "FeedDetailViewController.h"
#import "ProvisionManager.h"
#import "YCommonReport.h"

#define KPAGENUM 10

@interface FeedDetailTableView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSMutableArray *commentListArray;
@property (nonatomic, strong) NSString *feedId;
@property (nonatomic, strong) FeedInfo *feedInfo;
@property (nonatomic, strong) NSMutableDictionary *shareData;

@end

@implementation FeedDetailTableView

- (id)init {
    self = [super init];
    if (self) {
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
- (void)refresh {
    [self sendRequest:true];
}
- (void)loadDataWithFeedId:(NSString *)feedId {
    if (nil == _feedId) {
        _feedId = feedId;
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
}

- (void)dealData:(FeedDetail *)info {
    _feedInfo = [FeedInfo new];
    _feedInfo.tags = info.tags;
    _feedInfo.author = info.author;
    _feedInfo.feed = info.feed;
    _feedInfo.praisePeoples = info.praisePeoples;
    NSString *tag = (_feedInfo.tags.count == 0?@"校友观点":[_feedInfo.tags[0] name]);
    NSString *content = (_feedInfo.feed.content.length == 0?@"":_feedInfo.feed.content);
    NSString *img = _feedInfo.feed.img.length > 0?[_feedInfo.feed.img componentsSeparatedByString:@","][0]:@"";
    _shareData = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", (int)_feedInfo.feed.feedIdentifier], @"feedId", tag,@"tag",content,@"content",img, @"pic", nil];
    
    _commentListArray = [NSMutableArray arrayWithArray:info.commentListItems];
    if (_commentListArray.count < KPAGENUM) {
        [self hiddenFooter:true];
    } else {
        [self hiddenFooter:false];
    }
    [self reloadData];
    
}
- (void)loadMoreData
{
    [self sendRequest:false];
}
- (void)sendRequest:(BOOL)refresh {
    NSString *lastId = refresh?@"":[NSString stringWithFormat:@"%d", (int)[(CommentListItems *)_commentListArray[_commentListArray.count - 1] comment].commentIdentifier];
    [[FeedManager sharedInstance] listComment:lastId size:KPAGENUM feedId:_feedId block:^(YActionMessage *message) {
        [self stopLoadMoreData];
        if (message.isSuccess) {
            if (refresh) {
                _commentListArray = [NSMutableArray arrayWithArray:message.object];
            } else {
                [_commentListArray addObjectsFromArray:message.object];
            }
            if ([message.object count] < KPAGENUM) {
                [self showNoticeNoMoreData];
            }
            if (_commentListArray.count < KPAGENUM) {
                [self hiddenFooter:true];
            } else {
                [self hiddenFooter:false];
            }
            [self reloadData];
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
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
        [cell setData:_commentListArray[indexPath.row-1]];
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
            [cell setData:_commentListArray[indexPath.row-1]];
        }];
    }
    return height;
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) {
        int index = (int)indexPath.row - 1;
        CommentListItems *item = _commentListArray[index];
        if ([item.author.uid isEqualToString:[[ProvisionManager sharedInstance] getUserId]]) {
            [self openOperate:index];
        } else {
            if ([[[ProvisionManager sharedInstance] getUserId] isEqualToString:_feedInfo.author.uid]) {
                [self openAuthorOperate:index];
            }
            [self openReply:index];
        }
    }
}
- (void)openReply:(int)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index + 1 inSection:0];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:false];
    CommentListItems *item = _commentListArray[index];
    [self.parent openInputWithId:item.author.uid name:item.author.name];
}
- (void)openTool {
    
    YActionSheetItem *item1 = [YActionSheetItem itemWithType:YCommonActionSheetItemTypeShareFeed title:@"分享这条动态至" extraData:_shareData];
    
    
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"举报"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                            [YCommonReport report];
                                                        }];
    YActionSheetItem *item3 = [YActionSheetItem itemWithTitle:@"删除"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                            [self deleteFeed];
                                                        }];
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:[_feedInfo.author.uid isEqualToString:[[ProvisionManager sharedInstance] getUserId]]?@[item1, item3]:@[item1, item2] title:nil];
    [sheet show];
}
- (void)deleteFeed {
    YCommonAlertView *alert = [[YCommonAlertView alloc] initWithTitle:nil message:@"是否确认删除？" buttonTitles:@"取消",@"确认", nil];
    [alert clickedButtonHandler:^(NSInteger index) {
        [alert hide];
        if (index == 1) {
            [[FeedManager sharedInstance] deleteFeed:_feedId block:^(YActionMessage *message) {
                if (message.isSuccess) {
                    [YUtils showTitle:@"删除成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.parent.navigationController popViewControllerAnimated:true];
                    });
                } else {
                    [YUtils showTitle:message.desc];
                }
            }];
        }
    }];
    [alert show];
}
- (void)openOperate:(int)commentIndex {
    YActionSheetItem *item = [YActionSheetItem itemWithTitle:@"删除"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                            [self dealComment:commentIndex];
                                                        }];
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item] title:nil];
    [sheet show];
}
- (void)openAuthorOperate:(int)commentIndex {
    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"回复"
                                                        type:YCommonActionSheetItemTypeCommon
                                                       block:^(NSInteger checkNum) {
                                                           [self openReply:commentIndex];
                                                       }];
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"删除"
                                                        type:YCommonActionSheetItemTypeCommon
                                                       block:^(NSInteger checkNum) {
                                                           [self dealComment:commentIndex];
                                                       }];
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item2] title:nil];
    [sheet show];
}
- (void)dealComment:(int)commentIndex {
    YCommonAlertView *alert = [[YCommonAlertView alloc] initWithTitle:nil message:@"是否确认删除该评论？" buttonTitles:@"取消",@"确认", nil];
    [alert clickedButtonHandler:^(NSInteger index) {
        [alert hide];
        if (index == 1) {
            CommentListItems *cmt = _commentListArray[commentIndex];
            [[FeedManager sharedInstance] deleteComment:[NSString stringWithFormat:@"%d", (int)cmt.comment.commentIdentifier] block:^(YActionMessage *message) {
                if (message.isSuccess) {
                    [_commentListArray removeObjectAtIndex:commentIndex];
                    [self reloadData];
                } else {
                    [YUtils showTitle:message.desc];
                }
            }];
        }
    }];
    [alert show];
}
@end
