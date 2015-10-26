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
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[AvailableCell class] forCellReuseIdentifier:REUSEID_AVAILABEL_CELL];
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
//            if ([self isHeaderRefresh]) {
//                [self.availableListArray removeAllObjects];
//            }
//            
//            NSLog(@"this is message = %@",message.object);
//            
//            [self.availableListArray addObjectsFromArray:message.object];
//            
//            [self hiddenFooter:NO];
//            if ([message.object count] < KPAGENUM) {
//                [self showNoticeNoMoreData];
//            }
//            [self reloadData];
//            _currentIndex += KPAGENUM;
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
    
//    [self stopLoadNewData];
//    NSString *lastID;
//    if (![self isHeaderRefresh]) {
//        lastID = [NSString stringWithFormat:@"%g", [[_feedListArray.lastObject feed] feedIdentifier]];
//    }
//      [[FeedManager sharedInstance] feedList:lastID size:KPAGENUM queryCode:_filter block:^(YActionMessage *message) {
    //        if (message.isSuccess) {
    //            if ([self isHeaderRefresh]) {
//                    [_feedListArray removeAllObjects];
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


}

#pragma mark 协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.availableListArray.count + 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (indexPath.row == 0)
        return SCALE_NUM(140);
    else if (indexPath.row == 1)
        return SCALE_NUM(85);
    else {
        height = [tableView fd_heightForCellWithIdentifier:REUSEID_AVAILABEL_CELL cacheByIndexPath:indexPath configuration:^(AvailableCell *cell) {
            [cell setData:_availableListArray[indexPath.row-2]];
        }];
        return height;
    }
    return 1100;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ScheduleCardCell *cell = [ScheduleCardCell cellWithTableView:tableView];
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
    //可以蹭的课
    else if (type == SCROUGECOURSE_CELL) {
        AvailableSimpleViewController *vc = [[AvailableSimpleViewController alloc] initWithType:AvailableSimpleTypeRubLesson];
        [self.viewController.navigationController pushViewController:vc animated:YES needHiddenBottomBar:YES];
    }
    //活动详情
    else if (type == ACTIVITY_DETAIL_CELL) {
        ActivityDetailViewController *activityDetailVC = [[ActivityDetailViewController alloc]init];
        activityDetailVC.index = indexPath.row - 2;
        [self.viewController.navigationController pushViewController:activityDetailVC animated:YES needHiddenBottomBar:YES];
    }
}


@end
