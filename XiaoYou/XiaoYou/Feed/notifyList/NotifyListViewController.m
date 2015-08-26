//
//  NotifyListViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "NotifyListViewController.h"
#import "YCommonActionSheet.h"
#import "NotifyListTableView.h"

@interface NotifyListViewController ()

@property (nonatomic, strong) NotifyListTableView *notifyListTableView;

@end

@implementation NotifyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showCustomNavigationBackButton];
    [self showCustomNavigationMoreButton];
    self.title = @"人脉新提醒";
    
    [self initView];
}

- (void)viewDidAppear:(BOOL)animated {
    [_notifyListTableView loadData];
}

- (void)initView {
    _notifyListTableView = [[NotifyListTableView alloc] init];
    _notifyListTableView.backgroundColor = KCOLORWHITE;
    _notifyListTableView.superVC = self;
    [self.view addSubview:_notifyListTableView];
    
    [_notifyListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)onNavigationRightButtonClicked {
    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"清空所有提醒"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                            
                                                        }];
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1] title:nil];
    [sheet show];
}

@end
