//
//  ScheduleCell.m
//  XiaoYou
//
//  Created by sheng on 15/9/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ScheduleCell.h"
#define CELL_INSET  12
#define CELL_BACK_GROUND_COLOR
@interface ScheduleCell ()

@property (nonatomic,strong) UIImageView    *timeRemindImageView;//时间提醒,今天,明天,后天,
@property (nonatomic,strong) UIView         *wrapContentView;   //内容View
@property (nonatomic,strong) UILabel        *timeLabel;         //时间
@property (nonatomic,strong) UILabel        *otherLabel;        //还有谁
@property (nonatomic,strong) UIImageView    *tooSeeMoreImageView;//查看更多图片
@property (nonatomic,strong) UIView         *sepLineView;       //分割线
@property (nonatomic,strong) UILabel        *staticNameLabel;   //静态名称
@property (nonatomic,strong) UILabel        *projectNameLabel;  //项目名称
@property (nonatomic,strong) UIImageView    *activityTimeImageView;//时间图片
@property (nonatomic,strong) UILabel        *activityTimeLabel; //静态活动时间
@property (nonatomic,strong) UILabel        *activityTimeDesLabel;//具体时间
@property (nonatomic,strong) UIImageView    *locationImageView; //地址图片
@property (nonatomic,strong) UILabel        *locationLabel;     //活动地址

@end


@implementation ScheduleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:246.0/255 green:247/255 blue:249/255 alpha:0];
        [self initView];
    }
    return self;
}

-(void)initView
{
    //容器视图
    _wrapContentView = [[UIView alloc]init];
    [self.contentView addSubview:_wrapContentView];
    _wrapContentView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:254.0/255 green:1 blue:1 alpha:0];
    _wrapContentView.layer.borderWidth = 1;
    _wrapContentView.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1].CGColor;
    [_wrapContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(CELL_INSET);
        make.right.equalTo(self.mas_right).offset(-CELL_INSET);
    }];
    _wrapContentView.layer.cornerRadius = 5;
    _wrapContentView.clipsToBounds = YES;
    
    
    _timeLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_timeLabel];
    _timeLabel.font = CONTENT_FONT(20);
    _timeLabel.text = @"明天";
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.mas_equalTo(10);
    }];
    
    _otherLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_otherLabel];
    _otherLabel.font = CONTENT_FONT(12);
    _otherLabel.text = @"还有谁";
    [_otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-20);
        make.centerY.equalTo(self.timeLabel.mas_centerY);
    }];
    
    
    _tooSeeMoreImageView = [[UIImageView alloc]init];
    [self.wrapContentView addSubview:_tooSeeMoreImageView];
    _tooSeeMoreImageView.image = [UIImage imageNamed:@"too_see_more_arrow"];
    [_tooSeeMoreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-5);
        make.centerY.equalTo(_otherLabel.mas_centerY);
    }];
    
    _sepLineView = [[UIView alloc]init];
    [self.wrapContentView addSubview:_sepLineView];
    _sepLineView.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [_sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.wrapContentView.mas_top).offset(44);
    }];
    
    _staticNameLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_staticNameLabel];
    _staticNameLabel.font = CONTENT_FONT(12);
    _staticNameLabel.text = @"名称:";
    [_staticNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.equalTo(self.sepLineView.mas_bottom).offset(15);
    }];
    
    _projectNameLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_projectNameLabel];
    _projectNameLabel.font = CONTENT_FONT(12);
    _projectNameLabel.text = @"10个人荧光跑";
    [_projectNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.staticNameLabel.mas_right).offset(20);
        make.top.equalTo(self.staticNameLabel);
    }];
    
    _activityTimeImageView = [[UIImageView alloc]init];
    [self.wrapContentView addSubview:_activityTimeImageView];
    _activityTimeImageView.image = [UIImage imageNamed:@"schedule_time"];
    [_activityTimeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.staticNameLabel);
        make.top.equalTo(self.projectNameLabel.mas_bottom).offset(15);
    }];
    
    _activityTimeLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_activityTimeLabel];
    _activityTimeLabel.font = CONTENT_FONT(12);
    _activityTimeLabel.text = @"活动时间";
    [_activityTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.activityTimeImageView.mas_centerY);
        make.left.equalTo(self.projectNameLabel);
    }];
    
    _activityTimeDesLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_activityTimeDesLabel];
    _activityTimeDesLabel.font = CONTENT_FONT(12);
    _activityTimeDesLabel.text = @"15/10/28  18:00";
    [_activityTimeDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.activityTimeImageView.mas_centerY);
        make.left.equalTo(self.activityTimeLabel.mas_right).offset(10);
    }];
    
    _locationImageView = [[UIImageView alloc]init];
    [self.wrapContentView addSubview:_locationImageView];
    _locationImageView.image = [UIImage imageNamed:@"schedule_location"];
    [_locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.activityTimeImageView);
        make.top.equalTo(self.activityTimeImageView.mas_bottom).offset(15);
    }];
    
    _locationLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_locationLabel];
    _locationLabel.font = CONTENT_FONT(12);
    _locationLabel.text = @"大脚超市门口";
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.locationImageView);
        make.left.equalTo(self.activityTimeLabel);
    }];
    
    _timeRemindImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_timeRemindImageView];
    _timeRemindImageView.image = [UIImage imageNamed:@"schedule_houtian"];
    [_timeRemindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.top.mas_equalTo(SCALE_NUM(10));
    }];
}

@end
