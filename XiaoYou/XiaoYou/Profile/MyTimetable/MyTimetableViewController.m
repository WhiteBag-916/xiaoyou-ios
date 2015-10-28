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

@interface MyTimetableViewController ()

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UILabel *weekLabel;
@property (nonatomic, strong) MyTimetableHeadView *myTimetableHeadView;
@property (nonatomic, strong) MyTimetableView *myTimetableView;

@property (nonatomic, assign) NSInteger selectWeekNum;  //已选择周

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
    
    _myTimetableHeadView = [[MyTimetableHeadView alloc] init];
    [self.view addSubview:_myTimetableHeadView];
    [_myTimetableHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_titleView);
        make.top.equalTo(_titleView.mas_bottom);
        make.height.mas_equalTo(SCALE_NUM(40));
    }];
    
    _myTimetableView = [[MyTimetableView alloc] init];
    [self.view addSubview:_myTimetableView];
    [_myTimetableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_myTimetableHeadView.mas_bottom);
    }];
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
    [leftButton addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(_titleView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
    //下拉
    _buttonView = [UIView new];
    _buttonView.userInteractionEnabled = YES;
    [_buttonView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showChooseWeek)]];
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
    
    UIImageView *putImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow"]];
    [_buttonView addSubview:putImageView];
    [putImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_weekLabel);
        make.left.equalTo(_weekLabel.mas_right).offset(5);
        make.right.equalTo(_buttonView);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_myTimetableHeadView resetSelectDay:4];
}

- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}

//选择第几周
- (void)showChooseWeek {
    ChooseWeekView *chooseWeekView = [[ChooseWeekView alloc] initWithBlock:_selectWeekNum block:^(NSInteger checkNum) {
        [self chooseWeek:checkNum];
    }];
    
    [chooseWeekView show];
}

- (void)chooseWeek:(NSInteger)num {
    _selectWeekNum = num;
    _weekLabel.text = [NSString stringWithFormat:@"第%ld周", (long)num];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
