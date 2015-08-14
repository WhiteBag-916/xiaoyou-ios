//
//  FeedListTableViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/12.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedListTableViewCell.h"
#import "DWTagList.h"
#import "YUtils+Component.h"
#import "Masonry.h"

NSString *const kFeedListTableViewCell = @"FeedListTableViewCellId";

@interface FeedListTableViewCell ()

@property (nonatomic, strong) UIImageView *contactHeadImageView;    //头像
@property (nonatomic, strong) UILabel *contactNameLabel;            //名字
@property (nonatomic, strong) UILabel *timeLabel;                   //时间
@property (nonatomic, strong) DWTagList *tagList;                   //人标签
@property (nonatomic, strong) UILabel *contentLabel;                //内容
@property (nonatomic, strong) UILabel *tagLabel;                    //feed标签
@property (nonatomic, strong) UIView *bottomButtonView;             //底下的button
@property (nonatomic, strong) UIButton *shareButton;                //分享按钮
@property (nonatomic, strong) UIButton *commentButton;              //评论按钮
@property (nonatomic, strong) UIButton *respectButton;              //敬酒按钮

@end

@implementation FeedListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.bounds = [UIScreen mainScreen].bounds;
        
        //name
        _contentLabel = [YUtils initLabel:CONTENT_FONT(18)
                                        color:[UIColor blackColor]
                                         text:@""
                                        frame:CGRectZero
                                    alignment:NSTextAlignmentCenter];
        _contentLabel.numberOfLines = 0;
        
        //buttonView
        _bottomButtonView = [[UIView alloc] init];
        _bottomButtonView.backgroundColor = [UIColor redColor];
        
        //add
        [self.contentView addSubview:_contentLabel];
        [self.contentView addSubview:_bottomButtonView];
        
        //initMas
        [self initMas];
    }
    
    return self;
}

- (void)initMas
{
    //name
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    //buttonView
    [_bottomButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
}

- (void)setData
{
    _contentLabel.text = @"To be, or not to be —that is the question, Whether'tis nobler in the mind to suffer. The slings and arrows of outrageous fortune Or to take arms against a sea of troubles, And by opposing end them. To die —to sleep";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
