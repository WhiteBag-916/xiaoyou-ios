//
//  CodeEnlargeView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/11/3.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CodeEnlargeView.h"
#import "UIImageView+Ext.h"

@implementation CodeEnlargeView

-(instancetype)initWithModel1:(ProfileInfo *) model1 andModel2:(LoginResp *)model2
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self setUpUIWithModel1:model1 andModel2:model2];
    }
    return self;
}

-(void)setUpUIWithModel1:(ProfileInfo *) model1 andModel2:(LoginResp *) model2
{
    self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.alpha = 0.5;
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.layer.cornerRadius = SCALE_NUM(4);
    self.contentView.clipsToBounds = YES;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCALE_NUM(228));
        make.height.mas_equalTo(SCALE_NUM(300));
        make.centerY.centerX.equalTo(self);
    }];
    
    //头像
    UIImageView * headImageView = [[UIImageView alloc] init];
    headImageView.backgroundColor = [UIColor clearColor];
    [headImageView setFaceImageWithUrl:model1.headPic];
    [self.contentView addSubview:headImageView];
    [headImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(SCALE_NUM(14));
        make.height.width.mas_equalTo(SCALE_NUM(44));
    }];
    
    //姓名
    UILabel * nameLabel = [[UILabel alloc] init];
    nameLabel.text = model1.userName;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = CONTENT_FONT(SCALE_NUM(12));
    nameLabel.textColor = KCOLOR_B4;
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImageView);
        make.left.equalTo(headImageView.mas_right).offset(SCALE_NUM(12));
        make.height.mas_equalTo(SCALE_NUM(12));
        make.trailing.mas_equalTo(SCALE_NUM(-14));
    }];
    
    //专业
    UILabel * facultyLabel = [[UILabel alloc] init];
    facultyLabel.backgroundColor = [UIColor clearColor];
    facultyLabel.font = CONTENT_FONT(SCALE_NUM(10));
    facultyLabel.textColor = KCOLOR_B5;
    facultyLabel.numberOfLines = 0;
    facultyLabel.text = model2.college;
    [self.contentView addSubview:facultyLabel];
    [facultyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(SCALE_NUM(8));
        make.left.equalTo(headImageView.mas_right).offset(SCALE_NUM(12));
        make.height.mas_equalTo(SCALE_NUM(30));
        make.trailing.mas_equalTo(SCALE_NUM(-14));
    }];
    
    //二维码背景
    UIView * codeBackView = [[UIView alloc] init];
    codeBackView.backgroundColor = KCOLOR_B2;
    [self.contentView addSubview:codeBackView];
    [codeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImageView.mas_bottom).offset(SCALE_NUM(10));
        make.left.equalTo(headImageView.mas_left);
        make.height.width.mas_equalTo(SCALE_NUM(200));
    }];
    //二维码
    UIImageView * codeImageView = [[UIImageView alloc] init];
    codeImageView.contentMode = UIViewContentModeScaleAspectFill;
    codeImageView.backgroundColor = [UIColor clearColor];
    [codeImageView setNormalImageWithUrl:model1.qrCodeUrl];
    [codeBackView addSubview:codeImageView];
    [codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(SCALE_NUM(4));
        make.right.bottom.mas_equalTo(SCALE_NUM(-4));
    }];
    
    //提示
    UILabel * remindLabel = [[UILabel alloc] init];
    remindLabel.backgroundColor = [UIColor clearColor];
    remindLabel.font = CONTENT_FONT(SCALE_NUM(10));
    remindLabel.textColor = KCOLOR_B5;
    remindLabel.numberOfLines = 0;
    remindLabel.textAlignment = NSTextAlignmentCenter;
    remindLabel.text = @"扫扫上面的二维码，我们就是朋友啦!";
    [self.contentView addSubview:remindLabel];
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeBackView.mas_bottom).offset(SCALE_NUM(10));
        make.left.equalTo(headImageView.mas_left);
        make.height.mas_equalTo(SCALE_NUM(11));
        make.trailing.mas_equalTo(SCALE_NUM(-14));
    }];
}

- (void)showBackground
{
    self.backgroundView.alpha = 0.7;
}

- (void)hide {
    [self hideAlertAnimation];
}

- (void)hideAlertAnimation {
    [self removeFromSuperview];
    self.contentView.hidden = YES;
    
}

@end
