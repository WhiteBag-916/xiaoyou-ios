
//
//  ProfilePublishViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfilePublishViewController.h"
#import "ProfileFeedListView.h"
#import "FeedPublishViewController.h"
@interface ProfilePublishViewController()
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) ProfileFeedListView *tableView;
@end

@implementation ProfilePublishViewController

- (id)initWithUserId:(NSString *)userId name:(NSString *)userName{
    self = [super init];
    if (self) {
        _userId = userId;
        if (userName.length == 0) {
            self.title = @"我发布的事儿";
        } else {
            self.title = [NSString stringWithFormat:@"%@发布的事", userName];
        }
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
    [self showCustomNavigationBackButton];
    if (_userId.length == 0) {
        [self showCustomNavigationPublishButton];
    }
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
    [_tableView loadData:_userId];
}
- (void)onNavigationRightButtonClicked {
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:[[FeedPublishViewController alloc] init]];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
    
}
@end
