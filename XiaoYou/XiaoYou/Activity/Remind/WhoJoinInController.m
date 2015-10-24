//
//  WhoJoinInController.m
//  XiaoYou
//
//  Created by sheng on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "WhoJoinInController.h"

@interface WhoJoinInController ()

@end

@implementation WhoJoinInController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initVC];
}

-(void)initVC {
    [self showCustomNavigationBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
