//
//  NotifyListView.m
//  XiaoYou
//
//  Created by sheng on 15/11/2.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "NotifyListView.h"
#import "RemindHeadView.h"
#import "PassRemindCell.h"
#import "ScheduleNotifyCell.h"
#import "ApplyRemindCell.h"
#import "ScheduleDetailViewController.h"
#import "UserSchedulingInfo.h"
#import "YObject+Ext.h"
#define KPAGENUM 10

@interface NotifyListView ()
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) NSInteger currentIndex;

@property (nonatomic,strong) NSArray *passList;

@property (nonatomic,strong) NSArray *applyList;

@property (nonatomic,strong) NSArray *scheduleList;
@end


@implementation NotifyListView

-(instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = KCOLOR_B1;
        
        _passList       = @[@((int)ACTIVITY_ENROLL_CHECK_PASS),   //审核通过
                            @((int)ACTIVITY_ENROLL_NO_CHECK),     //未通过
                            @((int)ACTIVITY_PUBLISH),             //活动发布(校院社)
                            @((int)ACTIVITY_NOTIFY)];             //活动快要开始提醒
        _applyList      = @[@((int)ACTIVITY_ENROLL)];             //用户报名提醒
        _scheduleList   = @[@((int)SCHEDULE_REMIND)];             //日程提醒
    }
    return self;
}

-(void)setNotifyListArray:(NSArray *)notifyListArray
{
    _notifyListArray = notifyListArray;
}

#pragma mark - 继承者
- (void)loadData {
    [self beginLoadNewData];
}

- (BOOL)showHeaderRefresh
{
    return NO;
}

- (BOOL)showFooterRefresh
{
    return NO;
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

- (void)sendRequest
{

}


#pragma mark 协议方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block CGFloat cellHeight = 0;
    
    NotifyInfoModel *model = self.notifyListArray[indexPath.section];
    
    [YObject isElement:@((int)(model.type)) InArray:self.passList sucessed:^{
        cellHeight = SCALE_NUM(190);
    } failed:nil];
    
    [YObject isElement:@((int)(model.type)) InArray:self.applyList sucessed:^{
        cellHeight = SCALE_NUM(120);;
    } failed:nil];
    
    [YObject isElement:@((int)(model.type)) InArray:self.scheduleList sucessed:^{
        cellHeight = SCALE_NUM(110);
    } failed:nil];
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
    return SCALE_NUM(33);
}

//返回header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    RemindHeadView *headView = [RemindHeadView remindHeadViewWithTableView:tableView];
    NotifyInfoModel *model = self.notifyListArray[section];
    [headView setNotifyData:model];
    return headView;
}

//不显示footer
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotifyInfoModel *model = self.notifyListArray[indexPath.section];
    
    __block YTableViewCell *cell = nil;
    
    [YObject isElement:@((int)(model.type)) InArray:self.passList sucessed:^{
        cell = [PassRemindCell passRemindCellWithTableView:tableView];
    } failed:nil];
    
    [YObject isElement:@((int)(model.type)) InArray:self.applyList sucessed:^{
        cell = [ApplyRemindCell cellWithTableView:tableView];
    } failed:nil];
    
    [YObject isElement:@((int)(model.type)) InArray:self.scheduleList sucessed:^{
        cell = [ScheduleNotifyCell cellWithTableView:tableView];
    } failed:nil];
    
    [cell performSelector:@selector(setData:) withObject:model];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotifyInfoModel *model = self.notifyListArray[indexPath.section];
    switch (model.type)
    {
        case ACTIVITY_ENROLL_CHECK_PASS: //审核通过
        {
            
            break;
        }
        case ACTIVITY_ENROLL_NO_CHECK:  //活动报名审核未通过
        {
            
            break;
        }
        case SCHEDULE_REMIND: //用户自建日程提醒
        {
            [YAnalysis trackEvent:@"提醒_有空_提醒" withPara:@{@"类型":@"用户自建日程提醒"}];
            UserSchedulingInfo *info = [[UserSchedulingInfo alloc]init];
            info.internalBaseClassIdentifier = [model.idStr doubleValue];
            info.type = @"user_scheduling";
            ScheduleDetailViewController *ScheduleVC = [[ScheduleDetailViewController alloc]initWithInfo:info];
            [self.viewController.navigationController pushViewController:ScheduleVC animated:YES
                                                     needHiddenBottomBar:YES];
            break;
        }
        case ACTIVITY_ENROLL: //用户报名活动提醒
        {
            
            break;
        }
        case ACTIVITY_PUBLISH:  //
        {
            
            break;
        }
        case ACTIVITY_NOTIFY:   //活动通知
        {
            
            break;
        }
        default:
        {
            break;
        }
    }
}




@end
