//
//  RemindListTableView.m
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RemindListTableView.h"
#import "RemindHeadView.h"
#import "RemindCell.h"
#import "RemindManager.h"
#define REMINDVIEWCELL  @"remindCell"
#define REMINDHEADVIEW  @"remindHeadView"
#define HEADCELL_HEIGHT SCALE_NUM(33)
#define REMIND_CELL_HEIGHT  SCALE_NUM(180)

@interface RemindListTableView ()
<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)NSMutableArray *remindListArray;
@end
@implementation RemindListTableView

-(instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[RemindCell class] forCellReuseIdentifier:REMINDVIEWCELL];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView.height = HEADCELL_HEIGHT;
        [self registerClass:[RemindCell class] forCellReuseIdentifier:REMINDVIEWCELL];
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
    [self sendRequest];
}

- (void)sendRequest {
    //mod by xiongchen
    /*NSString *lastID;
    if (![self isHeaderRefresh]) {
        lastID = [NSString stringWithFormat:@"%g", [[_feedListArray.lastObject feed] feedIdentifier]];
    }
    [[FeedManager sharedInstance] feedList:lastID size:KPAGENUM queryCode:_filter block:^(YActionMessage *message) {
        if (message.isSuccess) {
            if ([self isHeaderRefresh]) {
                [_feedListArray removeAllObjects];
            }
            [self hiddenFooter:false];
            [_feedListArray addObjectsFromArray:message.object];
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
    }];*/
    NSString *lastID;
    if (![self isHeaderRefresh]) {
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
    }];
}



#pragma mark 协议方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
    return REMIND_CELL_HEIGHT;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
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
    RemindCell *cell = [tableView dequeueReusableCellWithIdentifier:REMINDVIEWCELL];
    if (!cell) {
        cell = [[RemindCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REMINDVIEWCELL];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
