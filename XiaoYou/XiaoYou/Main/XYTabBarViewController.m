//
//  XYTabBarViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/4.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYTabBarViewController.h"
#import "SlideNavigationController.h"

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
    // Do any additional setup after loading the view.
    
    [self initControllers];
}

- (void)initControllers
{
    UIStoryboard *messageStoryBoard = [UIStoryboard storyboardWithName:@"Message" bundle:[NSBundle mainBundle]];
    UIStoryboard *feedListStoryBoard = [UIStoryboard storyboardWithName:@"FeedList" bundle:[NSBundle mainBundle]];
    UIStoryboard *profileStoryBoard = [UIStoryboard storyboardWithName:@"Profile" bundle:[NSBundle mainBundle]];
    
    UINavigationController *messageViewCotroller = [messageStoryBoard instantiateInitialViewController];
    UINavigationController *feedListViewCotroller = [feedListStoryBoard instantiateInitialViewController];
    UINavigationController *profileViewCotroller = [profileStoryBoard instantiateInitialViewController];
    
    //消息
    UITabBarItem *messageItem = [[UITabBarItem alloc] initWithTitle:@"消息"
                                                              image:[UIImage imageNamed:@"tabbar_message"]
                                                                tag:kTag_TabBar_Message];
    messageItem.selectedImage = [[UIImage imageNamed:@"tabbar_message_selected"]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    messageViewCotroller.tabBarItem = messageItem;
    
    //Feed
    UITabBarItem *feedListItem = [[UITabBarItem alloc] initWithTitle:@"人脉"
                                                               image:[UIImage imageNamed:@"tabbar_business circle"]
                                                                 tag:kTag_TabBar_FeedList];
    feedListItem.selectedImage = [[UIImage imageNamed:@"tabbar_business circle_selected"]
                                  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    feedListViewCotroller.tabBarItem = feedListItem;
    
    
    //我
    UITabBarItem *profileItem = [[UITabBarItem alloc] initWithTitle:@"我"
                                                         image:[UIImage imageNamed:@"tabbar_mycenter"]
                                                           tag:kTag_TabBar_Profile];
    profileItem.selectedImage = [[UIImage imageNamed:@"tabbar_mycenter_selected"]
                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    profileViewCotroller.tabBarItem = profileItem;
    
    self.tabBar.tintColor = [UIColor redColor];
    self.viewControllers = @[messageViewCotroller, feedListViewCotroller, profileViewCotroller];
}

#pragma mark - SlideNavigationControllerDelegate
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
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
