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

#define kTag_TabBar_Base 0
#define kTag_TabBar_Message kTag_TabBar_Base + 1
#define kTag_TabBar_FeedList kTag_TabBar_Base + 2
#define kTag_TabBar_Profile kTag_TabBar_Base + 3

@interface XYTabBarViewController ()
<SlideNavigationControllerDelegate,IChatManagerDelegate>

@property(nonatomic,strong)XYMessageAndContactsViewController *messageVC;
@property(nonatomic,strong)UINavigationController *messageViewCotroller;
@property (nonatomic, strong) UINavigationController *feedListViewCotroller;

@end

@implementation XYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initControllers];
    
    self.tabBar.translucent = NO;
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
    _feedListViewCotroller = [[UINavigationController alloc] initWithRootViewController:feedVC];
    UINavigationController *profileViewCotroller = [[UINavigationController alloc] initWithRootViewController:profileVC];
    
    //消息
    UITabBarItem *messageItem = [[UITabBarItem alloc] initWithTitle:@"消息"
                                                              image:[UIImage imageNamed:@"toolbar-chat"]
                                                                tag:kTag_TabBar_Message];
    messageItem.selectedImage = [[UIImage imageNamed:@"toolbar-chat-chosen"]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _messageViewCotroller.tabBarItem = messageItem;
    
    //Feed
    UITabBarItem *feedListItem = [[UITabBarItem alloc] initWithTitle:@"人脉"
                                                               image:[UIImage imageNamed:@"toolbar-contact"]
                                                                 tag:kTag_TabBar_FeedList];
    feedListItem.selectedImage = [[UIImage imageNamed:@"toolbar-contact-chosen"]
                                  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _feedListViewCotroller.tabBarItem = feedListItem;
    
    
    //我
    UITabBarItem *profileItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                         image:[UIImage imageNamed:@"toolbar-mine"]
                                                           tag:kTag_TabBar_Profile];
    profileItem.selectedImage = [[UIImage imageNamed:@"toolbar-mine-chosen"]
                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    profileViewCotroller.tabBarItem = profileItem;
    
    self.tabBar.tintColor = KCOLORGREEN_009688;
    self.viewControllers = @[_messageViewCotroller, _feedListViewCotroller, profileViewCotroller];
}

//feed提醒未读数
- (void)setupUnreadAlterCount {
    int unreadCount = [[YShareData defaultData][kShareData_UnreadAlterCount] intValue];
    if (unreadCount > 0) {
        _feedListViewCotroller.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i", unreadCount];
    }else{
        _feedListViewCotroller.tabBarItem.badgeValue = nil;
    }
}

// 统计未读消息数
-(void)setupUnreadMessageCount:(NSNotification *)notification
{
    int unreadCount = [[notification userInfo][@"unread"] intValue];
    if (unreadCount > 0) {
        _messageViewCotroller.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i", unreadCount];
    }else{
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
