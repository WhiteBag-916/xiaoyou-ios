//
//  FeedListViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/4.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedListViewController.h"
#import "SlideNavigationController.h"
#import "CommonSwitchView.h"
#import "TagListViewController.h"

@interface FeedListViewController ()

@property (strong, nonatomic) CommonSwitchView *commonSwitchView;
@property (strong, nonatomic) TagListViewController *tagListVC;

@end

@implementation FeedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
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

- (void)initView
{
    //侧拉
    if (nil == _tagListVC)
    {
        _tagListVC = [[TagListViewController alloc] init];
        [SlideNavigationController sharedInstance].leftMenu = _tagListVC;
    }
    
    //switch
    _commonSwitchView = [[CommonSwitchView alloc] initWithFrame:CGRectMake(0, 0, 127, 27) textArray:@[@"feed", @"contact"]];
    [_commonSwitchView changedType:^(CommonSwitchType type) {
        [self changeSwitchView:type];
    }];
    self.navigationItem.titleView = _commonSwitchView;
}

//改变switch
- (void)changeSwitchView:(CommonSwitchType)type;
{
    
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
