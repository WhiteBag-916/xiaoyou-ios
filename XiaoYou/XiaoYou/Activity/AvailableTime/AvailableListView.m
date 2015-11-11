//
//  AvailableListView.m
//  XiaoYou
//
//  Created by sheng on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AvailableListView.h"
#import "AvailableCell.h"
#import "ScheduleCardCell.h"
#import "StudyRoomCell.h"
#import "ScroungeCourseCell.h"
#import "AvailableSimpleViewController.h"
#import "WeekViewController.h"
#import "ActivityDetailViewController.h"
#import "ActivityManager.h"
#import "ActivityInfoModel.h"
#import "AvailableTimeModel.h"
#import "NotifyInfoModel.h"
#import "YBaseService.h"
#import "YDatabaseDao.h"
#import "NSObject+MJKeyValue.h"

#define KPAGENUM 10

#define REUSEID_AVAILABEL_CELL @"AvailableCell"
#define REUSEID_SCHEDULE_CELL @"ScheduleCardCell"
@interface AvailableListView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) NSInteger currentIndex;            //分页用

@property (nonatomic,strong) ScheduleCardCell *scheduleCardCell;//日程
@end

@implementation AvailableListView

-(instancetype)init
{
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[AvailableCell class] forCellReuseIdentifier:REUSEID_AVAILABEL_CELL];
        [self registerClass:[ScheduleCardCell class] forCellReuseIdentifier:REUSEID_SCHEDULE_CELL];
        self.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[AvailableCell class] forCellReuseIdentifier:REUSEID_AVAILABEL_CELL];
        [self registerClass:[ScheduleCardCell class] forCellReuseIdentifier:REUSEID_SCHEDULE_CELL];
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        self.currentIndex = 0;
    }
    return self;
}

-(NSMutableArray *)availableListArray
{
    if (!_availableListArray) {
        _availableListArray = [NSMutableArray array];
    }
    return _availableListArray;
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
    //_currentIndex = 0;
    [self sendRequest];
}

- (void)loadMoreData
{
    //_currentIndex = self.availableListArray.count-2;
    [self sendRequest];
}

- (void)sendRequest {
    
    if ([self isHeaderRefresh]) {
        _currentIndex = 0;
    } else {
        _currentIndex = self.availableListArray.count - 2;
    }
    
    [[ActivityManager sharedInstance] getCurrentUseMainAvailableListLimitStart:_currentIndex limitEnd:_currentIndex + KPAGENUM block:^(YActionMessage *message) {
        if (message.isSuccess) {
            if ([self isHeaderRefresh]) {
                [self.availableListArray removeAllObjects];
            }
            [self dealMessage:message];
            [self hiddenFooter:NO];
            NSUInteger requestCount = [[message.object valueForKey:@"activityList"] count];
            if (requestCount < KPAGENUM) {
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
    }];
}

#pragma handle message reviced
-(void)dealMessage:(YActionMessage*)message
{
    AvailableTimeModel *model = message.object;
    if (_currentIndex == 0) {
        //日程
        [self.availableListArray addObject:model.scheduling];
        //空闲教室
        [self.availableListArray addObject:@(model.availableBuilding)];
    }
    [self.availableListArray addObjectsFromArray:model.activityList];
}

#pragma mark 协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.availableListArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (indexPath.row == 0) {
//        height = [tableView fd_heightForCellWithIdentifier:REUSEID_SCHEDULE_CELL cacheByIndexPath:indexPath configuration:^(ScheduleCardCell *cell) {
//            [cell setData:self.availableListArray[indexPath.row]];
//        }];
        NSUInteger count = [self.availableListArray[indexPath.row] count];
        if (count == 0) {
            height = SCALE_NUM(100);
        }
        else if (count == 1) {
            height = SCALE_NUM(80);
        } else if (count == 2) {
            height = SCALE_NUM(112);
        } else
        {
            height = SCALE_NUM(140);
        }
        return height;
    }
    else if (indexPath.row == 1)
        return SCALE_NUM(85);
    else {
        height = [tableView fd_heightForCellWithIdentifier:REUSEID_AVAILABEL_CELL cacheByIndexPath:indexPath configuration:^(AvailableCell *cell) {
            [cell setData:self.availableListArray[indexPath.row]];
        }];
        return height;
    }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        _scheduleCardCell = [tableView dequeueReusableCellWithIdentifier:REUSEID_SCHEDULE_CELL];
        [_scheduleCardCell setData:self.availableListArray[indexPath.row]];
        NSUInteger count = [self searchMessageNotRead];
        if (count>0)
            [_scheduleCardCell setMessageNotReadIsVisible:YES Text:[NSString stringWithFormat:@"%lu条新消息 >",(unsigned long)count]];
        else
            [_scheduleCardCell setMessageNotReadIsVisible:NO Text:@""];
        return _scheduleCardCell;
    } else if (indexPath.row == 1) {
        StudyRoomCell *cell = [StudyRoomCell cellWithTableView:tableView];
        [cell setData:self.availableListArray[indexPath.row]];
        return cell;
    } else
    {
        AvailableCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEID_AVAILABEL_CELL];
        [cell setData:self.availableListArray[indexPath.row]];
        return cell;
    }
    return nil;
}

