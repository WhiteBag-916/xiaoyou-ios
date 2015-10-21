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
@property (nonatomic, assign) int type;
@property (nonatomic, strong) NSString *feedId;
@property (nonatomic, strong) ProfilePersonListTableView *tableView;
@end

@implementation ProfilePersonListController

- (id)initWithType:(int)type {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = true;
        _type = type;
    }
    return self;
}
- (id)initWithType:(int)type feedId:(NSString *)feedId {
    self =  [self initWithType:type];
    if (self) {
        _feedId = feedId;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showCustomNavigationBackButton];
    switch (_type) {
        case 0:
            self.title = @"这些朋友给你的内容敬酒";
            break;
        case 1:
            self.title = @"这些朋友觉得你很酷";
            break;
        case 2:
            self.title = @"敬酒的朋友们";
            break;
        case 3:
        {
            self.title = @"参加活动的小伙伴";
            break;
        }
        default:
            break;
    }
    [self initTableView];
}
- (void)initTableView {
    _tableView = [[ProfilePersonListTableView alloc] initWIthType:_type];
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
    [super viewDidAppear:animated];
    if (_type == PersonListFeedRespect) {
        [_tableView loadDataWithFeedId:_feedId];
    } else {
        [_tableView loadData];
    }
}
@end
