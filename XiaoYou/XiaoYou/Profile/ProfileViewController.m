//
//  ProfileViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfileViewController.h"
#import "YUtils+Component.h"
#define KTOPHEIGHT SCALE_NUM(90)
#define KHEADIMG_SIZE SCALE_NUM(45)
#define KHEADIMGMARIN_LEFT SCALE_NUM(10)
#define KHEADIMGMARIN_DOWN SCALE_NUM(15)

#define KNAMEMARGIN_LEFT SCALE_NUM(12)
#define KSCHOOLNOMARGIN_TOP SCALE_NUM(10)

#define KMIDDELITEMHEIGHT SCALE_NUM(50)

@interface ProfileViewController ()
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *schoolNo;
@property (nonatomic, strong) UIView *contenView;
@property (nonatomic, strong) UILabel *respectNum;
@property (nonatomic, strong) UILabel *coolNum;


@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = true;
    self.hidesBottomBarWhenPushed = NO;
    [self initView];
}
- (void)initView {
    [self initScroll];
    [self initTop];
    [self initMiddle];
}
- (void)initScroll {
    UIScrollView *scroll = [[UIScrollView alloc] init];
    [self.view addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    _contenView = [[UIView alloc] init];
    [scroll addSubview:_contenView];
    [_contenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scroll);
    }];
}
- (void)initTop {
    _topView = [[UIView alloc] init];
    [_contenView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(KTOPHEIGHT);
    }];
    _topView.backgroundColor = KCOLORGREEN_455A64;
    
    UIView *infoView = [[UIView alloc] init];
    [self.view addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView).offset(KHEADIMGMARIN_LEFT);
        make.height.mas_equalTo(KHEADIMG_SIZE);
        make.right.equalTo(_topView);
        make.bottom.equalTo(_topView).offset(-KHEADIMGMARIN_DOWN);
    }];
    
    _headImg = [[UIImageView alloc] init];
    [infoView addSubview:_headImg];
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(infoView);
        make.width.mas_equalTo(KHEADIMG_SIZE);
    }];
    _headImg.layer.cornerRadius = KHEADIMG_SIZE/2;
    _headImg.clipsToBounds = true;
    _headImg.backgroundColor = [UIColor redColor];
    
    UIView *titleView = [[UIView alloc] init];
    [infoView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImg.mas_right).offset(KNAMEMARGIN_LEFT);
        make.centerY.equalTo(_headImg);
    }];
    
    _userName = [YUtils initLabel:CONTENT_FONT(15) color:KCOLORWHITE text:@"xxx" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [titleView addSubview:_userName];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(titleView);
        make.right.lessThanOrEqualTo(titleView);
    }];
    
    _schoolNo = [YUtils initLabel:CONTENT_FONT(9) color:KCOLORWHITE text:@"2010011111" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [titleView addSubview:_schoolNo];
    [_schoolNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userName.mas_bottom).offset(KSCHOOLNOMARGIN_TOP);
        make.bottom.left.equalTo(titleView);
        make.right.lessThanOrEqualTo(titleView);
    }];
    
    [self rightArray:0 inView:infoView];
    
}

- (void)initMiddle {
    _middleView = [[UIView alloc] init];
    [_contenView addSubview:_middleView];
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_topView);
        make.top.equalTo(_topView.mas_bottom);
    }];
    UIView *item1 = [self whiteItem:true];
    [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_middleView);
        make.height.mas_equalTo(KMIDDELITEMHEIGHT);
    }];
    
    UIView *item2 = [self whiteItem:false];
    [item2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item1.mas_bottom);
        make.left.right.height.equalTo(item1);
    }];
}

- (UIView *)whiteItem:(BOOL)isRespect {
    UIView *item = [[UIView alloc] init];
    [_middleView addSubview:item];
    UIImageView *icon = [[UIImageView alloc] init];
    [item addSubview:icon];
    [self rightArray:1 inView:item];
    if (isRespect) {
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(SCALE_NUM(17));
            make.centerX.equalTo(_headImg);
            make.centerY.equalTo(item);
        }];
        icon.backgroundColor = [UIColor redColor];
        _respectNum = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor blackColor] text:@"敬酒:100" frame:CGRectZero alignment:NSTextAlignmentLeft];
        [item addSubview:_respectNum];
        [_respectNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userName);
            make.top.bottom.right.equalTo(item);
        }];
    } else {
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(SCALE_NUM(17));
            make.centerX.equalTo(_headImg);
            make.centerY.equalTo(item);
        }];
        icon.backgroundColor = [UIColor blueColor];
        _coolNum = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor blackColor] text:@"觉得很酷:100" frame:CGRectZero alignment:NSTextAlignmentLeft];
        [item addSubview:_coolNum];
        [_coolNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userName);
            make.top.bottom.right.equalTo(item);
        }];

    }
    
    return item;
}
- (UIImageView *)rightArray:(int)type inView:(UIView *)view{
    UIImageView *right = [[UIImageView alloc] init];
    [view addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(view);
        make.right.equalTo(view).offset(-SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(8));
    }];
    switch (type) {
        case 0:
            right.backgroundColor = KCOLORWHITE;
            break;
        case 1:
            right.backgroundColor = KCOLORWHITE_696969;
            break;
        case 2:
            right.backgroundColor = KCOLORGREEN_009688;
            break;
        default:
            break;
    }
    right.contentMode = UIViewContentModeRight;
    return right;
}

- (void)openRespect {
    
}
- (void)openCool {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
