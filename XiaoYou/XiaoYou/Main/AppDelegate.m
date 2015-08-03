//
//  AppDelegate.m
//  XiaoYou
//
//  Created by 熊宸 on 15/7/9.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AppDelegate.h"
#import "ChooseSchoolViewController.h"
#import "ProvisionManager.h"
#import "AssistantManager.h"
#import "ContactManager.h"
#import "MessageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //注册log
    [YLog setLevel:YLogLevelAll];
    
    //注册组件
    [ProvisionManager sharedInstance];
    [AssistantManager sharedInstance];
    [MessageManager sharedInstance];
    [ContactManager sharedInstance];
    
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //初始化登陆控制器
    UIStoryboard * chooseSchool = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    UINavigationController * home = [chooseSchool instantiateInitialViewController];
    self.window.rootViewController = home;
    
    [self.window makeKeyAndVisible];
    
    //测试-----------------
    [self testHttp];
    //---------------------
    
    return YES;
}

- (void)testHttp
{
    [[ProvisionManager sharedInstance] goLogin:^(YActionMessage *message) {
        
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
