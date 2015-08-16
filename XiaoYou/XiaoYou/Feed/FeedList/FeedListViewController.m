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
#import "FeedListTableView.h"

@interface FeedListViewController ()

@property (strong, nonatomic) CommonSwitchView          *commonSwitchView;      //切换
@property (strong, nonatomic) TagListViewController     *tagListVC;             //侧拉
@property (strong, nonatomic) FeedListTableView         *feedListTableView;     //feed列表

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
    [SlideNavigationController sharedInstance].enableShadow = false;
    [SlideNavigationController sharedInstance].portraitSlideOffset = SCREEN_WIDTH * 0.3;

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
    
    //tableview
    _feedListTableView = [[FeedListTableView alloc] init];
    [self.view addSubview:_feedListTableView];
    
    [_feedListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    UIBarButtonItem *leftMenu = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(changeMenu)];
    self.navigationItem.leftBarButtonItem = leftMenu;
}

- (void)changeMenu {
    [[SlideNavigationController sharedInstance] toggleLeftMenu];
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
