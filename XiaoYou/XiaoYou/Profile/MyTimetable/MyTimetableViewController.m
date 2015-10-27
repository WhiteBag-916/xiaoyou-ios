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

@interface MyTimetableViewController ()

@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) MyTimetableHeadView *myTimetableHeadView;
@property (nonatomic, strong) MyTimetableView *myTimetableView;

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

    [self showCustomNavigationBackButton];
    [self initNavigationTitle];
    
    _myTimetableHeadView = [[MyTimetableHeadView alloc] init];
    [self.view addSubview:_myTimetableHeadView];
    [_myTimetableHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(SCALE_NUM(40));
    }];
    
    _myTimetableView = [[MyTimetableView alloc] init];
    [self.view addSubview:_myTimetableHeadView];
    [_myTimetableHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_myTimetableHeadView.mas_bottom);
    }];
}

- (void)initNavigationTitle {
    _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _titleButton.frame = CGRectMake(0, 0, 100, 40);
    [_titleButton setImage:[UIImage imageNamed:@"icon_arrow"] forState:UIControlStateNormal];
    [_titleButton setTitle:@"第六周" forState:UIControlStateNormal];
    [_titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, SCALE_NUM(65), 0, 0)];
    [_titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, SCALE_NUM(15))];
    [_titleButton addTarget:self action:@selector(showChooseWeek) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = _titleButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [_myTimetableHeadView resetSelectDay:4];
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
