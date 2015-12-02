//
//  CheckCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CheckCollectionViewCell.h"
#import "ActivityReleaseDataManager.h"

NSString *const kCheckCollectionViewCell = @"CheckCollectionViewCellId";

@interface CheckCollectionViewCell ()

@property(nonatomic,strong)UILabel * needCheckLabel;
@property(nonatomic,strong)UILabel * notNeedCheckLabel;

@property(nonatomic,strong)ActivityReleaseDataManager * dataManager;

@end

@implementation CheckCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self changUI];
        
        _dataManager = [ActivityReleaseDataManager shareActivityReleaseDataManager];
        _dataManager.ActivityCheckStr = @"不需要报名审核";
    }
    return self;
}

- (void)changUI
{
    self.numImageView.image = [UIImage imageNamed:@"img_num6"];
    self.typeLabel.text = @"报名审核（限社团）";
    
    //需要报名审核
    _needCheckLabel = [[UILabel alloc] init];
    _needCheckLabel.userInteractionEnabled = YES;
    _needCheckLabel.layer.borderColor = KCOLOR_B2.CGColor;
    _needCheckLabel.layer.borderWidth = 1;
    _needCheckLabel.layer.cornerRadius = SCALE_NUM(4);
    _needCheckLabel.clipsToBounds = YES;
    _needCheckLabel.text = @"需要报名审核";
    _needCheckLabel.textColor = KCOLOR_B3;
    _needCheckLabel.textAlignment = NSTextAlignmentCenter;
    _needCheckLabel.backgroundColor = [UIColor clearColor];
    _needCheckLabel.font = CONTENT_FONT(12);
    [self.contentView addSubview:_needCheckLabel];
    //不需要报名审核
    _notNeedCheckLabel = [[UILabel alloc] init];
    _notNeedCheckLabel.userInteractionEnabled = YES;
    _notNeedCheckLabel.layer.borderColor = [UIColor clearColor].CGColor;
    _notNeedCheckLabel.layer.borderWidth = 1;
    _notNeedCheckLabel.layer.cornerRadius = SCALE_NUM(4);
    _notNeedCheckLabel.clipsToBounds = YES;
    _notNeedCheckLabel.text = @"不需要报名审核";
    _notNeedCheckLabel.textColor = KCOLOR_W1;
    _notNeedCheckLabel.textAlignment = NSTextAlignmentCenter;
    _notNeedCheckLabel.backgroundColor = KCOLOR_g1;
    _notNeedCheckLabel.font = CONTENT_FONT(12);
    [self.contentView addSubview:_notNeedCheckLabel];
    
    [_needCheckLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(85));
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(SCALE_NUM(28));
        make.width.mas_equalTo(SCALE_NUM(110));
    }];
    
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNeedCheck)];
    [_needCheckLabel addGestureRecognizer:tap1];
    
    [_notNeedCheckLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(120));
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(SCALE_NUM(28));
        make.width.mas_equalTo(SCALE_NUM(110));
    }];
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(tapNotNeedCheck)];
    [_notNeedCheckLabel addGestureRecognizer:tap2];
    
    //point
    UIView * pointView = [[UIView alloc] init];
    pointView.backgroundColor = KCOLOR_B5;
    pointView.clipsToBounds = YES;
    pointView.layer.cornerRadius = SCALE_NUM(4);
    [self.contentView addSubview:pointView];
    [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(10));
        make.top.equalTo(_notNeedCheckLabel.mas_bottom).offset(SCALE_NUM(18));
        make.width.height.mas_equalTo(SCALE_NUM(8));
    }];
    //关于报名审核
    UILabel * aboutLabel = [[UILabel alloc] init];
    aboutLabel.font = CONTENT_FONT(11);
    aboutLabel.text = @"关于报名审核";
    aboutLabel.textColor = KCOLOR_B5;
    aboutLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:aboutLabel];
    [aboutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pointView.mas_right).offset(SCALE_NUM(5));
        make.centerY.equalTo(pointView);
        make.height.mas_equalTo(SCALE_NUM(12));
        make.trailing.mas_equalTo(SCALE_NUM(-12));
    }];
    //内容
    UILabel * contentLabel = [[UILabel alloc] init];
    contentLabel.font = CONTENT_FONT(11);
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByClipping;
    [contentLabel setText:@"若活动发起人希望限制活动参加人数，请选择 [需要报名审核]，然后使用社团账号，登录活动发布后台，对活动报名的同学进行 [通过] 或 [拒绝] 操作。\n若选择 [不需要报名审核]，则视为该活动所有人都可以参与。\n" lineSpacing:3];
    contentLabel.textColor = KCOLOR_B5;
    [self.contentView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pointView);
        make.top.equalTo(aboutLabel.mas_bottom).offset(SCALE_NUM(2));
        make.bottom.mas_equalTo(SCALE_NUM(0));
        make.right.mas_equalTo(SCALE_NUM(-10));
    }];
}

-(void)tapNeedCheck
{
    _needCheckLabel.textColor = [UIColor whiteColor];
    _notNeedCheckLabel.textColor = KCOLOR_B3;
    
    _needCheckLabel.backgroundColor = KCOLOR_g1;
    _notNeedCheckLabel.backgroundColor = [UIColor clearColor];
    
    _needCheckLabel.layer.borderColor = [UIColor clearColor].CGColor;
    _notNeedCheckLabel.layer.borderColor = KCOLOR_B2.CGColor;
    
    _dataManager.ActivityCheckStr = @"需要报名审核";
    
    NSDictionary * dic = @{@"position":@6};
    [[NSNotificationCenter defaultCenter]
     postNotificationName:KNotification_Activity_Release_ScrollTo object:dic];
}

-(void)tapNotNeedCheck
{
    _notNeedCheckLabel.textColor = [UIColor whiteColor];
    _needCheckLabel.textColor = KCOLOR_B3;
    
    _notNeedCheckLabel.backgroundColor = KCOLOR_g1;
    _needCheckLabel.backgroundColor = [UIColor clearColor];
    
    _notNeedCheckLabel.layer.borderColor = [UIColor clearColor].CGColor;
    _needCheckLabel.layer.borderColor = KCOLOR_B2.CGColor;
    
    _dataManager.ActivityCheckStr = @"不需要报名审核";
    
    NSDictionary * dic = @{@"position":@6};
    [[NSNotificationCenter defaultCenter]
     postNotificationName:KNotification_Activity_Release_ScrollTo object:dic];
}


@end
