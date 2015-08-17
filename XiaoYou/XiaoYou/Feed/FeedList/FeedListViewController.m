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
#import "AssociationsListViewController.h"
#import "YNotificationDefine.h"
#import "BBBadgeBarButtonItem.h"
#import "SearchPersonViewController.h"
#import "FeedDetailViewController.h"

@interface FeedListViewController ()

@property (strong, nonatomic) CommonSwitchView          *commonSwitchView;      //切换
@property (strong, nonatomic) TagListViewController     *tagListVC;             //侧拉
@property (strong, nonatomic) FeedListTableView         *feedListTableView;     //feed列表
@property (strong, nonatomic) BBBadgeBarButtonItem      *menuButton;            //菜单按钮
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
    
    [self initNotification];
}

- (void)viewDidAppear:(BOOL)animated {
    [_feedListTableView loadData:@[@"",@""]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SlideNavigationController sharedInstance].enableSwipeGesture = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    _commonSwitchView = [[CommonSwitchView alloc] initWithFrame:CGRectMake(0, 0, 119, 24) textArray:@[@"feed", @"contact"]];
    [_commonSwitchView changedType:^(CommonSwitchType type) {
        [self changeSwitchView:type];
    }];
    self.navigationItem.titleView = _commonSwitchView;
    
    //tableview
    _feedListTableView = [[FeedListTableView alloc] init];
    [self.view addSubview:_feedListTableView];
    _feedListTableView.parent = self;
    
    [_feedListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    [btn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeMenu) forControlEvents:UIControlEventTouchUpInside];
    _menuButton = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:btn];
    _menuButton.badgeValue = @"0";
    _menuButton.badgeFont = CONTENT_FONT(10);
    _menuButton.badgeMinSize = 5;
    self.navigationItem.leftBarButtonItem = _menuButton;
}

- (void)initNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toAssociationsList) name:kNotification_Push_AssociationsList object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toSearchPerson) name:kNotification_Push_SearchPerson object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openShare:) name:kNotification_Push_FeedDetail object:nil];
}

- (void)changeMenu {
    [[SlideNavigationController sharedInstance] toggleLeftMenu];
}

//改变switch
- (void)changeSwitchView:(CommonSwitchType)type;
{
    
}

- (void)goToDetail:(NSString *)feedId {
    FeedDetailViewController *feedDetailViewController = [[FeedDetailViewController alloc] initWithFeedId:feedId];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:feedDetailViewController animated:YES];
}

- (void)toAssociationsList {
    AssociationsListViewController *associationsListViewController = [[AssociationsListViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:associationsListViewController animated:YES];
}

- (void)toSearchPerson {
    SearchPersonViewController *searchPersonViewController = [[SearchPersonViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchPersonViewController animated:YES];
}

- (void)openShare:(NSNotification *) notification{
    NSDictionary *dic = [notification object];
}


@end
