//
//  MyTimetableViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MyTimetableViewController.h"
#import "MyTimetableHeadView.h"
#import "MyTimetableView.h"
#import "ChooseWeekView.h"
#import "CourseTimeListModel.h"
#import "CurriculumManager.h"

@interface MyTimetableViewController ()

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UILabel *weekLabel;
@property (nonatomic, strong) MyTimetableHeadView *myTimetableHeadView;
@property (nonatomic, strong) MyTimetableView *myTimetableView;

@property (nonatomic, strong) CourseTimeListModel *courseTimeListModel;//课时

@property (nonatomic, assign) NSInteger selectWeekNum;  //已选择周
@property (nonatomic, assign) NSInteger nowWeek;        //当前周

@end

@implementation MyTimetableViewController

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavigationTitle];
    
    self.myTimetableHeadView = [[MyTimetableHeadView alloc] init];
    [self.view addSubview:_myTimetableHeadView];
    [_myTimetableHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_titleView);
        make.top.equalTo(_titleView.mas_bottom);
        make.height.mas_equalTo(SCALE_NUM(40));
    }];
    
    self.myTimetableView = [[MyTimetableView alloc] init];
    [self.view addSubview:_myTimetableView];
    [_myTimetableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_myTimetableHeadView.mas_bottom);
    }];
    
    [self initData];
}

- (void)initNavigationTitle {
    _titleView = [UIView new];
    _titleView.backgroundColor = KCOLOR_455A64;
    [self.view addSubview:_titleView];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateHighlighted];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(13, 15, 13, 15)];
    [leftButton addTarget:self action:@selector(popVC)
         forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(_titleView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
    //下拉
    _buttonView = [UIView new];
    _buttonView.userInteractionEnabled = YES;
    [_buttonView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(showChooseWeek)]];
    [_titleView addSubview:_buttonView];
    [_buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_titleView);
        make.centerX.equalTo(_titleView);
        make.height.mas_equalTo(40);
    }];
    
    _weekLabel = [YUtils initLabel:CONTENT_FONT(16)
                             color:KCOLOR_W1
                              text:@"第6周"
                         alignment:NSTextAlignmentCenter];
    [_buttonView addSubview:_weekLabel];
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(_buttonView);
    }];
    
    UIImageView *putImageView = [[UIImageView alloc]
                                 initWithImage:[UIImage imageNamed:@"icon_arrow"]];
    [_buttonView addSubview:putImageView];
    [putImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_weekLabel);
        make.left.equalTo(_weekLabel.mas_right).offset(5);
        make.right.equalTo(_buttonView);
    }];
}

- (void)initData {
    //获取课时
    self.courseTimeListModel = [[CurriculumManager sharedInstance] getCourseTime];
    if (nil == self.courseTimeListModel) {
        //如果没请求下来，再次请求
        [YUtils showHUDWithTitle];
        [[CurriculumManager sharedInstance] courseTimeList:^(YActionMessage *message) {
            [YUtils hiddenProgressHUD];
            if (message.isSuccess) {
                //获取课时
                self.courseTimeListModel = [[CurriculumManager sharedInstance] getCourseTime];
                [self resetData];
            } else {
                [YUtils showTitle:message.desc];
            }
        }];
    } else {
        [self resetData];
    }
}

- (void)resetData {
    //获取课时
    [_myTimetableView refreshCourseTimeList:self.courseTimeListModel];
    
    //获取当前第几周
    //获取时间
    NSDate *selectWeekDate = [NSDate dateFromString:self.courseTimeListModel.firstTime
                                         withFormat:[NSDate dateFormatString]];
    //根据时间获取距离今天
    NSUInteger agoDay = [selectWeekDate daysAgo];
    self.nowWeek = 1+agoDay/7;
    [self chooseWeek:1+agoDay/7];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = true;
    self.fd_interactivePopDisabled = YES;
}

- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}

//选择第几周
- (void)showChooseWeek {
    if (nil != self.courseTimeListModel) {
        ChooseWeekView *chooseWeekView = [[ChooseWeekView alloc] initWithBlock:_selectWeekNum
                                          
                                                                       weekNum:self.courseTimeListModel.maxWeek
                                                                       nowWeek:_nowWeek
                                                                         block:^(NSInteger checkNum) {
                                                                             [self chooseWeek:checkNum];
                                                                         }];
        
        [chooseWeekView show];
    }
}

- (void)chooseWeek:(NSInteger)num {
    self.selectWeekNum = num;
    _weekLabel.text = [NSString stringWithFormat:@"第%ld周", (long)num];
    
    [self getDataByWeek];
    
    //获取当前周几
    NSUInteger weekday = [[NSDate date] weekday];
    if (1 == weekday) {
        //周日
        weekday = 6;
    } else {
        weekday = weekday-2;
    }
    [_myTimetableHeadView resetSelectDay:weekday showNowDay:_selectWeekNum==_nowWeek];
}

//根据第几周获取课程数据
- (void)getDataByWeek {
    NSArray *array = [NSArray arrayWithArray:[[CurriculumManager sharedInstance]
                                              getDataByWeek:_selectWeekNum]];
    
    [_myTimetableView refreshEventsData:array];
}

@end
