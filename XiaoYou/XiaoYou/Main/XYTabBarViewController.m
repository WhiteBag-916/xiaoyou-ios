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
#import "EaseMob.h"

#define kTag_TabBar_Base 0
#define kTag_TabBar_Message kTag_TabBar_Base + 1
#define kTag_TabBar_FeedList kTag_TabBar_Base + 2
#define kTag_TabBar_Profile kTag_TabBar_Base + 3

@interface XYTabBarViewController ()
<SlideNavigationControllerDelegate,EMChatManagerDelegate>

@end

@implementation XYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
//    if (!isAutoLogin)
//    {
//        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:@"xiaoaliu" password:@"123123" completion:^(NSDictionary *loginInfo, EMError *error) {
//            if (!error && loginInfo) {
//                YLogD(@"登陆成功");
//                [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
//            }
//        } onQueue:nil];
//    }
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[NSString stringWithFormat:@"4_%@",[YShareData defaultData][kShareData_StudentNo]] password:[NSString stringWithFormat:@"4_%@",[YShareData defaultData][kShareData_StudentNo]] completion:^(NSDictionary *loginInfo, EMError *error) {
                    if (!error && loginInfo) {
                        YLogD(@"登陆成功");
                    }
                } onQueue:nil];
    [self initControllers];
    
    self.tabBar.translucent = NO;
}

- (void)initControllers
{
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

#pragma mark - SlideNavigationControllerDelegate
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

//自动登录
/*!
 @method
 @brief 用户将要进行自动登录操作的回调
 @discussion
 @param loginInfo 登录的用户信息
 @param error     错误信息
 @result
 */
- (void)willAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{

}

/*!
 @method
 @brief 用户自动登录完成后的回调
 @discussion
 @param loginInfo 登录的用户信息
 @param error     错误信息
 @result
 */
- (void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{

}


//重连
/*!
 @method
 @brief 将要发起自动重连操作时发送该回调
 @discussion
 @result
 */
- (void)willAutoReconnect
{

}

/*!
 @method
 @brief 自动重连操作完成后的回调（成功的话，error为nil，失败的话，查看error的错误信息）
 @discussion
 @result
 */
- (void)didAutoReconnectFinishedWithError:(NSError *)error
{

}


@end
