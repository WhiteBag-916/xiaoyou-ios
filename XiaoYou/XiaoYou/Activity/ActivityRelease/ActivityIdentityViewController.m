//
//  ActivityIdentityViewController.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityIdentityViewController.h"
#import "ActivityReleaseController.h"

@interface ActivityIdentityViewController ()

@end

@implementation ActivityIdentityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

-(void)setUpUI
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    backView.backgroundColor = [UIColor redColor];
    //错号
    UIButton * dissMissBtn = [[UIButton alloc] init];
    dissMissBtn.backgroundColor = [UIColor clearColor];
    [dissMissBtn setImage:[UIImage imageNamed:@"mine-cancel"] forState:UIControlStateNormal];
    [dissMissBtn addTarget:self action:@selector(clickBtnForCancel) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:dissMissBtn];
    [dissMissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.leading.mas_equalTo(SCALE_NUM(12));
        make.height.width.mas_equalTo(SCALE_NUM(30));
    }];
    
    //对号
    UIButton * finishBtn = [[UIButton alloc] init];
    finishBtn.backgroundColor = [UIColor clearColor];
    [finishBtn setImage:[UIImage imageNamed:@"mine-complete-grey"] forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(clickBtnForChoice) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:finishBtn];
    [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.trailing.mas_equalTo(SCALE_NUM(-12));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(24));
    }];
    //筛选
    UILabel * centerLabel = [[UILabel alloc] init];
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.font = CONTENT_FONT(15);
    [backView addSubview:centerLabel];
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(backView);
        make.height.mas_equalTo(SCALE_NUM(20));
        make.width.mas_equalTo(SCALE_NUM(60));
    }];
}

-(void)clickBtnForCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickBtnForChoice
{
    [self dismissViewControllerAnimated:YES completion:^{
        ActivityReleaseController * releaseController = [[ActivityReleaseController alloc] init];
        [_availableViewController.navigationController pushViewController:releaseController animated:YES needHiddenBottomBar:YES];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
