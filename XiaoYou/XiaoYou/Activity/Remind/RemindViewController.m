//
//  RemindViewController.m
//  XiaoYou
//
//  Created by sheng on 15/9/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RemindViewController.h"
#import "RemindListTableView.h"

@interface RemindViewController ()
@property (nonatomic,retain) RemindListTableView *remindList;
@end

@implementation RemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"提醒"];
    [self showCustomNavigationBackButton];
    [self remindList];
}

-(RemindListTableView *)remindList {
    if (!_remindList) {
        _remindList = [[RemindListTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_remindList];
        [_remindList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.leading.equalTo(self.view);
            make.trailing.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
    [_remindList loadData];
    [_remindList sendRequest];
    return _remindList;
}
@end
