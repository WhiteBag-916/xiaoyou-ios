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
#import "YTableView.h"

@interface XYFriendApplyViewController ()

@property(nonatomic,strong) FriendApplyTableView * friendApplyTableView;
@property (nonatomic, strong) NSString *chatter;

@end

@implementation XYFriendApplyViewController


- (instancetype)initWithChatter:(NSString *)chatter {
    if (self = [super init]) {
        _chatter = chatter;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
}

-(void)setUpUI
{
    self.title = @"好友申请";
    [self showCustomNavigationBackButton];
    
    _friendApplyTableView = [[FriendApplyTableView alloc] init];
    _friendApplyTableView.superVC = self;
    _friendApplyTableView.chatter = _chatter;
    _friendApplyTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_friendApplyTableView];
    
    [_friendApplyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [_friendApplyTableView loadData];
    
}

#pragma mark - 导航左侧
- (void)onNavigationLeftButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
