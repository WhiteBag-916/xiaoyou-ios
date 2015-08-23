//
//  FeedContactTableViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedContactTableViewCell.h"
#import "ConnectTag.h"
#import "FeedTag.h"
#import "UIImageView+WebCache.h"
#import "YUtils+Component.h"

NSString *const kFeedContactTableViewCell = @"FeedContactTableViewCellId";

#define K_HEADIMG_LT    SCALE_NUM(12)   //头像左上
#define K_HEADIMG_WH    SCALE_NUM(44)   //头像宽高

#define K_ADDBUTTON_T   SCALE_NUM(17)   //添加按钮上
#define K_ADDBUTTON_WH  SCALE_NUM(26)   //头像宽高

#define K_CONTENT_MID   SCALE_NUM(-10)   //间隔

#define K_CONTENT_L     SCALE_NUM(22)   //名字左间距
#define K_CONTENT_R     SCALE_NUM(-6)   //右间距

#define KTAGMICONARGIN_TOP SCALE_NUM(18)
#define K_TAG_CONTENT_L SCALE_NUM(18)

@interface FeedContactTableViewCell ()

@property (nonatomic, strong) UIImageView   *headImageView;     //头像
@property (nonatomic, strong) UILabel       *nameLabel;         //名字
@property (nonatomic, strong) ConnectTag    *tagList;           //人脉标签
@property (nonatomic, strong) FeedTag       *tagView;           //tag的view

@end

@implementation FeedContactTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initView];
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
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"add-03"] forState:UIControlStateNormal];
    [addButton setImage:[UIImage imageNamed:@"add-03"] forState:UIControlStateHighlighted];
    [self.contentView addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(K_ADDBUTTON_T);
        make.right.mas_equalTo(K_CONTENT_MID);
        make.width.height.mas_equalTo(K_ADDBUTTON_WH);
    }];
    
    //3
    _nameLabel = [YUtils initLabel:CONTENT_FONT(14)
                             color:KCOLORGREEN_455A64
                              text:@"周凯周凯周凯周凯周凯周凯周凯周凯周凯周凯周凯周凯周凯"
                             frame:CGRectZero
                         alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(K_CONTENT_L);
        make.centerY.equalTo(addButton);
    }];
    
    //4
    _tagList = [[ConnectTag alloc] init];
    [self.contentView addSubview:_tagList];
    [_tagList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.lessThanOrEqualTo(addButton.mas_left).offset(K_CONTENT_MID);
        make.centerY.equalTo(addButton);
        make.left.equalTo(_nameLabel.mas_right).offset(K_CONTENT_R);
    }];
    
    //5
    [self initTagView];
    
    //6
    UIView *line = [[UIView alloc] init];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    line.backgroundColor = KCOLORGREEN_e5e5e5;
}

- (void)initTagView {
    _tagView = [[FeedTag alloc] init];
    [self.contentView addSubview:_tagView];
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(K_CONTENT_MID);
        make.top.equalTo(_tagList.mas_bottom).offset(KTAGMICONARGIN_TOP);
    }];
    [_tagView.tagIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
    }];
    [_tagView.tagContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tagView.tagIcon.mas_right).offset(K_TAG_CONTENT_L);
    }];
}

- (void)setData {
//    [_tagList updateTag:@[@"系",@"乡",@"班"]];
}

@end
