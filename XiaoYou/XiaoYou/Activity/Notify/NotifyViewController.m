//
//  NotifyViewController.m
//  XiaoYou
//
//  Created by sheng on 15/11/2.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "NotifyViewController.h"
#import "NotifyListTableView.h"

@interface NotifyViewController ()

@property (nonatomic,strong) NotifyListTableView *notifyListView;

@end

@implementation NotifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提醒";
    [self notifyListView];
    [self showCustomNavigationBackButton];
    [self showCustomNavigationBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NotifyListTableView *)notifyListView
{
    if (!_notifyListView) {
        _notifyListView = [[NotifyListTableView alloc]init];
        _notifyListView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:_notifyListView];
        [_notifyListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _notifyListView;
}

@end
