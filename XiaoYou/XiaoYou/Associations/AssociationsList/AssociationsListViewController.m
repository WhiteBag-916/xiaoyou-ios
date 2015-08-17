//
//  AssociationsListViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/16.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AssociationsListViewController.h"
#import "AssociationsListTableView.h"

@interface AssociationsListViewController ()

@property (nonatomic, strong) AssociationsListTableView *associationsListTableView;

@end

@implementation AssociationsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showCustomNavigationBackButton];
    [self initRightBar];
    self.title = @"社团总汇";
    
    //tableview
    _associationsListTableView = [[AssociationsListTableView alloc] init];
    [self.view addSubview:_associationsListTableView];
    
    [_associationsListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated navigationBarHidden:NO tabBarHidden:YES];
}

- (void)initRightBar {
    //right barbutton view
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
    
    UIButton *filterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 25, 40)];
    [filterButton setImage:[UIImage imageNamed:@"common_filter"] forState:UIControlStateNormal];
    [filterButton setImage:[UIImage imageNamed:@"common_filter"] forState:UIControlStateHighlighted];
    [filterButton addTarget:self
                  action:@selector(filterBtnAction)
        forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:filterButton];
    
    UIButton * searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(35, 5, 25, 40)];
    [searchBtn setImage:[UIImage imageNamed:@"common_search"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"common_search"] forState:UIControlStateHighlighted];
    [searchBtn addTarget:self
                  action:@selector(searchAction)
        forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:searchBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}

//删选
- (void)filterBtnAction {
    
}

//搜索
- (void)searchAction {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
