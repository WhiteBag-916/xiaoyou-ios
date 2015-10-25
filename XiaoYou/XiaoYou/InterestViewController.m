//
//  InterestViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/10/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "InterestViewController.h"
#import "InterestTableView.h"
@interface InterestViewController ()
@property (strong, nonatomic) InterestTableView *tableView;
@end

@implementation InterestViewController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initController];
    [self initTable];
}

- (void)initController {
    [self showCustomNavigationBackButton];
    self.title = @"好看";
}
- (void)initTable {
    _tableView = [[InterestTableView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _tableView.parent = self;
}
@end
