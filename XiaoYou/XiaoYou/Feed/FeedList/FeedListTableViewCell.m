//
//  FeedListTableViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/12.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedListTableViewCell.h"
#import "YUtils+Component.h"
#import "Masonry.h"
#import "FeedImageGroup.h"
#import "ConnectTag.h"

NSString *const kFeedListTableViewCell = @"FeedListTableViewCellId";
NSString *const kOrganizationFeedListTableViewCell = @"OrganizationFeedListTableViewCell";
#define KHEADIMGWIDTH SCALE_NUM(40)//头像宽度
#define KLEFTMARGIN SCALE_NUM(15)//头像的左间距
#define KHEADIMGTOP SCALE_NUM(12)//头像距顶高度
#define KNAMEMARGIN_LEFT SCALE_NUM(12)//名字左间距
#define KTIMEMARGIN_LEFT SCALE_NUM(12)//时间左间距

#define KTAGHEIGHT SCALE_NUM(20)
#define KTAGMARGIN SCALE_NUM(6)
#define KTAGMARGIN_TOP SCALE_NUM(15)

#define KCONTENTMARGIN_TOP _isOrganization?SCALE_NUM(10):SCALE_NUM(0)

#define KTAGMICONARGIN_TOP SCALE_NUM(18)

#define KBOTTOMHEIGHT SCALE_NUM(25)
#define KSHAREWIDTH SCALE_NUM(25)
#define KCOMMENTWIDTH SCALE_NUM(25)
#define KBUTTONTEXTMARGIN SCALE_NUM(2)


@interface FeedListTableViewCell ()

@property (nonatomic, strong) UIView *topView;                      //内容以上UI
@property (nonatomic, strong) UIImageView *contactHeadImageView;    //头像
@property (nonatomic, strong) UILabel *contactNameLabel;            //名字
@property (nonatomic, strong) UILabel *timeLabel;                   //时间
@property (nonatomic, strong) ConnectTag *tagList;                  //人脉标签


@property (nonatomic, strong) UILabel *contentLabel;                //内容
@property (nonatomic, strong) UIImageView *tagIcon;                 //tag图标
@property (nonatomic, strong) UILabel *tagLabel;                    //feed标签
@property (nonatomic, strong) FeedImageGroup *imgGroup;             //图片

@property (nonatomic, strong) UIImageView *shareButton;                //分享按钮
@property (nonatomic, strong) UILabel *commentNum;                  //评论按钮
@property (nonatomic, strong) UILabel *respectNum;                  //敬酒按钮

@property (nonatomic, assign) BOOL isOrganization;                  //是否是社团feed

@end

@implementation FeedListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        if ([reuseIdentifier isEqualToString:kFeedListTableViewCell]) {
            _isOrganization = false;
            [self initTopView];
        } else {
            _isOrganization = true;
        }
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
        make.left.equalTo(self.contentView).offset(KLEFTMARGIN);
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
    
    _contactNameLabel = [YUtils initLabel:CONTENT_FONT(15)
                                                    color:[UIColor blackColor]
                                                     text:@"人名"
                                                    frame:CGRectZero
                                                alignment:NSTextAlignmentLeft];
    [_topView addSubview:_contactNameLabel];
    [_contactNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contactHeadImageView.mas_right).offset(KNAMEMARGIN_LEFT);
        make.centerY.equalTo(_contactHeadImageView);
    }];
    
    _timeLabel = [YUtils initLabel:CONTENT_FONT(10) color:[UIColor blackColor] text:@"刚刚" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [_topView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contactNameLabel.mas_right).offset(KTIMEMARGIN_LEFT);
        make.top.equalTo(_contactNameLabel);
    }];
    
    _tagList = [[ConnectTag alloc] init];
    [_topView addSubview:_tagList];
    [_tagList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_topView);
        make.top.equalTo(_contactNameLabel);
    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_contactHeadImageView);
    }];
    
}


