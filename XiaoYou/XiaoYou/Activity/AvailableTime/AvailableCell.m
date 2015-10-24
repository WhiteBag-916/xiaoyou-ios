//
//  AvailableCell.m
//  XiaoYou
//
//  Created by sheng on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AvailableCell.h"
#import "FeedImageGroup.h"
#define REUSEID @"AvailableCell"
@interface AvailableCell ()

@property (nonatomic,strong) UIImageView    *startImageView; //开始图
@property (nonatomic,strong) UILabel        *titleLabel;    //标题
@property (nonatomic,strong) UILabel        *typeLabel;     //类型
@property (nonatomic,strong) UILabel        *descriptionLabel;//描述
//中间图片部分
@property (nonatomic,strong) FeedImageGroup *imageGroupView;   //图片
//底部部分View

@property (nonatomic,strong) UILabel        *signUpTimeDes;     //报名截止时间
@property (nonatomic,strong) UILabel        *activityTimeDes;   //活动开始时间
@property (nonatomic,strong) UILabel        *activityEndTimeDes;//活动结束时间
@property (nonatomic,strong) UILabel        *activityLocationDes;//活动地点
@property (nonatomic,strong) UILabel        *oranizerDes;       //组织者

@property (nonatomic,strong) UILabel        *signUpTimeLabel;       //报名截止时间
@property (nonatomic,strong) UILabel        *activityTimeLabel;     //活动开始时间
@property (nonatomic,strong) UILabel        *activityEndTimeLabel;  //活动结束时间
@property (nonatomic,strong) UILabel        *activityLocationLabel; //活动地点
@property (nonatomic,strong) UILabel        *organizerLabel;        //组织者

@end


@implementation AvailableCell


