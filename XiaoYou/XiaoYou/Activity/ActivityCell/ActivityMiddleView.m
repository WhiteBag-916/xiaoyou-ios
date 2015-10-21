//
//  FunnyMiddleView.m
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityMiddleView.h"
#import "ActivityTopView.h"
@interface ActivityMiddleView ()
@property (nonatomic,strong) UIImageView    *timeImageView; //报名截止时间
@property (nonatomic,strong) UILabel        *staticDeadLineDes;//截止时间
@property (nonatomic,strong) UILabel        *deadLineTimeLabel;
@property (nonatomic,strong) UILabel        *staticActivityTimeDes;//活动时间
@property (nonatomic,strong) UILabel        *activityTimeLabel;//活动时间
@property (nonatomic,strong) UIImageView    *locationImageView;
@property (nonatomic,strong) UILabel        *locationLabel;
@property (nonatomic,strong) UIImageView    *categotyImageView;
@property (nonatomic,strong) UILabel        *categoryLabel;

@property (nonatomic,strong) UILabel        *staticActivityEndTimeDes;//活动结束时间
@property (nonatomic,strong) UILabel        *activityEndTimeLabel;
@end

@implementation ActivityMiddleView

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
        make.leading.mas_equalTo(31);
        make.top.mas_equalTo(10);
    }];
    
    _staticDeadLineDes = [[UILabel alloc]init];
    [self addSubview:_staticDeadLineDes];
    _staticDeadLineDes.font = CONTENT_FONT(13);
    _staticDeadLineDes.text = @"报名截止时间";
    _staticDeadLineDes.textColor = KCOLORGREEN_B3;
    [_staticDeadLineDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        make.leading.mas_equalTo(SCALE_NUM(66));
        make.centerY.equalTo(_timeImageView.mas_centerY);
    }];
    
    _deadLineTimeLabel = [[UILabel alloc]init];
    [self addSubview:_deadLineTimeLabel];
    _deadLineTimeLabel.textColor = KCOLORGREEN_B3;
    _deadLineTimeLabel.font = CONTENT_FONT(13);
    _deadLineTimeLabel.text = @"15/10/25 06:00";
    [_deadLineTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        make.left.equalTo(_staticDeadLineDes.mas_right).offset(10);
        make.centerY.equalTo(_staticDeadLineDes.mas_centerY);
    }];
    
    _staticActivityTimeDes = [[UILabel alloc]init];
    [self addSubview:_staticActivityTimeDes];
    _staticActivityTimeDes.textColor = KCOLORGREEN_B3;
    _staticActivityTimeDes.font = CONTENT_FONT(13);
    _staticActivityTimeDes.text = @"活动开始时间";
    [_staticActivityTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        make.top.equalTo(_deadLineTimeLabel.mas_bottom).offset(15);
        make.left.equalTo(_staticDeadLineDes);
    }];
    
    _activityTimeLabel = [[UILabel alloc]init];
    [self addSubview:_activityTimeLabel];
    _activityTimeLabel.textColor = KCOLORGREEN_B3;
    _activityTimeLabel.font = CONTENT_FONT(13);
    _activityTimeLabel.text = @"15/10/05 06:00";
    [_activityTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        make.top.equalTo(_staticActivityTimeDes);
        make.left.equalTo(_deadLineTimeLabel);
    }];
    
    _staticActivityEndTimeDes = [[UILabel alloc]init];
    [self addSubview:_staticActivityEndTimeDes];
    _staticActivityEndTimeDes.font = CONTENT_FONT(13);
    _staticActivityEndTimeDes.textColor = KCOLORGREEN_B3;
    _staticActivityEndTimeDes.text = @"活动结束时间";
    [_staticActivityEndTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        make.top.equalTo(_staticActivityTimeDes.mas_bottom).offset(15);
        make.left.equalTo(_staticActivityTimeDes);
    }];
    
    _activityEndTimeLabel = [[UILabel alloc]init];
    [self addSubview:_activityEndTimeLabel];
    _activityEndTimeLabel.textColor = KCOLORGREEN_B3;
    _activityEndTimeLabel.font = CONTENT_FONT(13);
    _activityEndTimeLabel.text = @"15/10/25 06:00";
    [_activityEndTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        make.left.equalTo(_staticActivityEndTimeDes.mas_right).offset(10);
        make.centerY.equalTo(_staticActivityEndTimeDes.mas_centerY);
    }];
    
    _locationImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"schedule_location"]];
    [self addSubview:_locationImageView];
    [_locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_staticActivityEndTimeDes.mas_bottom).offset(16);
        make.centerX.equalTo(_timeImageView.mas_centerX);
    }];
    
    _locationLabel = [[UILabel alloc]init];
    _locationLabel.text = @"大脚超市门口";
    [self addSubview:_locationLabel];
    _locationLabel.textColor = KCOLORGREEN_B3;
    _locationLabel.font = CONTENT_FONT(13);
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        make.left.equalTo(_staticActivityTimeDes);
        make.centerY.equalTo(_locationImageView.mas_centerY);
    }];
    
    _categotyImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"funny_detail_category"]];
    [self addSubview:_categotyImageView];
    [_categotyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_locationImageView.mas_bottom).offset(15);
        make.centerX.equalTo(_locationImageView);
    }];
    
    _categoryLabel = [[UILabel alloc]init];
    [self addSubview:_categoryLabel];
    _categoryLabel.font = CONTENT_FONT(13);
    _categoryLabel.text = @"学术类";
    _categoryLabel.textColor = KCOLORGREEN_B3;
    [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        make.left.equalTo(_locationLabel);
        make.centerY.equalTo(_categotyImageView.mas_centerY);
    }];
}

@end
