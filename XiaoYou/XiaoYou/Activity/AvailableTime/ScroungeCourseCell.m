//
//  ScroungeCourseCell.m
//  XiaoYou
//
//  Created by sheng on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ScroungeCourseCell.h"

#define REUSEID @"ScroungeCourseCell"
@interface ScroungeCourseCell ()

@property (nonatomic,strong) UIImageView    *startImageView;
@property (nonatomic,strong) UILabel        *titleLabel;
@property (nonatomic,strong) UILabel        *desLabel;

@end

@implementation ScroungeCourseCell


+(ScroungeCourseCell *)cellWithTableView:(UITableView *)tableView
{
    ScroungeCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEID];
    if (!cell) {
        cell = [[ScroungeCourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSEID];
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
    _startImageView.image = [UIImage imageNamed:@"_bar"];
    [_startImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(20));
        make.leading.mas_equalTo(0);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.text = @"你可以蹭的课";
    _titleLabel.textColor = KCOLOR_B4;
    _titleLabel.font = CONTENT_FONT(15);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(15));
        make.centerY.equalTo(_startImageView.mas_centerY);
        make.leading.mas_equalTo(SCALE_NUM(15));
    }];
    
    _desLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_desLabel];
    _desLabel.font = CONTENT_FONT(12);
    _desLabel.textColor = KCOLOR_B5;
    _desLabel.text = @"刘涛老师带你对饭店是非得失";
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(_titleLabel.mas_bottom).offset(SCALE_NUM(20));
        make.left.equalTo(_titleLabel);
    }];
}


@end
