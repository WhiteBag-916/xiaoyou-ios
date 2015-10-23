//
//  ActivityIdentityViewController.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityIdentityViewController.h"
#import "ActivityReleaseController.h"
#import "ActivityIdentityTableView.h"

@interface ActivityIdentityViewController ()

@property(nonatomic,strong) UIButton * personalButton;
@property(nonatomic,strong) UIButton * groupButton;

@property(nonatomic,strong) ActivityIdentityTableView * activityIdentityTableView;

@end

@implementation ActivityIdentityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

-(void)setUpUI
{
    [self showCustomNavigationBackButton];
    self.title = @"选择活动发布身份";
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    backView.backgroundColor = [UIColor hexChangeFloat:@"465A65"];
    //错号
    UIButton * dissMissBtn = [[UIButton alloc] init];
    dissMissBtn.backgroundColor = [UIColor clearColor];
    [dissMissBtn setImage:[UIImage imageNamed:@"complete-cancel"] forState:UIControlStateNormal];
    [dissMissBtn addTarget:self action:@selector(clickBtnForCancel) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:dissMissBtn];
    [dissMissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(SCALE_NUM(-4));
        make.leading.mas_equalTo(SCALE_NUM(12));
        make.height.width.mas_equalTo(SCALE_NUM(30));
    }];
    
    //对号
    UIButton * finishBtn = [[UIButton alloc] init];
    finishBtn.backgroundColor = [UIColor clearColor];
    [finishBtn setImage:[UIImage imageNamed:@"complete"] forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(clickBtnForChoice) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:finishBtn];
    [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dissMissBtn);
        make.trailing.mas_equalTo(SCALE_NUM(-12));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(24));
    }];
    //选择活动发布身份
    UILabel * centerLabel = [[UILabel alloc] init];
    centerLabel.text = @"选择活动发布身份";
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.textColor = [UIColor whiteColor];
    centerLabel.font = CONTENT_FONT(14);
    [backView addSubview:centerLabel];
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView);
        make.centerY.equalTo(dissMissBtn);
        make.height.mas_equalTo(SCALE_NUM(20));
        make.width.mas_equalTo(SCALE_NUM(150));
    }];
    
    [self.view addSubview:backView];
    
    //个人
    _personalButton = [[UIButton alloc] init];
    _personalButton.layer.borderColor = [UIColor hexChangeFloat:@"465a65"].CGColor;
    _personalButton.layer.borderWidth = 1;
    _personalButton.layer.cornerRadius = 2;
    _personalButton.clipsToBounds = YES;
    [_personalButton setTitle:@"个人" forState:UIControlStateNormal];
    [_personalButton  setTitleColor:KCOLORGREEN_B4 forState:UIControlStateNormal];
    _personalButton.tintColor = KCOLORGREEN_B4;
    _personalButton.titleLabel.font = CONTENT_FONT(15);
    [_personalButton addTarget:self action:@selector(clickPersonalButton) forControlEvents:UIControlEventTouchUpInside];

    //社团
    _groupButton = [[UIButton alloc] init];
    _groupButton.layer.borderColor = [UIColor hexChangeFloat:@"465a65"].CGColor;
    _groupButton.layer.cornerRadius = 2;
    _groupButton.clipsToBounds = YES;
    _groupButton.backgroundColor = KCOLORGREEN_g1;
    [_groupButton setTitle:@"社团" forState:UIControlStateNormal];
    [_groupButton  setTitleColor:KCOLORGREEN_W1 forState:UIControlStateNormal];
    _groupButton.titleLabel.font = CONTENT_FONT(15);
    [_groupButton addTarget:self action:@selector(clickGroupButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_personalButton];
    [self.view addSubview:_groupButton];
    [_personalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(50));
        make.top.equalTo(backView.mas_bottom).offset(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(30));
        make.width.mas_equalTo(SCALE_NUM(87));
    }];
    [_groupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(SCALE_NUM(-50));
        make.top.equalTo(_personalButton);
        make.height.mas_equalTo(SCALE_NUM(30));
        make.width.mas_equalTo(SCALE_NUM(87));
    }];
    
    //提示
    UILabel * remindLabel = [[UILabel alloc] init];
    remindLabel.font = CONTENT_FONT(12);
    remindLabel.textColor = KCOLORGREEN_B5;
    remindLabel.numberOfLines = 0;
    [remindLabel setText:@"提示：以社团身份发布活动需经过审核。若您的活动限制报名人数，请登录后台查看所有报名同学，并进行通过和拒绝操作。" lineSpacing:10];
    remindLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:remindLabel];
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_personalButton.mas_left).offset(SCALE_NUM(-10));
        make.right.equalTo(_groupButton.mas_right).offset(SCALE_NUM(10));
        make.top.equalTo(_personalButton.mas_bottom).offset(SCALE_NUM(20));
        make.height.mas_equalTo(SCALE_NUM(100));
    }];
    
    _activityIdentityTableView = [[ActivityIdentityTableView alloc] init];
    _activityIdentityTableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_activityIdentityTableView];
    [_activityIdentityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remindLabel.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
}

//错号
-(void)clickBtnForCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//对号
-(void)clickBtnForChoice
{
    [self dismissViewControllerAnimated:YES completion:^{
        ActivityReleaseController * releaseController = [[ActivityReleaseController alloc] init];
        [_availableViewController.navigationController pushViewController:releaseController animated:YES needHiddenBottomBar:YES];
    }];
    
}
//个人
-(void)clickPersonalButton
{
    _personalButton.backgroundColor = KCOLORGREEN_g1;
    [_personalButton setTitleColor:KCOLORGREEN_W1 forState:UIControlStateNormal];
    _groupButton.backgroundColor = KCOLORGREEN_W1;
    [_groupButton setTitleColor:KCOLORGREEN_B4 forState:UIControlStateNormal];
    
    _personalButton.layer.borderWidth = 0;
    _groupButton.layer.borderWidth = 1;
}
//社团
-(void)clickGroupButton
{
    _groupButton.backgroundColor = KCOLORGREEN_g1;
    [_groupButton setTitleColor:KCOLORGREEN_W1 forState:UIControlStateNormal];
    _personalButton.backgroundColor = KCOLORGREEN_W1;
    [_personalButton setTitleColor:KCOLORGREEN_B4 forState:UIControlStateNormal];
    
    _groupButton.layer.borderWidth = 0;
    _personalButton.layer.borderWidth = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