+(AvailableCell *)cellWithTableView:(UITableView *)tableView
{
    AvailableCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEID];
    if (!cell) {
        cell = [[AvailableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSEID];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


-(void)initView
{
    _startImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_startImageView];
    _startImageView.image = [UIImage imageNamed:@"green_bar"];
    [_startImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(0));
        make.top.mas_equalTo(SCALE_NUM(20));
    }];
    
    
    _titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.text = @"大型历史音乐剧《和平使者——抗战中的宋庆龄》奋斗史";
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = KCOLORGREEN_B4;
    _titleLabel.font = CONTENT_FONT(15);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.equalTo(_typeLabel.mas_right).offset(SCALE_NUM(10));
        //make.top.equalTo(_typeLabel);
        
        make.leading.mas_equalTo(SCALE_NUM(15));
        if (IS_IPHONE_6)
            make.trailing.mas_equalTo(SCALE_NUM(-45));
        else
            make.trailing.mas_equalTo(SCALE_NUM(-55));
        make.top.equalTo(_startImageView.mas_top).offset(SCALE_NUM(-5));
    }];
    
    
    _typeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_typeLabel];
    [_typeLabel setTextColor:[UIColor whiteColor]];
    _typeLabel.layer.cornerRadius = 3;
    _typeLabel.clipsToBounds = YES;
    _typeLabel.backgroundColor = RGBACOLOR(180, 50, 80, 1);
    _typeLabel.text = @"  活动  ";
    _typeLabel.font = CONTENT_FONT(10);
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(15));
        make.trailing.mas_equalTo(SCALE_NUM(-15));
        make.top.equalTo(_titleLabel).offset(SCALE_NUM(2));
    }];
    
    _descriptionLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_descriptionLabel];
    _descriptionLabel.numberOfLines = 3;
    _descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _descriptionLabel.font = CONTENT_FONT(12);
    _descriptionLabel.textColor = KCOLORGREEN_B5;
    
    NSString *desTextString = @"活动简介：本剧讲述了在日寇荼毒神州大地的悲壮年代，宋庆龄从中华民族的大局利益出发，积极投身抗日救亡的运动中。 从1932年1月，侵华日军突袭上海，第一次“淞沪抗战“爆发，宋庆龄亲赴前线慰问十九路军官兵；到促使“西安事变”和平解决，全国上下团结抗日局面的形成；再到香港组建“保卫中国同盟”募集物资支援抗战，参加广州火炬大游行；最后为巩固抗日统一战线，宋氏三姐妹赴重庆视察，并向世界发表广播演讲为主线。充分展示了宋庆龄在国家动荡之时，在民族危难之际，所体现出伟大的爱国主义、民主主义精神！塑造了一个“柔肩担道义、正气盈天地”的伟大女性。";
    
    [_descriptionLabel setText:desTextString lineSpacing:SCALE_NUM(10.f)];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(SCALE_NUM(18));
        make.left.equalTo(_titleLabel);
        make.trailing.mas_equalTo(SCALE_NUM(-12));
    }];
    
    _imageGroupView = [[FeedImageGroup alloc]init];
    [self.contentView addSubview:_imageGroupView];
    [_imageGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descriptionLabel.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_descriptionLabel);
        make.right.equalTo(_descriptionLabel.mas_right);
    }];
    NSArray *smallImages    = @[@"/dev/feed/s/c2cfe0e7-ba38-43e0-b345-3d14ff2f2bcf.png"];
    NSArray *bigImages      = @[@"/dev/feed/c2cfe0e7-ba38-43e0-b345-3d14ff2f2bcf.png"];
    [_imageGroupView updateWithImgs:smallImages bigPics:bigImages];
    
    
    _signUpTimeDes = [[UILabel alloc]init];
    [self.contentView addSubview:_signUpTimeDes];
    _signUpTimeDes.text = @"报名截止时间：";
    _signUpTimeDes.font = CONTENT_FONT(12);
    _signUpTimeDes.textColor = KCOLORGREEN_B5;
    [_signUpTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.left.equalTo(_imageGroupView);
        make.top.equalTo(_imageGroupView.mas_bottom).offset(SCALE_NUM(15));
    }];
    
    _signUpTimeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_signUpTimeLabel];
    _signUpTimeLabel.text = @"2015/10/25 06:00";
    _signUpTimeLabel.font = CONTENT_FONT(12);
    _signUpTimeLabel.textColor = KCOLORGREEN_B5;
    [_signUpTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.centerY.equalTo(_signUpTimeDes);
        make.left.equalTo(_signUpTimeDes.mas_right).offset(SCALE_NUM(15));
    }];
    
    
    _activityTimeDes = [[UILabel alloc]init];
    [self.contentView addSubview:_activityTimeDes];
    _activityTimeDes.font = CONTENT_FONT(12);
    _activityTimeDes.textColor = KCOLORGREEN_B5;
    _activityTimeDes.text = @"活动开始时间：";
    [_activityTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(_signUpTimeDes.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_signUpTimeDes);
    }];
    
    _activityTimeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_activityTimeLabel];
    _activityTimeLabel.font = CONTENT_FONT(12);
    _activityTimeLabel.textColor = KCOLORGREEN_B5;
    _activityTimeLabel.text = @"2015/10/05 06:00";
    [_activityTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.centerY.equalTo(_activityTimeDes);
        make.left.equalTo(_signUpTimeLabel);
    }];
    

    
    _activityEndTimeDes = [[UILabel alloc]init];
    [self.contentView addSubview:_activityEndTimeDes];
    _activityEndTimeDes.font = CONTENT_FONT(12);
    _activityEndTimeDes.textColor = KCOLORGREEN_B5;
    _activityEndTimeDes.text = @"活动结束时间：";
    [_activityEndTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(_activityTimeDes.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_activityTimeDes);
    }];
    
    _activityEndTimeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_activityEndTimeLabel];
    _activityEndTimeLabel.font = CONTENT_FONT(12);
    _activityEndTimeLabel.textColor = KCOLORGREEN_B5;
    _activityEndTimeLabel.text = @"2015/10/25 06:00";
    [_activityEndTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.centerY.equalTo(_activityEndTimeDes);
        make.left.equalTo(_activityTimeLabel);
    }];
    
    
    _activityLocationDes = [[UILabel alloc]init];
    [self.contentView addSubview:_activityLocationDes];
    _activityLocationDes.font = CONTENT_FONT(12);
    _activityLocationDes.textColor = KCOLORGREEN_B5;
    _activityLocationDes.text = @"活动地点：";
    [_activityLocationDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(_activityEndTimeDes.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_activityEndTimeDes);
    }];
    
    _activityLocationLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_activityLocationLabel];
    _activityLocationLabel.font = CONTENT_FONT(12);
    _activityLocationLabel.textColor = KCOLORGREEN_B5;
    _activityLocationLabel.text = @"大脚超市门口";
    [_activityLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.centerY.equalTo(_activityLocationDes);
        make.left.equalTo(_activityEndTimeLabel);
    }];
    
    
    _oranizerDes = [[UILabel alloc]init];
    [self.contentView addSubview:_oranizerDes];
    _oranizerDes.font = CONTENT_FONT(12);
    _oranizerDes.textColor = KCOLORGREEN_B5;
    _oranizerDes.text = @"组织者：";
    [_oranizerDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(_activityLocationDes.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_activityLocationDes);
    }];
    
    _organizerLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_organizerLabel];
    _organizerLabel.font = CONTENT_FONT(12);
    _organizerLabel.textColor = KCOLORGREEN_B5;
    _organizerLabel.text = @"话剧社";
    [_organizerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.centerY.equalTo(_oranizerDes);
        make.left.equalTo(_activityTimeLabel);
    }];
}


-(void)setData:(ActivityModelTest *)model
{
    if (![model.acTitle containsString:@"            "])
        model.acTitle = [NSString stringWithFormat:@"%@",model.acTitle];
    _titleLabel.text        = model.acTitle;
    //_descriptionLabel.text  = model.acBrief;
    
    [_descriptionLabel setText:model.acBrief lineSpacing:SCALE_NUM(10.f)];
    NSArray *smallImages    = @[model.acPhotos];
    NSArray *bigImages      = @[model.acPhotos];
    [_imageGroupView updateWithImgs:smallImages bigPics:bigImages];
    _activityLocationLabel.text = model.acLocation;
    _organizerLabel.text = model.acOgnazier;
}

@end
