//
//  AssociationsListTableViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/16.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AssociationsListTableViewCell.h"
#import "YUtils+Component.h"
#import "UIImageView+WebCache.h"

NSString *const kAssociationsListTableViewCell = @"AssociationsListTableViewCellId";

#define K_HEADIMG_LT    SCALE_NUM(10)   //头像左上
#define K_HEADIMG_WH    SCALE_NUM(30)   //头像宽高

#define K_CONTENT_L     SCALE_NUM(22)   //内容左间距
#define K_CONTENT_R     SCALE_NUM(-6)    //右间距
#define K_CONTENT_M     SCALE_NUM(16)   //中间间距

#define K_TAG_IMG_W     SCALE_NUM(12)   //tag图片宽度
#define K_TAG_IMG_H     SCALE_NUM(15)   //tag图片高度
#define K_TAG_TXT_L     SCALE_NUM(10)   //tag文字左间距

#define K_STAR_L        SCALE_NUM(251)  //星级左间距
#define K_STAR_H        SCALE_NUM(13)   //星级高度
#define K_STAR_W        SCALE_NUM(12)   //星级宽度

#define K_KEY_B         SCALE_NUM(-8)    //关键字距底下

@interface AssociationsListTableViewCell ()

@property (nonatomic, strong) UIImageView   *headImageView;     //头像
@property (nonatomic, strong) UILabel       *nameLabel;         //名字
@property (nonatomic, strong) UIView        *starView;          //星级

@property (nonatomic, strong) UILabel       *typeLabel;         //类型

@property (nonatomic, strong) UILabel       *keywordsLabel;     //关键字

@end

@implementation AssociationsListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)initView {
    //1
    _headImageView = [UIImageView new];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg"]];
    [self.contentView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(K_HEADIMG_LT);
        make.width.height.mas_equalTo(K_HEADIMG_WH);
    }];
    
    //2
    _starView = [UIView new];
    [self.contentView addSubview:_starView];
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(K_STAR_L);
        make.right.mas_equalTo(K_CONTENT_R);
        make.top.equalTo(_headImageView.mas_top);
        make.height.mas_equalTo(K_STAR_H);
    }];
    [self initStarView];
    
    //3
    _nameLabel = [YUtils initLabel:CONTENT_FONT(14)
                             color:KCOLORGREEN_455A64
                              text:@"网球社网球社网球社网球社网球社网球社网球社网球社网球社网球社网球社网球社"
                             frame:CGRectZero
                         alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(K_CONTENT_L);
        make.top.equalTo(_headImageView.mas_top);
        make.right.equalTo(_starView.mas_left).offset(K_CONTENT_R);
        make.height.equalTo(_starView.mas_height);
    }];
    
    //4
    UIImageView *tagImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_tag"]];
    [self.contentView addSubview:tagImageView];
    [tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_nameLabel.mas_bottom).offset(K_CONTENT_M);
        make.height.mas_equalTo(K_TAG_IMG_H);
        make.width.mas_equalTo(K_TAG_IMG_W);
    }];
    
    //5
    _typeLabel = [YUtils initLabel:CONTENT_FONT(10)
                             color:[UIColor blackColor]
                              text:@"体育体育体育体育体育体育体育体育体育体育体育体育体育体育体育体育"
                             frame:CGRectZero
                         alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tagImageView.mas_right).offset(K_TAG_TXT_L);
        make.right.mas_equalTo(K_CONTENT_R);
        make.centerY.equalTo(tagImageView.mas_centerY);
    }];
    
    //6
    _keywordsLabel = [YUtils initLabel:CONTENT_FONT(10)
                             color:KCOLORGREEN_455A64
                              text:@"keyword：零基础也没事、球场门票优惠keyword：零基础也没事、球场门票优惠keyword：零基础也没事、球场门票优惠keyword：零基础也没事、球场门票优惠"
                             frame:CGRectZero
                         alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_keywordsLabel];
    [_keywordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(tagImageView.mas_bottom).offset(K_CONTENT_M);
        make.right.mas_equalTo(K_CONTENT_R);
        make.bottom.mas_equalTo(K_KEY_B);
    }];
}

- (void)initStarView
{
    //清除上面的view
    NSArray *viewArray = _starView.subviews;
    [viewArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [view removeFromSuperview];
    }];
    
    for (int i = 0; i < 5; ++i) {
        UIImageView *starImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_star"]];
        [_starView addSubview:starImageView];
        
        [starImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_starView);
            if (0 == i) {
                make.left.mas_equalTo(0);
            } else {
                make.left.mas_equalTo(i*K_STAR_W+1);
            }
            
            make.width.mas_equalTo(K_STAR_W);
        }];
    }
}

@end
