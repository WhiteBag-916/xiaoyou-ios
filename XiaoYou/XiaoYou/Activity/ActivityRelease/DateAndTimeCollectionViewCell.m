//
//  DateAndTimeCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "DateAndTimeCollectionViewCell.h"

NSString *const kDateAndTimeCollectionViewCell = @"DateAndTimeCollectionViewCellId";

@interface DateAndTimeCollectionViewCell ()

@property (nonatomic,strong)UILabel * applayTimeLabel;
@property (nonatomic,strong)UILabel * beginTimeLabel;
@property (nonatomic,strong)UILabel * endTimeLabel;

@end

@implementation DateAndTimeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self changUI];
    }
    return self;
}

-(void)changUI
{ 
    self.numImageView.image = [UIImage imageNamed:@"img_num3"];
    self.typeLabel.text = @"时间";
    
    //报名时间
    UILabel * applyLabel = [[UILabel alloc] init];
    applyLabel.backgroundColor = [UIColor clearColor];
    applyLabel.font = CONTENT_FONT(12);
    applyLabel.textColor = KCOLORGREEN_B5;
    applyLabel.text = @"报名时间(选填)";
    [self.backView addSubview:applyLabel];
    [applyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.equalTo(self.numImageView);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(100);
    }];
    
    _applayTimeLabel = [[UILabel alloc] init];
    _applayTimeLabel.userInteractionEnabled = YES;
    _applayTimeLabel.backgroundColor = [UIColor whiteColor];
    _applayTimeLabel.font = CONTENT_FONT(12);
    _applayTimeLabel.text = @"2015年10月17日 下午1:00";
    _applayTimeLabel.textColor = KCOLORGREEN_B4;
    [self.backView addSubview:_applayTimeLabel];
    [_applayTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(applyLabel.mas_bottom).offset(10);
        make.left.equalTo(self.backView).offset(10);
        make.right.equalTo(self.backView).offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer * applayTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(applayChoiceTime)];
    [_applayTimeLabel addGestureRecognizer:applayTapGesture];
    
    //活动时间
    UILabel * activityLabel = [[UILabel alloc] init];
    activityLabel.backgroundColor = [UIColor clearColor];
    activityLabel.font = CONTENT_FONT(12);
    activityLabel.textColor = KCOLORGREEN_B5;
    activityLabel.text = @"活动时间";
    [self.backView addSubview:activityLabel];
    [activityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_applayTimeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.numImageView);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(100);
    }];
    
    //开始活动时间
    _beginTimeLabel = [[UILabel alloc] init];
    _beginTimeLabel.userInteractionEnabled = YES;
    _beginTimeLabel.backgroundColor = [UIColor whiteColor];
    _beginTimeLabel.font = CONTENT_FONT(12);
    _beginTimeLabel.text = @"2015年10月17日 下午2:00";
    _beginTimeLabel.textColor = KCOLORGREEN_B4;
    [self.backView addSubview:_beginTimeLabel];
    [_beginTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(activityLabel.mas_bottom).offset(10);
        make.left.equalTo(self.backView).offset(10);
        make.right.equalTo(self.backView).offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer * beginTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginChoiceTime)];
    [_beginTimeLabel addGestureRecognizer:beginTapGesture];
    
    //至Label
    UILabel * toLabel =[[UILabel alloc] init];
    toLabel.backgroundColor = [UIColor clearColor];
    toLabel.textAlignment = NSTextAlignmentCenter;
    toLabel.font = CONTENT_FONT(12);
    toLabel.textColor = KCOLORGREEN_B5;
    toLabel.text = @"至";
    [self.backView addSubview:toLabel];
    [toLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_beginTimeLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.backView);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(12);
    }];
    
    //结束活动时间
    _endTimeLabel = [[UILabel alloc] init];
    _endTimeLabel.userInteractionEnabled = YES;
    _endTimeLabel.backgroundColor = [UIColor whiteColor];
    _endTimeLabel.font = CONTENT_FONT(12);
    _endTimeLabel.text = @"2015年10月17日 下午3:00";
    _endTimeLabel.textColor = KCOLORGREEN_B4;
    [self.backView addSubview:_endTimeLabel];
    [_endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toLabel.mas_bottom).offset(10);
        make.left.equalTo(self.backView).offset(10);
        make.right.equalTo(self.backView).offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer * endTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endChoiceTime)];
    [_endTimeLabel addGestureRecognizer:endTapGesture];
    
}

-(void)applayChoiceTime
{

}

-(void)beginChoiceTime
{

}

-(void)endChoiceTime
{
    
}

@end
