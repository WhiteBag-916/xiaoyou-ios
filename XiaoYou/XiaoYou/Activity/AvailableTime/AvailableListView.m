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

#define KPAGENUM 10

#define REUSEID_AVAILABEL_CELL @"AvailableCell"
#define REUSEID_SCHEDULE_CELL @"ScheduleCardCell"
@interface AvailableListView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) NSInteger currentIndex;

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
    _currentIndex = 0;
    [self sendRequest];
}

- (void)loadMoreData
{
    _currentIndex = self.availableListArray.count;
    [self sendRequest];
}

- (void)sendRequest {
    [[ActivityManager sharedInstance] getCurrentUseAvailableListLimitStart:_currentIndex limitEnd:_currentIndex+KPAGENUM block:^(YActionMessage *message) {
        if (message.isSuccess) {
            if ([self isHeaderRefresh]) {
                [self.availableListArray removeAllObjects];
            }
            [self.availableListArray addObjectsFromArray:message.object];
            [self hiddenFooter:NO];
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
    }];
}

#pragma mark 协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.availableListArray.count + 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (indexPath.row == 0) {
        height = [tableView fd_heightForCellWithIdentifier:REUSEID_SCHEDULE_CELL cacheByIndexPath:indexPath configuration:^(ScheduleCardCell *cell) {
            [cell setData:@"aaa"];
        }];
        
        return height;
    }
    else if (indexPath.row == 1)
        return SCALE_NUM(85);
    else {
        height = [tableView fd_heightForCellWithIdentifier:REUSEID_AVAILABEL_CELL cacheByIndexPath:indexPath configuration:^(AvailableCell *cell) {
            [cell setData:_availableListArray[indexPath.row-2]];
        }];
        return height;
    }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ScheduleCardCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEID_SCHEDULE_CELL];
        return cell;
    } else if (indexPath.row == 1) {
        StudyRoomCell *cell = [StudyRoomCell cellWithTableView:tableView];
        return cell;
    } else
    {
        AvailableCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEID_AVAILABEL_CELL];
        [cell setData:self.availableListArray[indexPath.row-2]];
        return cell;
    }
    return nil;
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
            model = self.availableListArray[indexPath.row-2];
        NSString *publishID = [NSString stringWithFormat:@"%ld",(long)model.activityPublishedModel.activityPublishedModelIdentifier];
        
        ActivityDetailViewController *activityDetailVC = [[ActivityDetailViewController alloc]initWithPublishID:publishID];
        
        [self.viewController.navigationController pushViewController:activityDetailVC animated:YES needHiddenBottomBar:YES];
    }
    //可以蹭的课
//    else if (type == SCROUGECOURSE_CELL) {
//        AvailableSimpleViewController *vc = [[AvailableSimpleViewController alloc] initWithType:AvailableSimpleTypeRubLesson];
//        [self.viewController.navigationController pushViewController:vc animated:YES needHiddenBottomBar:YES];
//    }
    
}


@end
