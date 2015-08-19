//
//  XYGroupApplyViewController.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYGroupApplyViewController.h"
#import "GroupApplyTableView.h"
#import "YCommonActionSheet.h"

@interface XYGroupApplyViewController ()

@property(nonatomic,strong)GroupApplyTableView * groupApplyTableView;
@end

@implementation XYGroupApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

-(void)setUpUI
{
    self.title = @"社团申请";
    [self showCustomNavigationBackButton];
    [self showCustomNavigationMoreButton];
    
    _groupApplyTableView = [[GroupApplyTableView alloc] init];
    _groupApplyTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_groupApplyTableView];
    
    [_groupApplyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
}

- (void)onNavigationRightButtonClicked
{
    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"清空社团申请者列表"
                                                         type:YCommonActionSheetItemTypeCenterCommon
                                                        block:^(NSInteger checkNum) {
                                                            NSLog(@"清空社团申请者列表");
                                                        }];
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"集体发信"
                                                         type:YCommonActionSheetItemTypeCenterCommon
                                                        block:^(NSInteger checkNum) {
                                                            NSLog(@"集体发信");
                                                        }];
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1,item2] title:nil];
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
