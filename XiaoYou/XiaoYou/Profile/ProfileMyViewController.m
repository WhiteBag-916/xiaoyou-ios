//
//  ProfileMyViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfileMyViewController.h"
#import "UIImageView+WebCache.h"

#define KHEADHEIGHT SCALE_NUM(150)

#define KIMGSIZE SCALE_NUM(88)

@interface ProfileMyViewController()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *middelView;

@property (nonatomic, strong) UIImageView *faceImg;
@property (nonatomic, strong) UILabel *nameLabel;


@end

@implementation ProfileMyViewController
- (id)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = true;
    }
    return self;
}
- (void)viewDidLoad {
    self.navigationController.navigationBarHidden = true;
    self.view.backgroundColor = KCOLORGREEN_f2f2f2;
    [self initView];
}
- (void)initView {
    [self initScroll];
    [self initTop];
}
- (void)initScroll {
    UIScrollView *scroll = [[UIScrollView alloc] init];
    [self.view addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _containerView = [[UIView alloc] init];
    [scroll addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scroll);
        make.width.equalTo(scroll);
    }];
}
- (void)initTop {
    _headView = [[UIView alloc] init];
    [_containerView addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_containerView);
        make.height.mas_equalTo(KHEADHEIGHT);
    }];
    _headView.backgroundColor = KCOLORGREEN_455A64;
    
    _faceImg = [[UIImageView alloc] init];
    [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(KIMGSIZE);
        make.center.equalTo(_headView);
    }];
    [_faceImg sd_setImageWithURL:[NSURL URLWithString:@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg"]];
    
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = true;
}
@end
