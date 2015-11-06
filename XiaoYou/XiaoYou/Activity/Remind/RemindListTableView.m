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


@interface RemindListTableView ()
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) NSInteger      currentIndex;

@property (nonatomic,strong) UIImageView    *noDataImageView;//没有数据时的提示

@end
@implementation RemindListTableView

-(instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[PassRemindCell class] forCellReuseIdentifier:REMINDVIEWCELL];
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        _currentIndex = 0;
        //控件的创建初始化必须写在init方法中,不能写在initWithFrame方法中,不然在IOS7及以下会崩溃
        
    }
    return self;
}

-(UIImageView *)noDataImageView
{
    if (!_noDataImageView) {
        _noDataImageView = [[UIImageView alloc]init];
        [self addSubview:_noDataImageView];
        _noDataImageView.hidden = YES;
        _noDataImageView.image = [UIImage imageNamed:@"havetime－picture－notice"];
        [_noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCALE_NUM(203));
            make.height.mas_equalTo(SCALE_NUM(164));
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
    }
    return _noDataImageView;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView.height = HEADCELL_HEIGHT;
        self.backgroundColor = KCOLOR_B1;
        [self registerClass:[PassRemindCell class] forCellReuseIdentifier:REMINDVIEWCELL];
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        _currentIndex = 0;
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
     _currentIndex = 0;
    [self sendRequest];
}

- (void)loadMoreData
{
    _currentIndex = self.remindListArray.count;
    [self sendRequest];
}

- (void)sendRequest {
    [[NoticeManager sharedInstance] getMyNoticeInfoWithLimiteStart:_currentIndex limiteEnd:_currentIndex + KPAGENUM block:^(YActionMessage *message) {
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
            self.noDataImageView.hidden = NO;
            [self hiddenHeader:YES];
            [self hiddenFooter:YES];
        } else {
            self.noDataImageView.hidden = YES;
            [self hiddenHeader:NO];
            [self hiddenFooter:NO];
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
        cellHeight = SCALE_NUM(160);
    } else  //参加别人的活动
    {
        CELL_TYPE type = [self cellTypeByModelString:info.checkStatus];
        if (type == AUDIT_PASSED) {
            cellHeight = SCALE_NUM(190);
        } else if (type == AUDIT_NOT_PASSED) {
            cellHeight = SCALE_NUM(145);
        } else if (type == ALREADY_SUBMIT) {
            cellHeight = SCALE_NUM(190);
        } else if (type == SUCESSED_JOININ) {
            cellHeight = SCALE_NUM(190);
        } else if (type == NEED_CHECK) {
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
    return 33;
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
        ApplyRemindCell *appCell = [ApplyRemindCell cellWithTableView:tableView];
        [appCell setData:info];
        cell = appCell;
    } else  //参加别人的活动
    {
        CELL_TYPE type = [self cellTypeByModelString:info.checkStatus];
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
        ActivityDetailViewController *detailVC = [[ActivityDetailViewController alloc]initWithPublishID:publishID];
        [self.viewController.navigationController pushViewController:detailVC animated:YES needHiddenBottomBar:YES];
    }
}


-(CELL_TYPE)cellTypeByModelString:(NSString*)modelStr
{
    NSDictionary *dict = @{@"check_pass":@(AUDIT_PASSED),@"no_pass":@(AUDIT_NOT_PASSED),@"need_check":@(ALREADY_SUBMIT),@"no_check":@(SUCESSED_JOININ),@"need_check":@(NEED_CHECK)};
    return [dict[modelStr] integerValue];
}

@end