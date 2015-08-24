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

#define kTag_TabBar_Base 0
#define kTag_TabBar_Message kTag_TabBar_Base + 1
#define kTag_TabBar_FeedList kTag_TabBar_Base + 2
#define kTag_TabBar_Profile kTag_TabBar_Base + 3

@interface XYTabBarViewController ()
<SlideNavigationControllerDelegate>

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
    
    XYMessageAndContactsViewController *messageVC = [[XYMessageAndContactsViewController alloc] init];
    FeedListViewController *feedVC = [[FeedListViewController alloc] init];
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    
    UINavigationController *messageViewCotroller = [[UINavigationController alloc] initWithRootViewController:messageVC];
    UINavigationController *feedListViewCotroller = [[UINavigationController alloc] initWithRootViewController:feedVC];
    UINavigationController *profileViewCotroller = [[UINavigationController alloc] initWithRootViewController:profileVC];
    
    //消息
    UITabBarItem *messageItem = [[UITabBarItem alloc] initWithTitle:@"消息"
                                                              image:[UIImage imageNamed:@"toolbar-chat"]
                                                                tag:kTag_TabBar_Message];
    messageItem.selectedImage = [[UIImage imageNamed:@"toolbar-chat-chosen"]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    messageViewCotroller.tabBarItem = messageItem;
    
    //Feed
    UITabBarItem *feedListItem = [[UITabBarItem alloc] initWithTitle:@"人脉"
                                                               image:[UIImage imageNamed:@"toolbar-contact"]
                                                                 tag:kTag_TabBar_FeedList];
    feedListItem.selectedImage = [[UIImage imageNamed:@"toolbar-contact-chosen"]
                                  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    feedListViewCotroller.tabBarItem = feedListItem;
    
    
    //我
    UITabBarItem *profileItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                         image:[UIImage imageNamed:@"toolbar-mine"]
                                                           tag:kTag_TabBar_Profile];
    profileItem.selectedImage = [[UIImage imageNamed:@"toolbar-mine-chosen"]
                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    profileViewCotroller.tabBarItem = profileItem;
    
    self.tabBar.tintColor = KCOLORGREEN_009688;
    self.viewControllers = @[messageViewCotroller, feedListViewCotroller, profileViewCotroller];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)openProfile:(NSNotification *)notification {
    [self dealProfileOpen:[notification userInfo][@"uid"]];
}
- (void)dealProfileOpen:(NSString *)userId {
    UINavigationController *controller = (UINavigationController *)self.selectedViewController;
    if (userId.length == 0) {
        [controller pushViewController:[[ProfileMyViewController alloc] init] animated:true];
    } else {
        XYContactsInfoDetailViewController *xv = [[XYContactsInfoDetailViewController alloc] init];
        xv.uid = userId;
        [controller pushViewController:xv animated:true];
    }
}
#pragma mark - SlideNavigationControllerDelegate
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


@end
