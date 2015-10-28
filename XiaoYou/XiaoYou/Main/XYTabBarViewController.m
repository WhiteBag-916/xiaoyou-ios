//
//  XYTabBarViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/4.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYTabBarViewController.h"
#import "SlideNavigationController.h"
#import "ProfileViewController.h"
#import "FeedListViewController.h"
#import "XYMessageAndContactsViewController.h"
#import "ProfileMyViewController.h"
#import "XYContactsInfoDetailViewController.h"
#import "YCommonEditViewController.h"
#import "ProfilePersonListController.h"
#import "AvailableViewController.h"

#define kTag_TabBar_Base 0
#define kTag_TabBar_Message kTag_TabBar_Base + 1
#define kTag_TabBar_FeedList kTag_TabBar_Base + 2
#define kTag_TabBar_Profile kTag_TabBar_Base + 3

@interface XYTabBarViewController ()
<SlideNavigationControllerDelegate,IChatManagerDelegate>

@property(nonatomic,strong)XYMessageAndContactsViewController *messageVC;
@property(nonatomic,strong)UINavigationController *messageViewCotroller;
@property (nonatomic, strong) UINavigationController *feedListViewCotroller;
@property (nonatomic, strong) UINavigationController *availableViewController;

@end

@implementation XYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initControllers];
    self.tabBar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)initControllers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openProfile:) name:KNotification_Open_Profile object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount:) name:KNotification_Message_unread object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openPraise:) name:KNotification_Open_PraiseDetail object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadAlterCount) name:KNotification_Update_UnreadAlterCount object:nil];
    
    _messageVC = [[XYMessageAndContactsViewController alloc] init];
    FeedListViewController *feedVC = [[FeedListViewController alloc] init];
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    
    _messageViewCotroller = [[UINavigationController alloc] initWithRootViewController:_messageVC];
    _availableViewController = [[UINavigationController alloc] initWithRootViewController:[[AvailableViewController alloc] init]];
    _feedListViewCotroller = [[UINavigationController alloc] initWithRootViewController:feedVC];
    UINavigationController *profileViewCotroller = [[UINavigationController alloc] initWithRootViewController:profileVC];
    
    //消息
    UITabBarItem *messageItem = [[UITabBarItem alloc] initWithTitle:@"消息"
                                                              image:[UIImage imageNamed:@"btn_message_n"]
                                                                tag:kTag_TabBar_Message];
    messageItem.selectedImage = [[UIImage imageNamed:@"btn_message_y"]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _messageViewCotroller.tabBarItem = messageItem;
    
    //有空
    UITabBarItem *availableItem = [[UITabBarItem alloc] initWithTitle:@"有空"
                                                              image:[UIImage imageNamed:@"btn_free_n"]
                                                                tag:kTag_TabBar_Message];
    availableItem.selectedImage = [[UIImage imageNamed:@"btn_free_y"]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _availableViewController.tabBarItem = availableItem;
    
    //Feed
    UITabBarItem *feedListItem = [[UITabBarItem alloc] initWithTitle:@"校友圈"
                                                               image:[UIImage imageNamed:@"btn_friends_n"]
                                                                 tag:kTag_TabBar_FeedList];
    feedListItem.selectedImage = [[UIImage imageNamed:@"btn_friends_y"]
                                  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _feedListViewCotroller.tabBarItem = feedListItem;
    
    
    //我
    UITabBarItem *profileItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                         image:[UIImage imageNamed:@"btn_mine_n"]
                                                           tag:kTag_TabBar_Profile];
    profileItem.selectedImage = [[UIImage imageNamed:@"btn_mine_y"]
                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    profileViewCotroller.tabBarItem = profileItem;
    
    self.tabBar.tintColor = KCOLOR_g1;
    self.viewControllers = @[_messageViewCotroller, _availableViewController, _feedListViewCotroller, profileViewCotroller];
}

//feed提醒未读数
- (void)setupUnreadAlterCount {
    int unreadCount = [[YShareData defaultData][kShareData_UnreadAlterCount] intValue];
    if (unreadCount > 99) {
        _feedListViewCotroller.tabBarItem.badgeValue = @"99+";
    } else if (unreadCount > 0) {
        _feedListViewCotroller.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i", unreadCount];
    } else{
        _feedListViewCotroller.tabBarItem.badgeValue = nil;
    }
}

// 统计未读消息数
-(void)setupUnreadMessageCount:(NSNotification *)notification
{
    int unreadCount = [[notification userInfo][@"unread"] intValue];
    if (unreadCount > 99)
    {
        _messageViewCotroller.tabBarItem.badgeValue = @"99+";
    }
    else if(unreadCount > 0)
    {
        _messageViewCotroller.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i", unreadCount];
    }
    else{
        _messageViewCotroller.tabBarItem.badgeValue = nil;
    }
    
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)openProfile:(NSNotification *)notification {
    [self dealProfileOpen:[notification userInfo][@"uid"]];
}
- (void)openPraise:(NSNotification *)notification {
    UINavigationController *controller = (UINavigationController *)self.selectedViewController;
    [controller pushViewController:[[ProfilePersonListController alloc] initWithType:PersonListFeedRespect feedId:[notification userInfo][@"feedId"]] animated:true];
}
- (void)dealProfileOpen:(NSString *)userId {
    UINavigationController *controller = (UINavigationController *)self.selectedViewController;
    if (userId.length == 0) {
        [controller pushViewController:[[ProfileMyViewController alloc] init] animated:true];
    } else {
        XYContactsInfoDetailViewController *xv = [[XYContactsInfoDetailViewController alloc] init];
        xv.uid = userId;
        [controller pushViewController:xv animated:true needHiddenBottomBar:YES];
    }
}
#pragma mark - SlideNavigationControllerDelegate
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


@end
