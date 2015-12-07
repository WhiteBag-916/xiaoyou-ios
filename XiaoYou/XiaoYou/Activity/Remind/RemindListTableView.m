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
#import "ApplyRemindCell.h"
#import "WhoJoinInController.h"
#import "ProfilePersonListController.h"
#import "ProfileViewController.h"
#import "ActivityDetailViewController.h"
#import "NoticeManager.h"
#import "NoticeInfo.h"
#import "YUtils.h"

#define REMINDVIEWCELL  @"remindCell"
#define REMINDHEADVIEW  @"remindHeadView"
#define HEADCELL_HEIGHT SCALE_NUM(33)
#define REMIND_CELL_HEIGHT  SCALE_NUM(180)
#define KPAGENUM        10
#define APPLYREUSEID    @"ApplyRemindCell"

@interface RemindListTableView ()
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) NSInteger      currentIndex;    //索引

@property (nonatomic,assign) NSDictionary   *cellTypeDict;   //字典类型索引
@end
@implementation RemindListTableView

-(instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        [self registerClass:[PassRemindCell class] forCellReuseIdentifier:REMINDVIEWCELL];
        [self registerClass:[ApplyRemindCell class] forCellReuseIdentifier:APPLYREUSEID];
        _currentIndex = 0;
        NSDictionary *tmpDict = @{@"check_pass":@(AUDIT_PASSED),@"no_pass":@(AUDIT_NOT_PASSED),@"no_check":
                                      @(NOT_NEED_CHECK),@"need_check":@(NEED_CHECK)};
        _cellTypeDict = [NSDictionary dictionaryWithDictionary:tmpDict];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView.height = HEADCELL_HEIGHT;
        self.backgroundColor = KCOLOR_B1;
        [self registerClass:[PassRemindCell class] forCellReuseIdentifier:REMINDVIEWCELL];
        [self registerClass:[ApplyRemindCell class] forCellReuseIdentifier:APPLYREUSEID];
        _currentIndex = 0;
        NSDictionary *tmpDict = @{@"check_pass":@(AUDIT_PASSED),@"no_pass":@(AUDIT_NOT_PASSED),@"no_check":
                              @(NOT_NEED_CHECK),@"need_check":@(NEED_CHECK)};
        _cellTypeDict = [NSDictionary dictionaryWithDictionary:tmpDict];
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
- (void)loadData {
    [self beginLoadNewData];
}

- (BOOL)showHeaderRefresh
{
    return YES;
}

- (BOOL)showFooterRefresh
{
    return YES;
}

- (void)loadNewData
{
    [self sendRequest];
}

- (void)loadMoreData
{
    [self sendRequest];
}

//返回无数据时候的图片
-(NSString *)noDataImageViewAttribute
{
    return @"havetime－picture－notice";
}

- (void)sendRequest {
    _currentIndex = [self isHeaderRefresh] ? 0 : self.remindListArray.count;
    [[NoticeManager sharedInstance] getMyNoticeInfoWithLimiteStart:_currentIndex
                                                         limiteEnd:_currentIndex + KPAGENUM
                                                             block:^(YActionMessage *message) {
        if (message.isSuccess) {
            if ([self isHeaderRefresh]) {
                [_remindListArray removeAllObjects];
            }
            [self hiddenFooter:NO];
            [self.remindListArray addObjectsFromArray:message.object];
            if ([message.object count] < KPAGENUM) {
                [self showNoticeNoMoreData];
            }
            [self reloadData];
            _currentIndex += KPAGENUM;
        } else {
            [YUtils showTitle:message.desc];
        }
        if ([self isHeaderRefresh]) {
            [self stopLoadNewData];
        } else
        {
            [self stopLoadMoreData];
        }
        if ([self.remindListArray count] == 0) {
            [self showNoDataImageView:YES];
        } else {
            [self showNoDataImageView:NO];
        }
    }];
}


#pragma mark 协议方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight;
    NoticeInfo *info = self.remindListArray[indexPath.section];
    
    //有人参加你的活动
    if (info.activityOwner) {
        cellHeight = [tableView fd_heightForCellWithIdentifier:APPLYREUSEID
                                              cacheByIndexPath:indexPath
                                                 configuration:^(ApplyRemindCell *cell) {
            [cell setData:info];
        }];
    } else  //参加别人的活动
    {
        NSDictionary *tmpDict = @{@"check_pass":@(AUDIT_PASSED),@"no_pass":@(AUDIT_NOT_PASSED),@"no_check":
                                      @(NOT_NEED_CHECK),@"need_check":@(NEED_CHECK)};
        CELL_TYPE type = [tmpDict[info.checkStatus] integerValue];
        if (type == AUDIT_NOT_PASSED) {
            cellHeight = SCALE_NUM(145);
        } else
        {
            cellHeight = SCALE_NUM(190);
        }
    }
    return cellHeight;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.remindListArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SCALE_NUM(33);
}

//返回header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    RemindHeadView *headView = [RemindHeadView remindHeadViewWithTableView:tableView];
    NoticeInfo *info = self.remindListArray[section];
    [headView setData:info];
    return headView;
}

//不显示footer
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NoticeInfo *info = self.remindListArray[indexPath.section];
    
    if (info.activityOwner) {
        ApplyRemindCell *appCell = [tableView dequeueReusableCellWithIdentifier:APPLYREUSEID];
        [appCell setData:info];
        cell = appCell;
    } else  //参加别人的活动
    {
        NSDictionary *tmpDict = @{@"check_pass":@(AUDIT_PASSED),@"no_pass":@(AUDIT_NOT_PASSED),@"no_check":
                                      @(NOT_NEED_CHECK),@"need_check":@(NEED_CHECK)};
        CELL_TYPE type = [tmpDict[info.checkStatus] integerValue];
        PassRemindCell *remindCell = [PassRemindCell passRemindCellWithTableView:tableView];
        remindCell.cellType = type;
        [remindCell setData:info];
        cell = remindCell;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoticeInfo *info;
    if (self.remindListArray.count > 0)
        info = self.remindListArray[indexPath.section];
    if (info.activityOwner) {
        NSString *publishID = [NSString stringWithFormat:@"%ld",(long)info.activityPublishedId];
        ActivityDetailViewController *detailVC = [[ActivityDetailViewController alloc]
                                                  initWithPublishID:publishID];
        [self.viewController.navigationController pushViewController:detailVC animated:YES
                                                 needHiddenBottomBar:YES];
    }
}

@end