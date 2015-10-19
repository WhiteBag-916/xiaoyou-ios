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
@property (nonatomic,strong) UILabel        *signUpTimeLabel;  //报名时间
@property (nonatomic,strong) UILabel        *activityTimeLabel;//活动时间
@property (nonatomic,strong) UILabel        *organizerLabel;   //组织者
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
        make.leading.mas_equalTo(0);
        make.top.mas_equalTo(20);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.text = @"唔知安迪电影10不连续放映";
    _titleLabel.textColor = KCOLORGREEN_B4;
    _titleLabel.font = CONTENT_FONT(15);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_startImageView.mas_right).offset(SCALE_NUM(12));
        make.centerY.equalTo(_startImageView.mas_centerY);
    }];
    
    _typeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_typeLabel];
    [_typeLabel setTextColor:[UIColor whiteColor]];
    _typeLabel.layer.cornerRadius = 3;
    _typeLabel.clipsToBounds = YES;
    _typeLabel.backgroundColor = RGBACOLOR(180, 50, 80, 1);
    _typeLabel.text = @" 活动 ";
    _typeLabel.font = CONTENT_FONT(10);
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLabel.mas_centerY);
        make.left.mas_equalTo(_titleLabel.mas_right).offset(SCALE_NUM(10));
    }];
    
    _descriptionLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_descriptionLabel];
    _descriptionLabel.numberOfLines = 3;
    _descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _descriptionLabel.font = CONTENT_FONT(12);
    _descriptionLabel.textColor = KCOLORGREEN_B5;
    _descriptionLabel.text = @"描述:唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影10不连续放映唔知安迪电影1";
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
    
    
//    _middleView = [[FeedImageGroup alloc]init];
//    [self.contentView addSubview:_middleView];
//    
//    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_topView.mas_bottom);
//        make.left.equalTo(_topView.descriptionLabel.mas_left);
//        make.right.equalTo(_topView.descriptionLabel);
//    }];
//    
//    NSArray *smallImages    = @[@"/dev/feed/s/c2cfe0e7-ba38-43e0-b345-3d14ff2f2bcf.png",@"/dev/feed/s/c2cfe0e7-ba38-43e0-b345-3d14ff2f2bcf.png",@"/dev/feed/s/c2cfe0e7-ba38-43e0-b345-3d14ff2f2bcf.png"];
//    NSArray *bigImages      = @[@"/dev/feed/c2cfe0e7-ba38-43e0-b345-3d14ff2f2bcf.png",@"/dev/feed/c2cfe0e7-ba38-43e0-b345-3d14ff2f2bcf.png",@"/dev/feed/c2cfe0e7-ba38-43e0-b345-3d14ff2f2bcf.png"];
//    [_middleView updateWithImgs:smallImages bigPics:bigImages];
    
    
    
    _signUpTimeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_signUpTimeLabel];
    _signUpTimeLabel.text = @"报名时间: 2015/10/25-2015/11/12";
    _signUpTimeLabel.font = CONTENT_FONT(12);
    _signUpTimeLabel.textColor = KCOLORGREEN_B5;
    [_signUpTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageGroupView);
        make.top.equalTo(_imageGroupView.mas_bottom).offset(SCALE_NUM(15));
    }];
    
    _activityTimeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_activityTimeLabel];
    _activityTimeLabel.font = CONTENT_FONT(12);
    _activityTimeLabel.textColor = KCOLORGREEN_B5;
    _activityTimeLabel.text = @"活动时间:2015/11/25";
    [_activityTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_signUpTimeLabel.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_signUpTimeLabel);
    }];
    
    _organizerLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_organizerLabel];
    _organizerLabel.font = CONTENT_FONT(12);
    _organizerLabel.textColor = KCOLORGREEN_B5;
    _organizerLabel.text = @"组织者:王小明";
    [_organizerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_activityTimeLabel.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_activityTimeLabel);
    }];
}


@end
