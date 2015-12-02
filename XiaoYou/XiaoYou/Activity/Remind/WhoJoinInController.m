//
//  WhoJoinInController.m
//  XiaoYou
//
//  Created by sheng on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "WhoJoinInController.h"
#import "ProfilePersonListTableView.h"

@interface WhoJoinInController ()

@property (nonatomic,strong) ProfilePersonListTableView *profileListView;

@end

@implementation WhoJoinInController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initVC];
    [self initView];
}

-(void)initVC {
    self.title = @"参与本次活动的人";
    [self showCustomNavigationBackButton];
}

-(void)initView {
    _profileListView = [[ProfilePersonListTableView alloc]
                        initWIthType:ProfilePersonListTypeNoticePerson];
    _profileListView.publishID = self.publishID;
    _profileListView.backgroundColor = KCOLORWHITE;
    [self.view addSubview:_profileListView];
    [_profileListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [_profileListView loadDataWithQueryCode:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
