//
//  ScheduleViewController.m
//  XiaoYou
//
//  Created by sheng on 15/9/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ScheduleListTableView.h"
@interface ScheduleViewController ()

@property (nonatomic,retain) ScheduleListTableView *scheduleList;

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"日程"];
    [self showCustomNavigationBackButton];
    [self tableView];
}


-(UITableView *)tableView {
    if (!_scheduleList) {
        _scheduleList = [[ScheduleListTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_scheduleList];
        _scheduleList.tableHeaderView.backgroundColor = [UIColor redColor];
        [_scheduleList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _scheduleList;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
