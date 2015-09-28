//
//  ScheduleCell.m
//  XiaoYou
//
//  Created by sheng on 15/9/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ScheduleCell.h"
#define CELL_INSET  10
@interface ScheduleCell ()
@property (nonatomic,retain) UIImageView    *timeRemindImageView;//时间提醒,今天,明天,后天,
@property (nonatomic,retain) UIView         *wrapContentView;   //内容View
@property (nonatomic,retain) UILabel        *timeLabel;         //时间
@property (nonatomic,retain) UILabel        *otherLabel;        //还有谁
@property (nonatomic,retain) UIImageView    *tooSeeMoreImageView;//查看更多图片
@property (nonatomic,retain) UIView         *sepLineView;       //分割线
@property (nonatomic,retain) UILabel        *projectNameLabel;  //项目名称
@property (nonatomic,retain) UIImageView    *activityTimeImageView;//时间图片
@property (nonatomic,retain) UILabel        *activityTimeLabel; //静态活动时间
@property (nonatomic,retain) UILabel        *activityTimeDesLabel;//具体时间
@property (nonatomic,retain) UIImageView    *locationImageView; //地址图片
@property (nonatomic,retain) UILabel        *locationLabel;     //活动地址

@end


@implementation ScheduleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:235.0/255 green:235/255 blue:241/255 alpha:0];
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
    _wrapContentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
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
    _timeLabel.font = [UIFont systemFontOfSize:20.0f];
    _timeLabel.text = @"明天";
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.mas_equalTo(10);
    }];
    
    _otherLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_otherLabel];
    _otherLabel.font = [UIFont systemFontOfSize:16];
    _otherLabel.text = @"还有谁";
    [_otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-20);
        make.centerY.equalTo(self.timeLabel.mas_centerY);
    }];
    
    
    _tooSeeMoreImageView = [[UIImageView alloc]init];
    [self.wrapContentView addSubview:_tooSeeMoreImageView];
    _tooSeeMoreImageView.image = [UIImage imageNamed:@"arrow"];
    [_tooSeeMoreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-5);
        make.centerY.equalTo(_otherLabel.mas_centerY);
    }];
    
    _sepLineView = [[UIView alloc]init];
    [self.wrapContentView addSubview:_sepLineView];
    _sepLineView.backgroundColor = [UIColor lightGrayColor];
    [_sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.wrapContentView.mas_top).offset(42);
    }];
    
    _projectNameLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_projectNameLabel];
    _projectNameLabel.text = @"名称：10个人荧光跑";
    [_projectNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_left);
        make.top.equalTo(self.sepLineView.mas_bottom).offset(10);
    }];
    
    _activityTimeImageView = [[UIImageView alloc]init];
    [self.wrapContentView addSubview:_activityTimeImageView];
    _activityTimeImageView.image = [UIImage imageNamed:@"schedule_time"];
    [_activityTimeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_left);
        make.top.equalTo(self.projectNameLabel.mas_bottom).offset(10);
    }];
    
    _activityTimeLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_activityTimeLabel];
    _activityTimeLabel.text = @"活动时间";
    _activityTimeLabel.font = [UIFont systemFontOfSize:14.0f];
    [_activityTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.activityTimeImageView.mas_centerY);
        make.left.equalTo(self.activityTimeImageView.mas_right).offset(15);
    }];
    
    _activityTimeDesLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_activityTimeDesLabel];
    _activityTimeDesLabel.text = @"15/10/28  18:00";
    [_activityTimeDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.activityTimeImageView.mas_centerY);
        make.left.equalTo(self.activityTimeLabel.mas_right).offset(10);
    }];
    
    _locationImageView = [[UIImageView alloc]init];
    [self.wrapContentView addSubview:_locationImageView];
    _locationImageView.image = [UIImage imageNamed:@"schedule_location"];
    [_locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel);
        make.top.equalTo(self.activityTimeImageView.mas_bottom).offset(10);
    }];
    
    _locationLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_locationLabel];
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
        make.top.mas_equalTo(10);
    }];
}

@end
