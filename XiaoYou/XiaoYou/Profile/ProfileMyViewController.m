//
//  ProfileMyViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfileMyViewController.h"
#import "UIImageView+WebCache.h"
#import "ProfileChangePwdViewController.h"
#import "ProfilePhoneChangeViewController.h"

#define KHEADHEIGHT SCALE_NUM(150)

#define KIMGSIZE SCALE_NUM(88)

@interface ProfileMyViewController()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *middelView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIImageView *faceImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *schoolNoLabel;
@property (nonatomic, strong) UILabel *schoolLabel;
@property (nonatomic, strong) UILabel *departmentLabel;
@property (nonatomic, strong) UILabel *gradeLabel;
@property (nonatomic, strong) UILabel *classLabel;


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
    self.view.backgroundColor = KCOLORWHITE;
    [self initView];
}
- (void)initView {
    [self initScroll];
    [self initTop];
    [self initMiddle];
    [self initBottom];
}
- (void)initScroll {
    UIScrollView *scroll = [[UIScrollView alloc] init];
    [self.view addSubview:scroll];
    scroll.showsVerticalScrollIndicator = false;
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(-20);
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
    [_containerView addSubview:_faceImg];
    [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(KIMGSIZE);
        make.center.equalTo(_headView);
    }];
    _faceImg.layer.cornerRadius = KIMGSIZE/2;
    _faceImg.clipsToBounds = true;
    [_faceImg sd_setImageWithURL:[NSURL URLWithString:@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg"]];
    
    UIImageView *back = [[UIImageView alloc] init];
    [_headView addSubview:back];
    back.image = [UIImage imageNamed:@"common_back"];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(10));
        make.width.mas_equalTo(SCALE_NUM(9));
        make.height.mas_equalTo(SCALE_NUM(11));
        make.centerY.equalTo(_headView);
    }];
    
    [_headView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)]];
}
- (void)initMiddle {
    _middelView = [[UIView alloc] init];
    [_containerView addSubview:_middelView];
    [_middelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_containerView);
        make.top.equalTo(_headView.mas_bottom);
    }];
    _nameLabel = [self labelWithColor:false size:15];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middelView).offset(SCALE_NUM(20));
    }];
    
    _schoolNoLabel = [self labelWithColor:false size:8];
    [_schoolNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(SCALE_NUM(12));
    }];
    
    _schoolLabel = [self labelWithColor:true size:14];
    [_schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_schoolNoLabel.mas_bottom).offset(SCALE_NUM(40));
    }];
    
    _departmentLabel = [self labelWithColor:true size:14];
    [_departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_schoolLabel.mas_bottom).offset(SCALE_NUM(12));
    }];
    
    _gradeLabel = [self labelWithColor:true size:14];
    [_gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_departmentLabel.mas_bottom).offset(SCALE_NUM(12));
    }];
    
    _classLabel = [self labelWithColor:true size:14];
    [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_gradeLabel.mas_bottom).offset(SCALE_NUM(12));
        make.bottom.equalTo(_middelView);
    }];
    
}

- (void)initBottom {
    _bottomView = [[UIView alloc] init];
    [_containerView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middelView.mas_bottom).offset(88);
        make.left.right.bottom.equalTo(_containerView);
    }];
    UIView *tmp = nil;
    for (int i = 0; i < 3; i++) {
        UILabel *label = [self labelWithType:i];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (tmp == nil) {
                make.top.equalTo(_bottomView);
            } else {
                make.top.equalTo(tmp.mas_bottom).offset(SCALE_NUM(2));
            }
        }];
        tmp = label;
    }
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tmp);
    }];
}

- (UILabel *)labelWithColor:(BOOL)isGreen size:(float)size{
    UILabel *label = [YUtils initLabel:CONTENT_FONT(size) color:(isGreen?KCOLORGREEN_009688:[UIColor blackColor]) text:@"文字文字文字" frame:CGRectZero alignment:NSTextAlignmentCenter];
    [_middelView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_middelView);
    }];
    return label;
}

- (UILabel *)labelWithType:(int)type {
    NSArray *names = @[@"修改绑定手机号", @"修改密码", @"退出"];
    UILabel *label = [YUtils initLabel:CONTENT_FONT(12) color:KCOLORGREEN_455A64 text:names[type] frame:CGRectZero alignment:NSTextAlignmentCenter];
    [_bottomView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_bottomView);
        make.height.mas_equalTo(SCALE_NUM(48));
    }];
    label.backgroundColor = KCOLORGREEN_f2f2f2;
    label.userInteractionEnabled = true;
    
    UIView *line = [[UIView alloc] init];
    [label addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(label);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = KCOLORGREEN_455A64;
    
    line = [[UIView alloc] init];
    [label addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(label);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = KCOLORGREEN_455A64;
    
    switch (type) {
        case 0:
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePhone)]];
            break;
        case 1:
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePwd)]];
            break;
        case 2:
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePwd)]];
            break;
        default:
            break;
    }
    
    return label;
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)changePhone {
    [self.navigationController pushViewController:[[ProfilePhoneChangeViewController alloc] init] animated:true];
}
- (void)changePwd {
    [self.navigationController pushViewController:[[ProfileChangePwdViewController alloc] init] animated:true];
}
- (void)logOut {
    
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = true;
}
@end
