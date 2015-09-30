//
//  FunnyDetaiViewController.m
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityDetailListView.h"

@interface ActivityDetailViewController ()

@property (nonatomic,strong) ActivityDetailListView *detailListView;

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self showCustomNavigationBackButton];
    [self detailListView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(ActivityDetailListView *)detailListView {
    if (!_detailListView) {
        _detailListView = [[ActivityDetailListView alloc]init];
        [self.view addSubview:_detailListView];
        [_detailListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _detailListView;
}


@end
