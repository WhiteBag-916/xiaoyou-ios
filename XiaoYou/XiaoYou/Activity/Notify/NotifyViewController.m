//
//  NotifyViewController.m
//  XiaoYou
//
//  Created by sheng on 15/11/2.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "NotifyViewController.h"
#import "NotifyListView.h"

@interface NotifyViewController ()

@property (nonatomic,strong) NotifyListView *notifyListView;

@end

@implementation NotifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提醒";
    self.view.backgroundColor = [UIColor whiteColor];
    [self notifyListView];
    [self showCustomNavigationBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NotifyListView *)notifyListView {
    if (!_notifyListView) {
        _notifyListView = [[NotifyListView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_notifyListView];
        [_notifyListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.leading.equalTo(self.view);
            make.trailing.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
    return _notifyListView;
}

@end
