//
//  AssociationsListTableViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/16.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AssociationsListTableViewCell.h"
#import "YUtils+Component.h"
#import "GroupModel.h"
#import "UIImageView+Ext.h"

NSString *const kAssociationsListTableViewCell = @"AssociationsListTableViewCellId";

#define K_HEADIMG_LT    SCALE_NUM(10)   //头像左上
#define K_HEADIMG_WH    SCALE_NUM(30)   //头像宽高

#define K_CONTENT_L     SCALE_NUM(22)   //内容左间距
#define K_CONTENT_R     SCALE_NUM(-6-11-24)    //右间距
#define K_CONTENT_M     SCALE_NUM(16)   //中间间距

#define K_TAG_IMG_W     SCALE_NUM(11)   //tag图片宽度
#define K_TAG_IMG_H     SCALE_NUM(14)   //tag图片高度
#define K_TAG_TXT_L     SCALE_NUM(10)   //tag文字左间距

#define K_STAR_L        SCALE_NUM(251)  //星级左间距
#define K_STAR_H        SCALE_NUM(13)   //星级高度
#define K_STAR_W        SCALE_NUM(12)   //星级宽度

#define K_KEY_B         SCALE_NUM(-8)    //关键字距底下

@interface AssociationsListTableViewCell ()

@property (nonatomic, strong) UIImageView   *headImageView;     //头像
@property (nonatomic, strong) UILabel       *defaultLabel;      //默认文字
@property (nonatomic, strong) UILabel       *nameLabel;         //名字
@property (nonatomic, strong) UIView        *starView;          //星级
@property (nonatomic, strong) UIImageView   *hotImageView;      //hot

@property (nonatomic, strong) UIImageView   *tagImageView;       //类型imageview
@property (nonatomic, strong) UILabel       *typeLabel;         //类型

@property (nonatomic, strong) UILabel       *keywordsLabel;     //关键字

@end

@implementation AssociationsListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initView];
        self.contentView.backgroundColor = KCOLORWHITE;
    }
    
    return self;
}

- (void)initView {
    //1
    _headImageView = [UIImageView new];
    [self.contentView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(K_HEADIMG_LT);
        make.width.height.mas_equalTo(K_HEADIMG_WH);
    }];
    
    //班
    _defaultLabel = [[UILabel alloc] init];
    _defaultLabel.textAlignment = NSTextAlignmentCenter;
    _defaultLabel.textColor = [UIColor whiteColor];
    [_headImageView addSubview:_defaultLabel];
    [_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_headImageView);
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
                             color:KCOLOR_455A64
                              text:@"网球社"
                             frame:CGRectZero
                         alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(K_CONTENT_L);
        make.top.equalTo(_headImageView.mas_top);
        make.right.lessThanOrEqualTo(_starView.mas_left).offset(K_CONTENT_R);
        make.height.equalTo(_starView.mas_height);
    }];
    
    //hot
    _hotImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hot"]];
    _hotImageView.hidden = YES;
    [self.contentView addSubview:_hotImageView];
    [_hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(SCALE_NUM(11));
        make.top.equalTo(_nameLabel.mas_top);
        make.width.mas_equalTo(SCALE_NUM(24));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    
    //4
    _tagImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tag-green"]];
    [self.contentView addSubview:_tagImageView];
    [_tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_nameLabel.mas_bottom).offset(K_CONTENT_M);
        make.height.mas_equalTo(K_TAG_IMG_H).priorityLow();
        make.width.mas_equalTo(K_TAG_IMG_W);
    }];
    
    //5
    _typeLabel = [YUtils initLabel:CONTENT_FONT(10)
                             color:[UIColor blackColor]
                              text:@"体育体育体育体育体育体育体育"
                             frame:CGRectZero
                         alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tagImageView.mas_right).offset(K_TAG_TXT_L);
        make.right.mas_equalTo(K_CONTENT_R);
        make.centerY.equalTo(_tagImageView.mas_centerY);
    }];
    
    //6
    _keywordsLabel = [YUtils initLabel:CONTENT_FONT(10)
                             color:KCOLOR_455A64
                              text:@""
                             frame:CGRectZero
                         alignment:NSTextAlignmentLeft];
    _keywordsLabel.numberOfLines = 0;
    [self.contentView addSubview:_keywordsLabel];
    [_keywordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_tagImageView.mas_bottom).offset(K_CONTENT_M);
        make.right.mas_equalTo(K_CONTENT_R);
        make.bottom.mas_equalTo(K_KEY_B);
    }];
}

- (BOOL)needLine
{
    return YES;
}

- (void)initStarView
{
    //清除上面的view
    NSArray *viewArray = _starView.subviews;
    [viewArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [view removeFromSuperview];
    }];
    
    for (int i = 0; i < 5; ++i) {
        UIImageView *starImageView = [[UIImageView alloc]
                                      initWithImage:[UIImage imageNamed:@"common_star"]];
        starImageView.hidden = YES;
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

- (void)resetData:(GroupModel *)model isDetail:(BOOL)isDetail {
    [_headImageView setNormalImageWithUrl:model.groupIcon];
    if (model.groupIcon.length > 0) {
        _defaultLabel.hidden = YES;
        _headImageView.backgroundColor = [UIColor clearColor];
    } else {
        _defaultLabel.hidden = NO;
        _headImageView.backgroundColor = KCOLOR_009688;
        _defaultLabel.text = [model.groupName substringWithRange:NSMakeRange(0, 1)];
    }
    
    _nameLabel.text = model.groupName;
    _hotImageView.hidden = !model.hot;
    if (model.keyWords.length > 0) {
        _keywordsLabel.text = [NSString stringWithFormat:@"keywords：%@", model.keyWords];
    } else {
        _keywordsLabel.text = @"";
    }
    _keywordsLabel.numberOfLines = isDetail?0:1;
    _tagImageView.hidden = (model.keyWords.length <= 0);
    _typeLabel.text = model.category;
    NSInteger starNum = [model.star integerValue];
    
    //清除上面的view
    NSArray *viewArray = _starView.subviews;
    [viewArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if (idx >= starNum) {
            view.hidden = YES;
        } else {
            view.hidden = NO;
        }
    }];
}

@end
