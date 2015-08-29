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
#import "ContactManager.h"
#import "ApplicantList.h"

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
    _friendApplyTableView.superVC = self;
    _friendApplyTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_friendApplyTableView];
    
    [_friendApplyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [_friendApplyTableView loadData];
    
}

- (void)onNavigationRightButtonClicked
{
    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"清空好友列表"
                                                         type:YCommonActionSheetItemTypeCenterCommon
                                                        block:^(NSInteger checkNum) {
                                                            [self removeAllData];
                                                        }];
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1] title:nil];
    [sheet show];
}

- (void)removeAllData {
    
    NSMutableArray * idArr = [NSMutableArray array];
    [[_friendApplyTableView getDataSource] enumerateObjectsUsingBlock:^(ApplicantList * obj, NSUInteger idx, BOOL *stop) {
        [idArr addObject:@(obj.applyId)];
        
    }];
    NSString * ids = [idArr componentsJoinedByString:@","];
    [[ContactManager sharedInstance] ignoreFriendApply:ids block:^(YActionMessage *message) {
        [_friendApplyTableView refreshTableView:[NSArray array]];;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
