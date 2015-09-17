//
//  AssociationsDetailTableView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AssociationsDetailTableView.h"
#import "AssociationsListTableViewCell.h"
#import "ContactsInfoDetailTableViewCell.h"
#import "FeedListTableViewCell.h"
#import "FeedDetailViewController.h"
#import "Feed.h"
#import "FeedInfo.h"
#import "FeedManager.h"
#import "GroupFeedList.h"
#import "GroupModel.h"

#define KPAGENUM 6

@interface AssociationsDetailTableView ()
<UITableViewDataSource
,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *feedListArray;
@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) GroupModel *groupModel;

@end

@implementation AssociationsDetailTableView

- (id)initWithGroupId:(NSString *)groupId
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _groupId = groupId;
        _feedListArray = [NSMutableArray array];
        
        [self registerClass:[AssociationsListTableViewCell class] forCellReuseIdentifier:kAssociationsListTableViewCell];
        [self registerClass:[ContactsInfoDetailTableViewCell class] forCellReuseIdentifier:kContactsInfoDetailTableViewCell];
        [self registerClass:[FeedListTableViewCell class] forCellReuseIdentifier:kOrganizationFeedListTableViewCell];
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

- (void)loadMoreData
{
    [self loadMoreFeedList];
}
- (void)sendRequest {
    [[FeedManager sharedInstance] groupDetailInfo:KPAGENUM groupId:_groupId block:^(YActionMessage *message) {
        if (message.isSuccess) {
            [self hiddenFooter:false];
            if ([[message.object groupFeeds] count] < KPAGENUM) {
                [self showNoticeNoMoreData];
            }
            
            _groupModel = [message.object groupModel];
            if (nil != _associationsDetailTableViewDelegate) {
                [_associationsDetailTableViewDelegate resetAddButtonType:_groupModel];
            }
            
            [self resetFeedArray:[message.object groupFeeds] needRemoveAll:YES];
            
        } else {
            [YUtils showTitleOn:self title:message.desc];
        }
        
        [self stopLoad];
    }];
}

- (void)loadMoreFeedList {
    NSString *lastID;
    if (![self isHeaderRefresh]) {
        lastID = [NSString stringWithFormat:@"%g", [[_feedListArray.lastObject feed] feedIdentifier]];
    }
    
    [[FeedManager sharedInstance] groupFeeds:lastID size:KPAGENUM groupId:_groupId block:^(YActionMessage *message) {
        if (message.isSuccess) {
            [self hiddenFooter:false];
            if ([message.object count] < KPAGENUM) {
                [self showNoticeNoMoreData];
            }
            
            [self resetFeedArray:message.object needRemoveAll:NO];
            
        } else {
            [YUtils showTitleOn:self title:message.desc];
        }
        
        [self stopLoad];
    }];
}

- (void)resetFeedArray:(NSArray *)array needRemoveAll:(BOOL)needRemoveAll {
    if (needRemoveAll) {
        [_feedListArray removeAllObjects];
    }
    [_feedListArray addObjectsFromArray:array];
    
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return AssociationsDetailTableViewSectionEnd;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (AssociationsDetailTableViewTitleSection == section) {
        return (nil != _groupModel)?1:0;
    } else if (AssociationsDetailTableViewLikeSection == section) {
        return (nil != _groupModel)?2:0;
    }
    return _feedListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (AssociationsDetailTableViewTitleSection == section) {
        AssociationsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAssociationsListTableViewCell];
        
        [cell resetData:_groupModel];
        
        return cell;
    } else if (AssociationsDetailTableViewLikeSection == section) {
        ContactsInfoDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kContactsInfoDetailTableViewCell];
        
        NSString * indexStr = [NSString stringWithFormat:@"%ld",(long)row];
        
        if (0 == row)
        {
            NSDictionary * dic = @{@"content":[NSString stringWithFormat:@"%g人向%@撰写的内容敬酒", _groupModel.praiseCount,_groupModel.groupName],@"index":indexStr};
            [cell setCellInfo:dic hiddenLine:YES];
            return cell;
        }
        else if (1 == indexPath.row)
        {
            NSDictionary * dic = @{@"content":[NSString stringWithFormat:@"%g人觉得%@很酷", _groupModel.coolCount,_groupModel.groupName],@"index":indexStr, @"isCool":@(_groupModel.isCool)};
            [cell setCellInfo:dic hiddenLine:NO];
            return cell;
        }
        
        return cell;
    } else if (AssociationsDetailTableViewFeedSection == section) {
        FeedListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kOrganizationFeedListTableViewCell];
        [cell setHintHidden:indexPath.row !=0];
        [cell setData:_feedListArray[indexPath.row]];
        
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (AssociationsDetailTableViewTitleSection == section) {
        //计算高度
        CGFloat height = [tableView fd_heightForCellWithIdentifier:kAssociationsListTableViewCell cacheByIndexPath:indexPath configuration:^(AssociationsListTableViewCell *cell) {
            [cell resetData:_groupModel];
        }];
        return height;
    } else if (AssociationsDetailTableViewLikeSection == section) {
        return SCALE_NUM(40);
    }
    //计算高度
    CGFloat height = [tableView fd_heightForCellWithIdentifier:kOrganizationFeedListTableViewCell cacheByIndexPath:indexPath configuration:^(FeedListTableViewCell *cell) {
        [cell setData:_feedListArray[indexPath.row]];
    }];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (AssociationsDetailTableViewLikeSection == section) {
        if (1 == row) {
            [YUtils showHUDWithTitle];
            [[FeedManager sharedInstance] addGroupPraise:_groupId block:^(YActionMessage *message) {
                if (message.isSuccess) {
                    _groupModel.isCool = !_groupModel.isCool;
                    if (_groupModel.isCool) {
                        ++_groupModel.coolCount;
                    } else {
                        --_groupModel.coolCount;
                    }
                    
                    [self reloadData];
                }
                [YUtils hiddenProgressHUD];
            }];
        }
    } else if (AssociationsDetailTableViewFeedSection == section) {
        FeedDetailViewController *feedDetailViewController = [[FeedDetailViewController alloc] initWithFeedId:[NSString stringWithFormat:@"%g", [[_feedListArray[indexPath.row] feed] feedIdentifier]]];
        [_parent.navigationController pushViewController:feedDetailViewController animated:YES];
    }
}
@end
