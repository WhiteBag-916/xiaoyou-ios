//
//  NotifyListViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "NotifyListViewController.h"

@implementation NotifyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showCustomNavigationBackButton];
    [self showCustomNavigationMoreButton];
    self.title = @"新提醒";
}

- (void)moreBarAction {
    
}

@end
