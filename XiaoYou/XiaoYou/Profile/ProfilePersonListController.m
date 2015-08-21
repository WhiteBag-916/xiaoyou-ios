//
//  ProfilePersonListController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfilePersonListController.h"
#import "ProfilePersonListTableView.h"
@interface ProfilePersonListController()
@property (nonatomic, assign) BOOL isRespect;
@property (nonatomic, strong) ProfilePersonListTableView *tableView;
@end

@implementation ProfilePersonListController

- (id)initWithType:(BOOL)isRespect {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = true;
        _isRespect = isRespect;
    }
    return self;
}
- (void)viewDidLoad {
    [self showCustomNavigationBackButton];
    if (_isRespect) {
        self.title = @"这些朋友给你的内容敬酒";
    } else {
        self.title = @"这些朋友觉得你很酷";
    }
    [self initTableView];
}
- (void)initTableView {
    _tableView = [[ProfilePersonListTableView alloc] initWIthType:_isRespect];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = false;
}
- (void)viewDidAppear:(BOOL)animated {
    [_tableView loadData:@[@"2"]];
}
@end
