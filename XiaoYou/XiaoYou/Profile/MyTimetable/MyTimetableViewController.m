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
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) MyTimetableHeadView *myTimetableHeadView;
@property (nonatomic, strong) MyTimetableView *myTimetableView;
@property (nonatomic, strong) ChooseWeekView *chooseWeekView;

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
    
    _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_titleButton setImage:[UIImage imageNamed:@"icon_arrow"] forState:UIControlStateNormal];
    [_titleButton setTitle:@"第六周" forState:UIControlStateNormal];
    [_titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, SCALE_NUM(60), 0, 0)];
    [_titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, SCALE_NUM(60))];
    [_titleButton addTarget:self action:@selector(showChooseWeek) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:_titleButton];
    [_titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftButton.mas_right).offset(10);
        make.right.mas_equalTo(-leftButton.width-10);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(_titleView);
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
