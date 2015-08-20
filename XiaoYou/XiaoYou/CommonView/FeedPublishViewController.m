//
//  FeedPublishViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedPublishViewController.h"

@interface FeedPublishViewController()

@end

@implementation FeedPublishViewController
- (id)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}
- (void)initView {
    self.title = @"说两句";
    [self showCustomNavigationCancelButton];
    [self showCustomNavigationSureButton];
}
- (void)onNavigationLeftButtonClicked {
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:false];
}
@end
