//
//  NotifyListViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "NotifyListViewController.h"
#import "YCommonActionSheet.h"

@implementation NotifyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showCustomNavigationBackButton];
    [self showCustomNavigationMoreButton];
    self.title = @"新提醒";
}

- (void)onNavigationRightButtonClicked {
//    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"清空所有提醒"
//                                                         type:YCommonActionSheetItemTypeCommon
//                                                        block:^(NSInteger checkNum) {
//                                                            
//                                                        }];
//    
//    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1] title:nil];
//    [sheet show];
    
    //test
    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"分享这社团名片至"
                                                         type:YCommonActionSheetItemTypeShare
                                                        block:^(NSInteger checkNum) {
                                                            
                                                        }];
    
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"消息不提醒"
                                                         type:YCommonActionSheetItemTypeSwitch
                                                         open:YES
                                                        block:^(NSInteger checkNum) {
                                                            
                                                        }];
    
    YActionSheetItem *item3 = [YActionSheetItem itemWithTitle:@"举报"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                            
                                                        }];
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item2, item3] title:nil];
    [sheet show];
}

@end
