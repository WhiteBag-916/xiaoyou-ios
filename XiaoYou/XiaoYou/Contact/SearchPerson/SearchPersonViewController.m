//
//  SearchPersonViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SearchPersonViewController.h"

@interface SearchPersonViewController ()

@end

@implementation SearchPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showCustomNavigationBackButton];
    [self showCustomNavigationSearchButton];
    self.title = @"找人";
}

@end