- (void)initMiddleView {
    _contentLabel = [YUtils initLabel:CONTENT_FONT(13)
                                color:[UIColor blackColor]
                                 text:@"o be, or not to be —that is the question, Whether'tis nobler in the mind to suffer. The slings and arrows of outrageous fortune Or to take arms against a sea of troubles, And by opposing end them. To die —to sleep"
                                frame:CGRectZero
                            alignment:NSTextAlignmentLeft];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_isOrganization) {
            make.left.equalTo(self.contentView).offset(KLEFTMARGIN);
            make.centerX.equalTo(self.contentView);
            make.top.mas_equalTo(KCONTENTMARGIN_TOP);
        } else {
            make.left.equalTo(_contactNameLabel);
            make.right.equalTo(_topView);
            make.top.equalTo(_topView.mas_bottom).offset(KCONTENTMARGIN_TOP);
        }
    }];
    
    _imgGroup = [[FeedImageGroup alloc] init];
    [self.contentView addSubview:_imgGroup];
    [_imgGroup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_contentLabel);
        make.top.equalTo(_contentLabel.mas_bottom).offset(KTAGMARGIN_TOP);
    }];
    if (!_isOrganization) {
        _tagIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:_tagIcon];
        [_tagIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCALE_NUM(11));
            make.height.mas_equalTo(SCALE_NUM(14));
            make.top.equalTo(_imgGroup.mas_bottom).offset(KTAGMICONARGIN_TOP);
            make.centerX.equalTo(_contactHeadImageView);
        }];
        
        _tagLabel = [YUtils initLabel:CONTENT_FONT(10) color:[UIColor blackColor] text:@"留学" frame:CGRectZero alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_tagLabel];
        [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_contentLabel);
            make.centerY.equalTo(_tagIcon);
        }];
        
        [self setIsRelated:false];
    }
    
}

- (void)initBottomView {
    UIView *bottomView = [[UIView alloc] init];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_isOrganization) {
            make.top.equalTo(_imgGroup.mas_bottom).offset(15);
            make.left.centerX.equalTo(_contentLabel);
        } else {
            make.top.equalTo(_tagLabel.mas_bottom).offset(15);
            make.left.centerX.equalTo(_topView);
        }
        make.bottom.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(KBOTTOMHEIGHT);
    }];
    
    _shareButton = [[UIImageView alloc] init];
    [bottomView addSubview:_shareButton];
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_isOrganization) {
            make.left.equalTo(_contentLabel);
        } else {
            make.centerX.equalTo(_contactHeadImageView);
        }
        make.top.centerY.equalTo(bottomView);
        make.width.mas_equalTo(KSHAREWIDTH);
    }];
    _shareButton.contentMode = UIViewContentModeCenter;
    _shareButton.image = [UIImage imageNamed:@"more"];
    _shareButton.userInteractionEnabled = true;
    [_shareButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openShare)]];
    
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
    commentImg.contentMode = UIViewContentModeCenter;
    commentImg.image = [UIImage imageNamed:@"comment"];
    
    _commentNum = [YUtils initLabel:CONTENT_FONT(10) color:[UIColor blackColor] text:@"50000" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [commentView addSubview:_commentNum];
    [_commentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(commentImg.mas_right).offset(KBUTTONTEXTMARGIN);
        make.top.bottom.right.equalTo(commentView);
    }];
    
    _respectNum = [YUtils initLabel:CONTENT_FONT(10) color:[UIColor blackColor] text:@"99" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [bottomView addSubview:_respectNum];
    [_respectNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(bottomView);
        make.width.mas_equalTo(SCALE_NUM(50));
    }];
    
    UIImageView *respectImg = [[UIImageView alloc] init];
    [bottomView addSubview:respectImg];
    [respectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_respectNum.mas_left).offset(-KBUTTONTEXTMARGIN);
        make.top.bottom.equalTo(bottomView);
        make.width.equalTo(commentImg);
    }];
    respectImg.contentMode = UIViewContentModeCenter;
    respectImg.image = [UIImage imageNamed:@"cup"];
    
    
}


- (void)setData
{
    _contentLabel.text = @"To be, or not to be —that is the question, Whether'tis nobler in the mind to suffer. The slings and arrows of outrageous fortune Or to take arms against a sea of troubles, And by opposing end them. To die —to sleep";
    [_imgGroup updateWithImgs:@[@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg"] bigPics:@[@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg"]];
    
    [_tagList updateTag:@[@"系",@"乡",@"班"]];
}

- (void)setIsRelated:(BOOL)isRelated {
    if (isRelated) {
        _tagIcon.image = [UIImage imageNamed:@"tag-green"];
        _tagLabel.textColor = KCOLORGREEN_179587;
    } else {
        _tagIcon.image = [UIImage imageNamed:@"tag-grey"];
        _tagLabel.textColor = [UIColor blackColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)openShare {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Push_FeedDetail object:@{@"id":@"233"}];
}

@end
