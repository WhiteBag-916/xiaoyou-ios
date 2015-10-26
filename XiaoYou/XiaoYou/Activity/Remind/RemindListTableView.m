//
//  RemindListTableView.m
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RemindListTableView.h"
#import "RemindHeadView.h"
#import "PassRemindCell.h"
//#import "RemindManager.h"
#import "ApplyRemindCell.h"
#import "WhoJoinInController.h"
#import "ProfilePersonListController.h"
#import "ProfileViewController.h"
#import "ActivityDetailViewController.h"
#import "NoticeManager.h"

#define REMINDVIEWCELL  @"remindCell"
#define REMINDHEADVIEW  @"remindHeadView"
#define HEADCELL_HEIGHT SCALE_NUM(33)
#define REMIND_CELL_HEIGHT  SCALE_NUM(180)

@interface RemindListTableView ()
<UITableViewDataSource,UITableViewDelegate>
@end
@implementation RemindListTableView

-(instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[PassRemindCell class] forCellReuseIdentifier:REMINDVIEWCELL];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView.height = HEADCELL_HEIGHT;
        [self registerClass:[PassRemindCell class] forCellReuseIdentifier:REMINDVIEWCELL];
    }
    return self;
}

-(NSMutableArray *)remindListArray
{
    if (!_remindListArray) {
        _remindListArray = [NSMutableArray array];
    }
    return _remindListArray;
}

#pragma mark - 继承者
- (BOOL)showHeaderRefresh
{
    return NO;
}

- (BOOL)showFooterRefresh
{
    return NO;
}

- (void)loadData {
    //[self beginLoadNewData];
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
    
    
    [[NoticeManager sharedInstance] getMyNoticeInfoWithLimiteStart:0 limiteEnd:10 block:^(YActionMessage *message) {
        if (message.isSuccess) {
            if ([self isHeaderRefresh]) {
                [_remindListArray removeAllObjects];
            }
            [self hiddenFooter:NO];
            [self.remindListArray addObjectsFromArray:message.object];
            [self reloadData];
        }
    }];
//    NSString *lastID;
//    if (![self isHeaderRefresh]) {
//        //lastID = [NSString stringWithFormat:@"%g", [[_feedListArray.lastObject feed] feedIdentifier]];
//    }
//  [[FeedManager sharedInstance] feedList:lastID size:KPAGENUM queryCode:_filter block:^(YActionMessage *message) {
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
//            [YUtils showTitle:message.desc];
//        }
//        if ([self isHeaderRefresh]) {
//            [self stopLoadNewData];
//        } else {
//            [self stopLoadMoreData];
//        }
//    }];
//    NSString *lastID;
    /*if (![self isHeaderRefresh]) {
        lastID = [NSString stringWithFormat:@""];
    }
    [[RemindManager sharedInstance] getMyFeed:lastID limitStart:2 limitEnd:10 block:^(YActionMessage *message) {
        if (message.isSuccess) {
            if ([self isHeaderRefresh]) {
                [_remindListArray removeAllObjects];
            }
            [self hiddenFooter:false];
            [_remindListArray addObjectsFromArray:message.object];
            if ([message.object count] < 6) {
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
    }];*/
}


#pragma mark 协议方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(190);
    if (indexPath.section == 1) {
        return SCALE_NUM(146);
    }
    if (indexPath.section == 0 || indexPath.section == 2) {
        return SCALE_NUM(190);
    }
    else
    {
        return SCALE_NUM(198);
    }
    return REMIND_CELL_HEIGHT;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    return _remindListArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 33;
}

//返回header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    RemindHeadView *headView = [RemindHeadView remindHeadViewWithTableView:tableView];
    return headView;
}

//不显示footer,设置高度只能设置为0.1,如果返回0则是默认高度44
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PassRemindCell *cell = [PassRemindCell passRemindCellWithTableView:tableView];
    cell.cellType = AUDIT_PASSED;
    
    if (!_remindListArray && _remindListArray.count != 0)
        [cell setData:self.remindListArray[indexPath.section]];
    return cell;
//    if (indexPath.section == 1) {
//        cell.cellType = AUDIT_NOT_PASSED;
//    }
//
//    if (indexPath.section < 3) {
//        PassRemindCell *cell = [PassRemindCell passRemindCellWithTableView:tableView];
//        cell.cellType = AUDIT_PASSED;
//        //[cell setData:self.myDataSource[indexPath.section]];
//        if (indexPath.section == 1) {
//            cell.cellType = AUDIT_NOT_PASSED;
//        }
//        else
//        {
//            cell.cellType = AUDIT_PASSED;
//        }
//        return cell;
//    }
//    else if (indexPath.section == 4)
//    {
//        ApplyRemindCell *cell = [ApplyRemindCell cellWithTableView:tableView];
//        cell.cellType = WAIT_SELECT;
//        return cell;
//    }
//    else
//    {
//        ApplyRemindCell *cell = [ApplyRemindCell cellWithTableView:tableView];
//        cell.cellType = IGNORED;
//        return cell;
//    }
//    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ActivityDetailViewController *detailVC = [[ActivityDetailViewController alloc]init];
    [self.viewController.navigationController pushViewController:detailVC animated:YES needHiddenBottomBar:YES];
    /*ProfilePersonListController *whoJoinIn = [[ProfilePersonListController alloc]init];
    [whoJoinIn initWithType:PersonListWhoJoinInThisActivity];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[PassRemindCell class]]) {
        PassRemindCell *remindCell = (PassRemindCell*)cell;
        if (remindCell.cellType == AUDIT_PASSED)
            [self.viewController.navigationController pushViewController:whoJoinIn animated:YES needHiddenBottomBar:YES];
    }*/
}

@end
