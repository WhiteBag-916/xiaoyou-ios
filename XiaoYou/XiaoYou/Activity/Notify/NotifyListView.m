//
//  NotifyListView.m
//  XiaoYou
//
//  Created by sheng on 15/11/2.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "NotifyListView.h"
#import "RemindHeadView.h"

#define KPAGENUM 10

@interface NotifyListView ()
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *notifyListArray;
@property (nonatomic,assign) NSInteger currentIndex;
@end


@implementation NotifyListView

-(instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = KCOLOR_B1;
        self.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
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
    _currentIndex = self.notifyListArray.count;
    [self sendRequest];
}

- (void)sendRequest {
    /*[[NoticeManager sharedInstance] getMyNoticeInfoWithLimiteStart:_currentIndex limiteEnd:_currentIndex + KPAGENUM block:^(YActionMessage *message) {
        if (message.isSuccess) {
            if ([self isHeaderRefresh]) {
                [_notifyListArray removeAllObjects];
            }
            [self hiddenFooter:NO];
            [self.notifyListArray addObjectsFromArray:message.object];
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
    }];*/
}


#pragma mark 协议方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight;
    return cellHeight;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.notifyListArray.count;
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
    NoticeInfo *info = self.notifyListArray[section];
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
    NoticeInfo *info = self.notifyListArray[indexPath.section];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoticeInfo *info;
    if (self.notifyListArray.count > 0)
        info = self.notifyListArray[indexPath.section];
    if (info.activityOwner) {
    }
}




@end
