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

#define KNOTIFYCOUNTHEIGHT 25
#define KNOTIFYCOUNTMARGIN_LEFT SCALE_NUM(17)
#define KNOTIFYCOUNTMARGIN_DOWN SCALE_NUM(12)
#define KNOTIFYCOUNTMARGIN_RIGHT SCALE_NUM(10)
#define KSEARCHHEIGHT SCALE_NUM(43)
#define KBOTTOMHEIGHT SCALE_NUM(80)
#define KTABLEMARGIN  SCALE_NUM(40)


@interface TagListViewController ()

@property (nonatomic, strong) UIView *notifyView;
@property (nonatomic, strong) UILabel *notifyCount;
@property (nonatomic, strong) UILabel *searchLabel;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) TagListTableView *listView;
@end

@implementation TagListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KCOLORGREEN_455A64;
    [self initHeaderView];
    [self initSearchBtn];
    [self initBottomView];
    [self initTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshData)
                                                 name:kNotification_Profile_GetProfile
                                               object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated {
    [self refreshData];
    _notifyCount.text = [[YShareData defaultData][kShareData_UnreadAlterCount] stringValue];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:KNotification_Update_UnreadAlterCount object:nil queue:nil usingBlock:^(NSNotification *note) {
        _notifyCount.text = [[YShareData defaultData][kShareData_UnreadAlterCount] stringValue];
    }];
//    [self refreshData];
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
    line.backgroundColor = KCOLORWHITE_b8b7b7;
    
    
    _notifyCount = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor whiteColor] text:@"99" frame:CGRectZero alignment:NSTextAlignmentCenter];
    [_notifyView addSubview:_notifyCount];
    [_notifyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_notifyView).offset(-KNOTIFYCOUNTMARGIN_DOWN);
        make.width.height.mas_equalTo(KNOTIFYCOUNTHEIGHT);
        make.left.mas_equalTo(KNOTIFYCOUNTMARGIN_LEFT);
    }];
    _notifyCount.backgroundColor = KCOLORGREEN_009688;
    _notifyCount.layer.cornerRadius = 3;
    _notifyCount.clipsToBounds = true;
    
    UILabel *infoLabel = [YUtils initLabel:CONTENT_FONT(14) color:[UIColor whiteColor] text:@"人脉新提醒" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [_notifyView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_notifyCount.mas_right).offset(KNOTIFYCOUNTMARGIN_RIGHT);
        make.top.bottom.equalTo(_notifyCount);
    }];
    
    //增加点击跳转到新提醒
    [self addTap:_notifyView action:@selector(toNotifyView)];
}

- (void)initSearchBtn {
    _searchLabel = [YUtils initLabel:CONTENT_FONT(12) color:KCOLORWHITE_b8b7b7 text:@"在这儿可以找到所有人" frame:CGRectZero alignment:NSTextAlignmentCenter];
    [self.view addSubview:_searchLabel];
    [_searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_notifyView);
        make.top.equalTo(_notifyView.mas_bottom);
        make.height.mas_equalTo(KSEARCHHEIGHT);
    }];
    _searchLabel.backgroundColor = KCOLORGREEN_32424A;
    
    UIImageView *icon = [[UIImageView alloc] init];
    [self.view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_notifyCount);
        make.centerY.equalTo(_searchLabel);
        make.width.mas_equalTo(SCALE_NUM(19));
        make.height.mas_equalTo(SCALE_NUM(21));
        
    }];
    icon.image = [UIImage imageNamed:@"search"];
    
    UIView *line = [[UIView alloc] init];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_searchLabel);
        make.height.mas_equalTo(0.5);
    }];
    line.backgroundColor = KCOLORWHITE_b8b7b7;
    
    //增加点击跳转到找人
    [self addTap:_searchLabel action:@selector(toSearchPerson)];
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
    line.backgroundColor = KCOLORWHITE_b8b7b7;
    
    UIImageView *icon = [[UIImageView alloc] init];
    [_bottomView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(SCALE_NUM(20));
        make.left.equalTo(_notifyCount);
        make.top.mas_equalTo(SCALE_NUM(20));
    }];
    icon.image = [UIImage imageNamed:@"society"];
    
    UILabel *hint = [YUtils initLabel:CONTENT_FONT(14) color:KCOLORWHITE text:@"社团总汇（一键加入）" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [_bottomView addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView);
        make.left.equalTo(_notifyCount.mas_right).offset(KNOTIFYCOUNTMARGIN_RIGHT);
        make.top.centerY.equalTo(icon);
        
    }];

    
    //增加点击跳转到动态列表
    [self addTap:_bottomView action:@selector(toAssociationsList)];
}

- (void)initTableView {
    _listView = [[TagListTableView alloc] initWithType:TagMenuType];
    [self.view addSubview:_listView];
    [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchLabel.mas_bottom).offset(KTABLEMARGIN);
        make.left.right.equalTo(_notifyView);
        make.bottom.equalTo(_bottomView.mas_top).offset(-KTABLEMARGIN);
    }];
}
- (void)refreshData {
    [_listView loadData];
}
- (void)addTap:(UIView *)view action:(SEL)selector {
    //增加点击跳转
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//跳转社团
- (void)toAssociationsList {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Push_AssociationsList object:nil];
    [[SlideNavigationController sharedInstance] closeMenuWithCompletion:^{
    }];
}

//跳转找人
- (void)toSearchPerson {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Push_SearchPerson object:nil];
    [[SlideNavigationController sharedInstance] closeMenuWithCompletion:^{
    }];
}

//跳转到新提醒
- (void)toNotifyView {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Push_Notify object:nil];
    [[SlideNavigationController sharedInstance] closeMenuWithCompletion:^{
    }];
}

@end
