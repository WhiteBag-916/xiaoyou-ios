//
//  TagListViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/4.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "TagListViewController.h"
#import "YUtils+Component.h"
#import "TagListTableView.h"
#import "SlideNavigationController.h"
#import "YNotificationDefine.h"

#define KNOTIFYCOUNTHEIGHT 20
#define KNOTIFYCOUNTMARGIN_LEFT SCALE_NUM(15)
#define KSEARCHHEIGHT SCALE_NUM(30)
#define KBOTTOMHEIGHT SCALE_NUM(80)
@interface TagListViewController ()

@property (nonatomic, strong) UIView *notifyView;
@property (nonatomic, strong) UILabel *notifyCount;
@property (nonatomic, strong) UILabel *searchLabel;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation TagListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    [self initHeaderView];
    [self initSearchBtn];
    [self initBottomView];
    [self initTableView];
}

- (void)initHeaderView {
    _notifyView = [[UIView alloc] init];
    [self.view addSubview:_notifyView];
    [_notifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.7);
        make.height.mas_equalTo(64);
    }];
    
    UIView *line = [[UIView alloc] init];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_notifyView);
        make.height.mas_equalTo(0.5);
    }];
    line.backgroundColor = [UIColor whiteColor];
    
    
    _notifyCount = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor whiteColor] text:@"99" frame:CGRectZero alignment:NSTextAlignmentCenter];
    [_notifyView addSubview:_notifyCount];
    [_notifyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_notifyView);
        make.width.height.mas_equalTo(KNOTIFYCOUNTHEIGHT);
        make.left.mas_equalTo(KNOTIFYCOUNTMARGIN_LEFT);
    }];
    _notifyCount.backgroundColor = [UIColor greenColor];
    
    UILabel *infoLabel = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor whiteColor] text:@"人脉新提醒" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [_notifyView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_notifyCount.mas_right).offset(KNOTIFYCOUNTMARGIN_LEFT);
        make.top.bottom.equalTo(_notifyCount);
    }];
    
    
    
}

- (void)initSearchBtn {
    _searchLabel = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor whiteColor] text:@"找人" frame:CGRectZero alignment:NSTextAlignmentCenter];
    [self.view addSubview:_searchLabel];
    [_searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_notifyView);
        make.top.equalTo(_notifyView.mas_bottom);
        make.height.mas_equalTo(KSEARCHHEIGHT);
    }];
    _searchLabel.backgroundColor = [UIColor darkGrayColor];
    
    UIImageView *icon = [[UIImageView alloc] init];
    [_searchLabel addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KNOTIFYCOUNTMARGIN_LEFT);
        make.centerY.equalTo(_searchLabel);
        
    }];
}

- (void)initBottomView {
    _bottomView = [[UIView alloc] init];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_notifyView);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(KBOTTOMHEIGHT);
    }];
    
    UIView *line = [[UIView alloc] init];
    [_bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_bottomView);
        make.height.mas_equalTo(0.5);
    }];
    line.backgroundColor = [UIColor whiteColor];
    
    //增加点击跳转到动态列表
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toAssociationsList)];
    [_bottomView addGestureRecognizer:tap];
}

- (void)initTableView {
    TagListTableView *listView = [[TagListTableView alloc] init];
    [self.view addSubview:listView];
    [listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchLabel.mas_bottom);
        make.left.right.equalTo(_notifyView);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toAssociationsList {
    [[SlideNavigationController sharedInstance] closeMenuWithCompletion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Push_AssociationsList object:nil];
    }];
}

@end
