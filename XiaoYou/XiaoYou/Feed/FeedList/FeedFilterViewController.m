//
//  FeedFilterViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedFilterViewController.h"
#import "YFlatSwitchView.h"
#import "FeedListTableView.h"
#import "FeedDetailViewController.h"
#import "ProfilePersonListTableView.h"

#define KHEADHEIGHT SCALE_NUM(30)

@interface FeedFilterViewController()

@property (nonatomic, strong) FeedListTableView *feedListTableView;
@property (nonatomic, strong) ProfilePersonListTableView *profilePersonListTableView;
@property (nonatomic, strong) NSString *filter;
@end

@implementation FeedFilterViewController
- (id)initWithFilter:(NSString *)filter name:(NSString *)name {
    self = [super init];
    if (self) {
        _filter = filter;
        self.title = name;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initController];
    [self initView];
}
- (void)viewDidAppear:(BOOL)animated {
    [_feedListTableView loadData];
}
- (void)initController {
    [self showCustomNavigationBackButton];
    
}
- (void)initView {
    [self initSwith];
    [self initFeedList];
    [self initPersonList];
}
- (void)initSwith {
    YFlatSwitchView *switchView  = [[YFlatSwitchView alloc] initWithText:@[@"事", @"人"]];
    [self.view addSubview:switchView];
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(KHEADHEIGHT);
    }];
    [switchView changedState:^(int index) {
        _feedListTableView.hidden = (index != 0);
        _profilePersonListTableView.hidden = (index != 1);
    }];
}
- (void)initFeedList {
    _feedListTableView = [[FeedListTableView alloc] initWithFilter:_filter];
    [self.view addSubview:_feedListTableView];
    _feedListTableView.parent = self;
    
    [_feedListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.equalTo(self.view).offset(KHEADHEIGHT);
    }];
}
- (void)initPersonList {
    _profilePersonListTableView = [[ProfilePersonListTableView alloc] initWIthType:ProfilePersonListTypeFeedPerson];
    _profilePersonListTableView.backgroundColor = KCOLORWHITE;
    _profilePersonListTableView.hidden = YES;
    [self.view addSubview:_profilePersonListTableView];
    
    [_profilePersonListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_feedListTableView);
    }];
}
- (void)goToDetail:(NSString *)feedId {
    FeedDetailViewController *feedDetailViewController = [[FeedDetailViewController alloc] initWithFeedId:feedId];
    [self.navigationController pushViewController:feedDetailViewController animated:YES];
}
@end
