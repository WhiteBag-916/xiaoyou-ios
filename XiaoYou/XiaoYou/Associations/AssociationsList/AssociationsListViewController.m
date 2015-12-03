//
//  AssociationsListViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/16.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AssociationsListViewController.h"
#import "AssociationsListTableView.h"
#import "AssociationsSearchViewController.h"
#import "ProfileTagViewController.h"

@interface AssociationsListViewController ()

@property (nonatomic, strong) AssociationsListTableView *associationsListTableView;
@property (nonatomic, strong) NSArray *filterArray;

@end

@implementation AssociationsListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showCustomNavigationBackButton];
    [self initRightBar];
    self.title = @"社团/学生组织";
    self.hidesBottomBarWhenPushed = NO;
    //tableview
    self.associationsListTableView = [[AssociationsListTableView alloc] init];
    _associationsListTableView.superVC = self;
    [self.view addSubview:_associationsListTableView];
    
    [_associationsListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [_associationsListTableView loadData];
}

- (void)initRightBar {
    //right barbutton view
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, KNavigationBarheight)];
    
    UIButton *filterButton = [[UIButton alloc] initWithFrame:
                              CGRectMake(0, 0, 25, KNavigationBarheight)];
    [filterButton setImage:[UIImage imageNamed:@"common_filter"]
                  forState:UIControlStateNormal];
    [filterButton setImage:[UIImage imageNamed:@"common_filter"]
                  forState:UIControlStateHighlighted];
    [filterButton addTarget:self
                  action:@selector(filterBtnAction)
        forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:filterButton];
    
    UIButton * searchBtn = [[UIButton alloc] initWithFrame:
                            CGRectMake(35, 0, 25, KNavigationBarheight)];
    [searchBtn setImage:[UIImage imageNamed:@"common_search"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"common_search"] forState:UIControlStateHighlighted];
    [searchBtn addTarget:self
                  action:@selector(searchAction)
        forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:searchBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}

//筛选按钮
- (void)filterBtnAction {
    ProfileTagViewController *profileTagViewController = [[ProfileTagViewController alloc]
                                                          initWithMyTags:_filterArray
                                                                    type:ProfileTagTypeAssociations];
    [profileTagViewController endSelected:^(NSString *filterStr) {
        [_associationsListTableView resetArrayByFilter:filterStr];
    }];
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:profileTagViewController];
    [self.view.window.rootViewController presentViewController:navigationController
                                                      animated:YES
                                                    completion:nil];
}

//搜索
- (void)searchAction {
    NSArray *array = [_associationsListTableView tableViewData];
//    if (array.count > 0) {
        AssociationsSearchViewController *associationsSearchViewController
    = [[AssociationsSearchViewController alloc] initWithArray:array];
        [self.navigationController pushViewController:associationsSearchViewController
                                             animated:YES
                                  needHiddenBottomBar:YES];
//    } else {
//        [YUtils showTitle:@"还未获取到社团哟"];
//    }
}

@end
