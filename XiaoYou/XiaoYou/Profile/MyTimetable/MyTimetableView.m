//
//  MyTimetableView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MyTimetableView.h"
#import "MyTimetableDayCollectionViewCell.h"
#import "CurriculumManager.h"
#import "CourseTimeListModel.h"
#import "MyTimetableCurriculumCollectionViewCell.h"
#import "MGCTimedEventsViewLayout.h"
#import "CurriculumDetailView.h"

#define K_CURRICULUM_WH            SCALE_NUM(40)  //1节课课程宽高
#define K_EVENT_L                   SCALE_NUM(39)  //1节课课程宽高

@interface MyTimetableView ()
<UICollectionViewDataSource
,UICollectionViewDelegate
,UICollectionViewDelegateFlowLayout
,MGCTimedEventsViewLayoutDelegate>

@property (nonatomic, strong) UICollectionView *allDayCollectionView;
@property (nonatomic, strong) UICollectionView *eventCollectionView;
@property (nonatomic, strong) MGCTimedEventsViewLayout *timedEventsViewLayout;

@property (nonatomic, strong) NSMutableArray *timeArray;

@end

@implementation MyTimetableView

- (instancetype)init {
    if (self = [super init]) {
        self.timeArray = [[NSMutableArray alloc] init];
//        self.timeArray = @[@"8:00", @"8:55", @"10:00", @"10:55", @"12:00", @"12:55", @"14:00", @"14:55", @"16:00", @"16:55", @"18:30", @"19:25", @"20:20", @"21:15"];
        
        //课表时间
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(K_CURRICULUM_WH, K_CURRICULUM_WH);
        _allDayCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _allDayCollectionView.backgroundColor = KCOLORWHITE;
        [_allDayCollectionView registerClass:[MyTimetableDayCollectionViewCell class] forCellWithReuseIdentifier:kMyTimetableDayCollectionViewCell];
        _allDayCollectionView.delegate = self;
        _allDayCollectionView.dataSource = self;
        _allDayCollectionView.allowsSelection = NO;
        
        [self addSubview:_allDayCollectionView];
        [_allDayCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        //课表内容
        _timedEventsViewLayout = [MGCTimedEventsViewLayout new];
        _timedEventsViewLayout.delegate = self;
        _timedEventsViewLayout.dayColumnSize = CGSizeMake(K_CURRICULUM_WH, K_CURRICULUM_WH*14);
        
        _eventCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_timedEventsViewLayout];
        _eventCollectionView.backgroundColor = [UIColor clearColor];
        _eventCollectionView.dataSource = self;
        _eventCollectionView.delegate = self;
        _eventCollectionView.scrollsToTop = NO;
        _eventCollectionView.showsVerticalScrollIndicator = NO;
        _eventCollectionView.decelerationRate = UIScrollViewDecelerationRateFast;
        _eventCollectionView.allowsSelection = YES;
        _eventCollectionView.directionalLockEnabled = YES;
        _eventCollectionView.bounces = NO;
        
        [_eventCollectionView registerClass:[MyTimetableCurriculumCollectionViewCell class] forCellWithReuseIdentifier:kMyTimetableCurriculumCollectionViewCell];
        [self addSubview:_eventCollectionView];
        [_eventCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, K_CURRICULUM_WH, 0, 0));
        }];
        
        [self refreshCourseTimeList];
    }
    
    return self;
}

//刷新课程时间
- (void)refreshCourseTimeList {
    [[CurriculumManager sharedInstance] courseTimeList:^(YActionMessage *message) {
        if (message.isSuccess && message.object) {
            [_timeArray removeAllObjects];
            for(CourseTimeListModel *model in message.object) {
                [_timeArray addObject:model.startTime];
            }
            [_allDayCollectionView reloadData];
        }
    }];
}

//初始化界面
- (void)setupSubviews {
    
}

#pragma mark - UICollectionViewDataSource和UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView == _allDayCollectionView) {
        return _timeArray.count;
    } else if (collectionView == _eventCollectionView) {
        return 7;
    }
    return 0;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _allDayCollectionView) {
        return 8;
    } else if (collectionView == _eventCollectionView) {
        if (0 == section || 1 == section || 6 == section) {
            return 1;
        }
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _allDayCollectionView) {
        MyTimetableDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyTimetableDayCollectionViewCell forIndexPath:indexPath];
        
        NSInteger row = indexPath.row;
        NSInteger section = indexPath.section;
        
        NSString *numStr;
        NSString *timeStr;
        if (0 == row) {
            numStr = [NSString stringWithFormat:@"%ld", (long)section+1];
            timeStr = _timeArray[section];
        }
        
        [cell initData:numStr timeText:timeStr showRightLine:(row==7) showBottomLine:(section==_timeArray.count-1)];
        
        return cell;
    } else if (collectionView == _eventCollectionView) {
        MyTimetableCurriculumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyTimetableCurriculumCollectionViewCell forIndexPath:indexPath];
        
        return cell;
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CurriculumDetailView *curriculumDetailView = [[CurriculumDetailView alloc] init];
    [curriculumDetailView show];
}

#pragma mark - MGCTimedEventsViewLayoutDelegate
- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(MGCTimedEventsViewLayout*)layout yPosForEventAtIndexPath:(NSIndexPath*)indexPath {
    if (1 == indexPath.section) {
        return K_CURRICULUM_WH*8;
    } else if (6 == indexPath.section) {
        return K_CURRICULUM_WH*6;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(MGCTimedEventsViewLayout*)layout heightForEventAtIndexPath:(NSIndexPath*)indexPath {
    if (1 == indexPath.section) {
        return K_CURRICULUM_WH*3;
    } else if (6 == indexPath.section) {
        return K_CURRICULUM_WH*5;
    }
    return K_CURRICULUM_WH*2;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _allDayCollectionView.contentOffset = scrollView.contentOffset;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
