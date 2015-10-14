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
#import "NotifyListViewController.h"
#import "ProfileTagViewController.h"
#import "ProfilePersonListTableView.h"
#import "FeedPublishViewController.h"
#import "ProvisionManager.h"
#import "FeedFilterViewController.h"
//测试用
#import "FastViewController.h"
#import "AppConfigData.h"

@interface FeedListViewController ()<SlideNavigationControllerDelegate>

@property (strong, nonatomic) CommonSwitchView          *commonSwitchView;      //切换
@property (strong, nonatomic) TagListViewController     *tagListVC;             //侧拉
@property (strong, nonatomic) FeedListTableView         *feedListTableView;     //feed列表
@property (strong, nonatomic) BBBadgeBarButtonItem      *menuButton;            //菜单按钮
@property (nonatomic, strong) ProfilePersonListTableView *profilePersonListTableView;  //人

@property (nonatomic, assign) NSInteger viewIndex;


@property (nonatomic,strong) UIView         *promptView;
@property (nonatomic,strong) UIImageView    *guideImageView;
@end

@implementation FeedListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self showCustomNavigationPublishButton];
    _needRefresh = true;
    
    if ([AppConfigData isUserFirstUseIt])
        [self addGuideView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
    [SlideNavigationController sharedInstance].enableSwipeGesture = YES;
    [SlideNavigationController sharedInstance].enableShadow = false;
    [SlideNavigationController sharedInstance].portraitSlideOffset = SCREEN_WIDTH * 0.3;
    [self initNotification];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_needRefresh) {
        _needRefresh = false;
        [self refreshData];
    }
    //避免会被取消
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkUnreadAlterCount];
    });
    
}
- (void)refreshData {
    [_feedListTableView loadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
    
    [super viewWillDisappear:animated];
    [SlideNavigationController sharedInstance].enableSwipeGesture = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//查看是否有新消息提醒
- (void)checkUnreadAlterCount {
    int unreadCount = [[YShareData defaultData][kShareData_UnreadAlterCount] intValue];
    
    if (unreadCount > 99) {
        _menuButton.badgeValue = @"99+";
    } else if (unreadCount > 0) {
        _menuButton.badgeValue = [NSString stringWithFormat:@"%i", unreadCount];
    } else{
        _menuButton.badgeValue = @"0";
    }
}

- (void)initView
{
    self.hidesBottomBarWhenPushed = NO;
    //侧拉
    if (nil == _tagListVC)
    {
        _tagListVC = [[TagListViewController alloc] init];
        [SlideNavigationController sharedInstance].leftMenu = _tagListVC;
    }
    
    //switch
    _commonSwitchView = [[CommonSwitchView alloc] initWithFrame:CGRectMake(0, 0, SCALE_NUM(119), SCALE_NUM(24)) textArray:@[@"事", @"人"]];
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
    
    //person
    _profilePersonListTableView = [[ProfilePersonListTableView alloc] initWIthType:ProfilePersonListTypeFeedPerson];
    _profilePersonListTableView.backgroundColor = KCOLORWHITE;
    _profilePersonListTableView.hidden = YES;
    [self.view addSubview:_profilePersonListTableView];
    
    [_profilePersonListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    //left nav
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toNotifyView) name:kNotification_Push_Notify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toAddTag) name:kNotification_Push_AddTag object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toFeedFilter:) name:kNotification_Push_FeedFilter object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkUnreadAlterCount) name:KNotification_Update_UnreadAlterCount object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:KNotification_Refresh_FeedList object:nil];
    
    //侧拉通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openTagListVC:) name:SlideNavigationControllerDidReveal object:nil];
}

- (void)changeMenu {
    [[SlideNavigationController sharedInstance] toggleLeftMenu];
}

- (void)openTagListVC:(NSNotification *)notification {
    if ([[notification userInfo][@"menu"] isEqualToString:@"left"]) {
        [_tagListVC refreshData];
    }
}

//改变switch
- (void)changeSwitchView:(CommonSwitchType)type;
{
    _profilePersonListTableView.hidden = (type == CommonSwitchTypeFir);
    if (type == CommonSwitchTypeFir) {
        [self showCustomNavigationPublishButton];
        self.viewIndex = 1;
    } else {
        //self.navigationItem.rightBarButtonItem = nil;
        [self showCustomNavigationFastButton];
        self.viewIndex = 2;
        [_profilePersonListTableView loadDataWithQueryCode:@""];
    }
}

- (void)goToDetail:(NSString *)feedId {
    FeedDetailViewController *feedDetailViewController = [[FeedDetailViewController alloc] initWithFeedId:feedId];
    [self.navigationController pushViewController:feedDetailViewController animated:YES];
}

- (void)toAssociationsList {
    AssociationsListViewController *associationsListViewController = [[AssociationsListViewController alloc] init];
    [self.navigationController pushViewController:associationsListViewController animated:YES needHiddenBottomBar:YES];
}

- (void)toSearchPerson {
    SearchPersonViewController *searchPersonViewController = [[SearchPersonViewController alloc] init];
    [self.navigationController pushViewController:searchPersonViewController animated:YES needHiddenBottomBar:YES];
}

- (void)toNotifyView {
    NotifyListViewController *notifyListViewController = [[NotifyListViewController alloc] init];
    [self.navigationController pushViewController:notifyListViewController animated:YES needHiddenBottomBar:YES];
}

- (void)toAddTag {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[ProfileTagViewController alloc] initWithMyTags:[[ProvisionManager sharedInstance] profileTags] type:ProfileTagTypePerson]];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}
- (void)toFeedFilter:(NSNotification *)notification {
    [self.navigationController pushViewController:[[FeedFilterViewController alloc] initWithFilter:[notification userInfo][@"filter"] name:[notification userInfo][@"name"]] animated:true needHiddenBottomBar:YES];
}
- (void)onNavigationRightButtonClicked {
    
    if (self.viewIndex == 1) {
        _needRefresh = true;
        UINavigationController *navigationController =
        [[UINavigationController alloc] initWithRootViewController:[[FeedPublishViewController alloc] init]];
        [self.navigationController presentViewController:navigationController animated:YES completion:nil];
    } else if (self.viewIndex == 2) {
        
        FastViewController *fastViewController = [[FastViewController alloc]init];
        //[self.navigationController presentViewController:fast animated:YES completion:nil];
        //UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:fastViewController];
        //[self.navigationController presentViewController:navigationController animated:YES completion:nil];
        [self.navigationController pushViewController:fastViewController animated:YES needHiddenBottomBar:YES];
    }
    
}



#pragma mark引导蒙城

/**
 *  nil
 */
- (void)addGuideView {
    
    _promptView = [[UIView alloc]init];
    _promptView.backgroundColor = [UIColor blackColor];
    _promptView.alpha = 0.6;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:_promptView];
    [_promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    NSString *imageName = @"friend_box_serch";
    UIImage *image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _guideImageView = [[UIImageView alloc] initWithImage:image];
    [window addSubview:_guideImageView];
    
    [_guideImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(40));
        make.leading.mas_equalTo(0);
    }];
    
    
    _guideImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissGuideView)];
    [_promptView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissGuideView)];
    [_guideImageView addGestureRecognizer:tap1];
}


-(void)dismissGuideView {
    [_promptView removeFromSuperview];
    [_guideImageView removeFromSuperview];
}

@end
