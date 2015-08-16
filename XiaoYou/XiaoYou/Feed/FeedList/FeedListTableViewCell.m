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
#import "FeedImageGroup.h"

NSString *const kFeedListTableViewCell = @"FeedListTableViewCellId";
#define KHEADIMGWIDTH SCALE_NUM(30)//头像宽度
#define KLEFTMARGIN SCALE_NUM(15)//内容的左间距
#define KHEADIMGTOP SCALE_NUM(20)//头像距顶高度
#define KNAMEMARGIN_LEFT SCALE_NUM(15)//名字左间距

#define KTAGHEIGHT SCALE_NUM(20)
#define KTAGMARGIN SCALE_NUM(6)
#define KTAGMARGIN_TOP SCALE_NUM(15)

#define KCONTENTMARGIN_TOP SCALE_NUM(20)

#define KBOTTOMHEIGHT SCALE_NUM(25)
#define KSHAREWIDTH SCALE_NUM(25)
#define KCOMMENTWIDTH SCALE_NUM(25)
#define KBUTTONTEXTMARGIN SCALE_NUM(8)

@interface FeedListTableViewCell ()

@property (nonatomic, strong) UIView *topView;                      //内容以上UI
@property (nonatomic, strong) UIImageView *contactHeadImageView;    //头像
@property (nonatomic, strong) UILabel *contactNameLabel;            //名字
@property (nonatomic, strong) UILabel *timeLabel;                   //时间
@property (nonatomic, strong) DWTagList *tagList;                   //人标签


@property (nonatomic, strong) UILabel *contentLabel;                //内容
@property (nonatomic, strong) UIImageView *tagIcon;                 //tag图标
@property (nonatomic, strong) UILabel *tagLabel;                    //feed标签
@property (nonatomic, strong) FeedImageGroup *imgGroup;             //图片

@property (nonatomic, strong) UIButton *shareButton;                //分享按钮
@property (nonatomic, strong) UILabel *commentNum;                  //评论按钮
@property (nonatomic, strong) UILabel *respectNum;                  //敬酒按钮

@end

@implementation FeedListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
//        self.contentView.bounds = [UIScreen mainScreen].bounds;
        
        //name
        //
//        //buttonView
//        _bottomButtonView = [[UIView alloc] init];
//        _bottomButtonView.backgroundColor = [UIColor redColor];
//        
//        //add
//        [self.contentView addSubview:_contentLabel];
//        [self.contentView addSubview:_bottomButtonView];
//        
//        //initMas
//        [self initMas];
        [self initTopView];
        [self initMiddleView];
        [self initBottomView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)initTopView {
    _topView = [[UIView alloc] init];
    [self.contentView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KLEFTMARGIN);
        make.top.centerX.equalTo(self.contentView);
    }];
    
    _contactHeadImageView = [[UIImageView alloc] init];
    [_topView addSubview:_contactHeadImageView];
    [_contactHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(KHEADIMGWIDTH);
        make.left.equalTo(_topView);
        make.top.equalTo(_topView).offset(KHEADIMGTOP);
    }];
    _contactHeadImageView.layer.cornerRadius = KHEADIMGWIDTH / 2;
    _contactHeadImageView.clipsToBounds = true;
    _contactHeadImageView.backgroundColor = [UIColor redColor];
    
    _contactNameLabel = [YUtils initLabel:CONTENT_FONT(18)
                                                    color:[UIColor blackColor]
                                                     text:@"人名"
                                                    frame:CGRectZero
                                                alignment:NSTextAlignmentLeft];
    [_topView addSubview:_contactNameLabel];
    [_contactNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contactHeadImageView.mas_right).offset(KNAMEMARGIN_LEFT);
        make.centerY.top.equalTo(_contactHeadImageView);
    }];
    
    _timeLabel = [YUtils initLabel:CONTENT_FONT(18) color:[UIColor blackColor] text:@"刚刚" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [_topView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contactNameLabel.mas_right).offset(KLEFTMARGIN);
        make.top.centerY.equalTo(_contactNameLabel);
    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_contactHeadImageView);
    }];
    
    
    
}

- (void)initMiddleView {
    _contentLabel = [YUtils initLabel:CONTENT_FONT(18)
                                color:[UIColor blackColor]
                                 text:@"o be, or not to be —that is the question, Whether'tis nobler in the mind to suffer. The slings and arrows of outrageous fortune Or to take arms against a sea of troubles, And by opposing end them. To die —to sleep"
                                frame:CGRectZero
                            alignment:NSTextAlignmentLeft];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_topView);
        make.top.equalTo(_topView.mas_bottom).offset(KCONTENTMARGIN_TOP);
    }];
    
    _imgGroup = [[FeedImageGroup alloc] init];
    [self.contentView addSubview:_imgGroup];
    [_imgGroup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_contentLabel);
        make.top.equalTo(_contentLabel.mas_bottom).offset(KTAGMARGIN_TOP);
    }];
    
    _tagLabel = [YUtils initLabel:CONTENT_FONT(18) color:[UIColor blackColor] text:@"# 互联网 #" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_tagLabel];
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.equalTo(_contentLabel);
        make.top.equalTo(_imgGroup.mas_bottom).offset(KTAGMARGIN_TOP);
    }];
    
    
}

- (void)initBottomView {
    UIView *bottomView = [[UIView alloc] init];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tagLabel.mas_bottom).offset(50);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.left.centerX.equalTo(_topView);
        make.height.mas_equalTo(KBOTTOMHEIGHT);
    }];
    
    _shareButton = [[UIButton alloc] init];
    [bottomView addSubview:_shareButton];
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentLabel);
        make.top.centerY.equalTo(bottomView);
        make.width.mas_equalTo(KSHAREWIDTH);
    }];
    _shareButton.backgroundColor = [UIColor redColor];
    
    UIView *commentView = [[UIView alloc] init];
    [bottomView addSubview:commentView];
    [commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.centerX.equalTo(bottomView);
    }];
    
    UIImageView *commentImg = [[UIImageView alloc] init];
    [commentView addSubview:commentImg];
    [commentImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(commentView);
        make.width.mas_equalTo(KCOMMENTWIDTH);
    }];
    commentImg.backgroundColor = [UIColor redColor];
    
    _commentNum = [YUtils initLabel:CONTENT_FONT(18) color:[UIColor blackColor] text:@"50000" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [commentView addSubview:_commentNum];
    [_commentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(commentImg.mas_right).offset(KBUTTONTEXTMARGIN);
        make.top.bottom.right.equalTo(commentView);
    }];
    
    UIImageView *respectImg = [[UIImageView alloc] init];
    [bottomView addSubview:respectImg];
    [respectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_centerX).multipliedBy(1.3);
        make.top.bottom.equalTo(bottomView);
        make.width.equalTo(commentImg);
    }];
    respectImg.backgroundColor = [UIColor redColor];
    
    _respectNum = [YUtils initLabel:CONTENT_FONT(18) color:[UIColor blackColor] text:@"999" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [bottomView addSubview:_respectNum];
    [_respectNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(respectImg.mas_right).offset(KBUTTONTEXTMARGIN);
        make.top.bottom.equalTo(bottomView);
    }];
}


- (void)setData
{
    _contentLabel.text = @"To be, or not to be —that is the question, Whether'tis nobler in the mind to suffer. The slings and arrows of outrageous fortune Or to take arms against a sea of troubles, And by opposing end them. To die —to sleep";
    [_imgGroup updateWithImgs:@[@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg"] bigPics:@[@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
