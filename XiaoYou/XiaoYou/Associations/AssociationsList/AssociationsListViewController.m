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
    self.title = @"社团总汇";
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated navigationBarHidden:NO tabBarHidden:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
