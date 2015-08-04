//
//  FeedListViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/4.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedListViewController.h"
#import "SlideNavigationController.h"

@interface FeedListViewController ()

@end

@implementation FeedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"人脉";
    
    [self initTagList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated navigationBarHidden:NO tabBarHidden:NO];
    
    [SlideNavigationController sharedInstance].enableSwipeGesture = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SlideNavigationController sharedInstance].enableSwipeGesture = NO;
}

//初始化侧拉
- (void)initTagList
{
    UIStoryboard *tagListStoryboard = [UIStoryboard storyboardWithName:@"TagList" bundle:[NSBundle mainBundle]];
    
    UIViewController *tagListViewCotroller = [tagListStoryboard instantiateInitialViewController];
    [SlideNavigationController sharedInstance].leftMenu = tagListViewCotroller;
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
