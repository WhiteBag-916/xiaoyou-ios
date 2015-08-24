
//
//  ProfilePublishViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfilePublishViewController.h"
#import "ProfileFeedListView.h"
@interface ProfilePublishViewController()
@property (nonatomic, strong) ProfileFeedListView *tableView;
@end

@implementation ProfilePublishViewController

- (id)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = true;
        
    }
    return self;
}
- (void)viewDidLoad {
    [self initController];
    [self initTableView];
}
- (void)initController {
    self.view.backgroundColor = KCOLORWHITE;
    self.title = @"我发布的事儿";
    [self showCustomNavigationBackButton];
}

- (void)initTableView {
    _tableView = [[ProfileFeedListView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
}
- (void)viewDidAppear:(BOOL)animated {
    [_tableView loadData];
}
@end
