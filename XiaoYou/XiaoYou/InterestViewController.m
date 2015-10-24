//
//  InterestViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/10/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "InterestViewController.h"
#import "InterestTableView.h"
@interface InterestViewController ()

@end

@implementation InterestViewController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initController {
    [self showCustomNavigationBackButton];
    self.title = @"好看";
}

@end
