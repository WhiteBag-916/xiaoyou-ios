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
    
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    
    CGFloat width = size_screen.width*scale_screen;
    CGFloat height = size_screen.height*scale_screen;
    
    NSLog(@"width:%f",width);
    NSLog(@"height:%f",height);
    
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
