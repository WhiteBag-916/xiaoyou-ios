//
//  XYFriendApplyViewController.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYFriendApplyViewController.h"
#import "FriendApplyTableView.h"
#import "YCommonActionSheet.h"

@interface XYFriendApplyViewController ()

@property(nonatomic,strong) FriendApplyTableView * friendApplyTableView;

@end

@implementation XYFriendApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
}

-(void)setUpUI
{
    self.title = @"好友申请";
    [self showCustomNavigationBackButton];
    [self showCustomNavigationMoreButton];
    
    _friendApplyTableView = [[FriendApplyTableView alloc] init];
    _friendApplyTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_friendApplyTableView];
    
    [_friendApplyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
}

- (void)onNavigationRightButtonClicked
{
    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"清空好友列表"
                                                         type:YCommonActionSheetItemTypeCenterCommon
                                                        block:^(NSInteger checkNum) {
                                                            NSLog(@"清空好友列表");
                                                        }];
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1] title:nil];
    [sheet show];
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