#pragma mark 查找未读信息
-(NSUInteger)searchMessageNotRead
{
    NSString *dataBasePath = [NSString stringWithFormat:@"%@//%@",[YDirectory documents],NSStringFromClass([NotifyInfoModel class])];
    YDatabaseDao *dataBaseDao = [[YDatabaseDao alloc]initWitDatabasePath:dataBasePath];
    NSArray *notifyArr = [dataBaseDao queryModel:NSStringFromClass([NotifyInfoModel class])];
#pragma mark 如果要保存历史消息,需要修改如下代码
//    NSArray *notifyModelArr = [NotifyInfoModel objectArrayWithKeyValuesArray:notifyArr];
//    int count = 0;
//    for (NotifyInfoModel *model in notifyModelArr) {
//        if ([model.isRead isEqualToString:@"NO"])
//            count++;
//    }
    return notifyArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[ScheduleCardCell class]]) {
        [self gotoDetailWithCellType:SCHEDULECARD_CELL indexPath:indexPath];
    }
    else if ([cell isKindOfClass:[StudyRoomCell class]]) {
        [self gotoDetailWithCellType:STUDYROOM_CELL indexPath:indexPath];
    }
    else if ([cell isKindOfClass:[ScroungeCourseCell class]]) {
        [self gotoDetailWithCellType:SCROUGECOURSE_CELL indexPath:indexPath];
    }
    else if ([cell isKindOfClass:[AvailableCell class]]) {
        [self gotoDetailWithCellType:ACTIVITY_DETAIL_CELL indexPath:indexPath];
    } else
    {
        YLogE(@"not exist this cell");
    }
}


-(void)gotoDetailWithCellType:(CELLTYPE)type indexPath:(NSIndexPath*)indexPath
{
    //日程
    if (type == SCHEDULECARD_CELL) {
        WeekViewController *vc = [[WeekViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:YES needHiddenBottomBar:YES];
    }
    //空闲教室
    else if (type == STUDYROOM_CELL) {
        AvailableSimpleViewController *vc = [[AvailableSimpleViewController alloc] initWithType:AvailableSimpleTypeStudyRoom];
        [self.viewController.navigationController pushViewController:vc animated:YES needHiddenBottomBar:YES];
    } 
    //活动详情
    else if (type == ACTIVITY_DETAIL_CELL) {
        ActivityInfoModel *model;
        if (self.availableListArray.count > 0)
            model = self.availableListArray[indexPath.row];
        NSString *publishID = [NSString stringWithFormat:@"%ld",(long)model.activityPublishedModel.activityPublishedModelIdentifier];
        ActivityDetailViewController *activityDetailVC = [[ActivityDetailViewController alloc]initWithPublishID:publishID];
        [self.viewController.navigationController pushViewController:activityDetailVC animated:YES needHiddenBottomBar:YES];
    }
}


@end
