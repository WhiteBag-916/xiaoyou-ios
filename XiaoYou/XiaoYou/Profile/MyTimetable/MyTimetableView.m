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

@interface MyTimetableView ()
<UICollectionViewDataSource
,UICollectionViewDelegate
,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *allDayCollectionView;
@property (nonatomic, strong) UICollectionView *eventCollectionView;

@property (nonatomic, strong) NSMutableArray *timeArray;

@end

@implementation MyTimetableView

- (instancetype)init {
    if (self = [super init]) {
        self.timeArray = [[NSMutableArray alloc] init];
//        self.timeArray = @[@"8:00", @"8:55", @"10:00", @"10:55", @"12:00", @"12:55", @"14:00", @"14:55", @"16:00", @"16:55", @"18:30", @"19:25", @"20:20", @"21:15"];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _allDayCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _allDayCollectionView.backgroundColor = KCOLORWHITE;
        [_allDayCollectionView registerClass:[MyTimetableDayCollectionViewCell class] forCellWithReuseIdentifier:kMyTimetableDayCollectionViewCell];
        _allDayCollectionView.delegate = self;
        _allDayCollectionView.dataSource = self;
        [self addSubview:_allDayCollectionView];
        [_allDayCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
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

#pragma mark - UICollectionViewDataSource和UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _timeArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
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
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCALE_NUM(40), SCALE_NUM(40));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
