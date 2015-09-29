//
//  FunnyMiddleView.m
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "FunnyMiddleView.h"
#import "FunnyTopView.h"
@interface FunnyMiddleView ()
@property (nonatomic,strong) UIImageView    *timeImageView; //报名截止时间
@property (nonatomic,strong) UILabel        *staticDeadLineDes;//截止时间
@property (nonatomic,strong) UILabel        *deadLineTimeLabel;
@property (nonatomic,strong) UILabel        *staticActivityTimeDes;//活动时间
@property (nonatomic,strong) UILabel        *activityTimeLabel;//活动时间
@property (nonatomic,strong) UIImageView    *locationImageView;
@property (nonatomic,strong) UILabel        *locationLabel;
@property (nonatomic,strong) UIImageView    *categotyImageView;
@property (nonatomic,strong) UILabel        *categoryLabel;
@end

@implementation FunnyMiddleView

-(instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

-(void)initView {
    _timeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"schedule_time"]];
    [self addSubview:_timeImageView];
    
    [_timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(50);
        make.top.mas_equalTo(10);
    }];
    
    _staticDeadLineDes = [[UILabel alloc]init];
    [self addSubview:_staticDeadLineDes];
    _staticDeadLineDes.text = @"报名截止时间";
    [_staticDeadLineDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(70));
        //make.left.equalTo(_timeImageView.mas_right).offset(10);
        make.centerY.equalTo(_timeImageView.mas_centerY);
    }];
    
    _deadLineTimeLabel = [[UILabel alloc]init];
    [self addSubview:_deadLineTimeLabel];
    _deadLineTimeLabel.text = @"15/09/28 18:00";
    [_deadLineTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_staticDeadLineDes.mas_right).offset(5);
        make.centerY.equalTo(_staticDeadLineDes.mas_centerY);
    }];
    
    _staticActivityTimeDes = [[UILabel alloc]init];
    [self addSubview:_staticActivityTimeDes];
    _staticActivityTimeDes.text = @"活动时间";
    [_staticActivityTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_deadLineTimeLabel.mas_bottom).offset(10);
        make.left.equalTo(_staticDeadLineDes);
    }];
    
    _activityTimeLabel = [[UILabel alloc]init];
    [self addSubview:_activityTimeLabel];
    _activityTimeLabel.text = @"15/09/28 18:00";
    [_activityTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_staticActivityTimeDes);
        make.left.equalTo(_deadLineTimeLabel);
    }];
    
    _locationImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"schedule_location"]];
    [self addSubview:_locationImageView];
    [_locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_staticActivityTimeDes.mas_bottom).offset(10);
        make.centerX.equalTo(_timeImageView.mas_centerX);
    }];
    
    _locationLabel = [[UILabel alloc]init];
    _locationLabel.text = @"大脚超市门口";
    [self addSubview:_locationLabel];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_staticActivityTimeDes);
        make.centerY.equalTo(_locationImageView.mas_centerY);
    }];
    
    _categotyImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"funny_detail_category"]];
    [self addSubview:_categotyImageView];
    [_categotyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_locationImageView.mas_bottom).offset(10);
        make.centerX.equalTo(_locationImageView);
    }];
    
    _categoryLabel = [[UILabel alloc]init];
    [self addSubview:_categoryLabel];
    _categoryLabel.text = @"学术类";
    [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_locationLabel);
        make.centerY.equalTo(_categotyImageView.mas_centerY);
    }];
}

@end
