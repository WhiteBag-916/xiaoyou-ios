//
//  MyTimetableViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MyTimetableViewController.h"

@interface MyTimetableViewController ()

@property (nonatomic, strong) UIButton *titleButton;

@end

@implementation MyTimetableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showCustomNavigationBackButton];
    [self initNavigationTitle];
}

- (void)initNavigationTitle {
    _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _titleButton.frame = CGRectMake(0, 0, 100, 40);
    [_titleButton setTitle:@"第六周" forState:UIControlStateNormal];
    [_titleButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_titleButton addTarget:self action:@selector(showChooseWeek) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = _titleButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
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
