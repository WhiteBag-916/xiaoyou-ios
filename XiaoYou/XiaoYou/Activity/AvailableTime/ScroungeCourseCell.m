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
        cell = [[ScroungeCourseCell alloc]initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:REUSEID];
    }
    return cell;
}

-(BOOL)needLine
{
    return YES;
}

-(CGFloat)lineX
{
    return 20;
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
    _startImageView = [YUtils initImageViewWithImageName:@"green_bar"];
    [self.contentView addSubview:_startImageView];
    [_startImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(20));
        make.leading.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(3));
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel = [YUtils initLabel:CONTENT_FONT(15) color:KCOLOR_B4 text:@""];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(15));
        make.centerY.equalTo(_startImageView.mas_centerY);
        make.leading.mas_equalTo(SCALE_NUM(15));
    }];
    
    _desLabel = [YUtils initLabel:CONTENT_FONT(12) color:KCOLOR_B5 text:@""];
    [self.contentView addSubview:_desLabel];
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(_titleLabel.mas_bottom).offset(SCALE_NUM(20));
        make.left.equalTo(_titleLabel);
    }];
}


@end
