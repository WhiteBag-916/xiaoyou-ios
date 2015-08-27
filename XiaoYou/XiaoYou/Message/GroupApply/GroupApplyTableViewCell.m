//
//  GroupApplyTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "GroupApplyTableViewCell.h"
#import "ConnectTag.h"
#import "ApplicantList.h"
#import "Author.h"
#import "SKTagView.h"
#import "Tags.h"

#define kHeadCornerRadius              22.5
#define kPaddingDistance               12
#define kHeadImageWidthAndHeight       45
#define kNameWidth                     90
#define kNameHeight                    20
#define kDetailButtonHeight            14
#define kSexHeightAndWidth             30
#define kInfoLabelToNameLabel          20
#define kFlagImageViewWidth            11
#define kFlagImageViewHeight           14
#define kFlagImageViewToHead           33
#define kFlagLabelToHead               23


NSString *const kGroupApplyTableViewCell = @"GroupApplyTableViewCellId";

@interface GroupApplyTableViewCell ()

@property(nonatomic,strong) UIImageView * headImageView;
@property(nonatomic,strong) UILabel * nameLabel;
@property(nonatomic,strong) UILabel * sexLabel;
@property(nonatomic,strong) UIButton * detailButton;
@property(nonatomic,strong) UILabel * infoLabel;
@property (nonatomic, strong) SKTagView *tagContent;                   //tag标签
@property(nonatomic,strong) UIImageView * flagImageView;

@property(nonatomic,strong) UIButton * afterDealButton;
@property(nonatomic,strong) UIButton * refuseButton;
@property(nonatomic,strong) UIButton * passButton;
@property(nonatomic,strong) UIButton * sendButton;

@property (nonatomic, weak) ApplicantList *applicantList;

@end

@implementation GroupApplyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //头像
        _headImageView = [[UIImageView alloc] init];
        _headImageView.backgroundColor = [UIColor clearColor];
        _headImageView.layer.cornerRadius = kHeadCornerRadius;
        _headImageView.clipsToBounds = YES;
        _headImageView.image = [UIImage imageNamed:@"default_head"];
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(kPaddingDistance);
            make.width.height.mas_equalTo(kHeadImageWidthAndHeight);
        }];
        
        //昵称
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = CONTENT_FONT(14);
        _nameLabel.backgroundColor = [UIColor whiteColor];
        _nameLabel.text = @"斯提尔伯格";
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kPaddingDistance);
            make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
            make.width.mas_equalTo(kNameWidth);
            make.height.mas_equalTo(kNameHeight);
        }];
        
        //性别
        _sexLabel = [[UILabel alloc] init];
        _sexLabel.font = CONTENT_FONT(14);
        _sexLabel.backgroundColor = [UIColor whiteColor];
        _sexLabel.text = @"男";
        [self.contentView addSubview:_sexLabel];
        [_sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kPaddingDistance);
            make.left.equalTo(_nameLabel.mas_right).offset(kPaddingDistance);
            make.width.height.mas_equalTo(kSexHeightAndWidth);
        }];
        
        //院系信息
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.font = CONTENT_FONT(12);
        _infoLabel.backgroundColor = [UIColor whiteColor];
        _infoLabel.text = @"计算机与控制工程学院     15级";
        [self.contentView addSubview:_infoLabel];
        [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel);
            make.top.equalTo(_nameLabel.mas_bottom).offset(kInfoLabelToNameLabel);
            make.height.mas_equalTo(kNameHeight);
            make.right.equalTo(self.contentView.mas_right).offset(-kPaddingDistance);
        }];
        
        //自选标签
        _flagImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_flagImageView];
        [_flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_headImageView.mas_centerX);
            make.top.equalTo(_headImageView.mas_bottom).offset(kFlagImageViewToHead);
            make.width.mas_equalTo(kFlagImageViewWidth);
            make.height.mas_equalTo(kFlagImageViewHeight);
        }];
        
        [self setIsRelated:YES];
        
        _tagContent = [[SKTagView alloc] init];
        [self addSubview:_tagContent];
        [_tagContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headImageView.mas_bottom).offset(kFlagLabelToHead);
            make.left.equalTo(_nameLabel.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(-kPaddingDistance);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-53);
        }];
        _tagContent.insets = 21;
        _tagContent.lineSpace = 0;
        _tagContent.singleLine = false;
        _tagContent.preferredMaxLayoutWidth = SCALE_NUM(230);
        
        //大Button
        _afterDealButton = [[UIButton alloc] init];
        _afterDealButton.titleLabel.font = CONTENT_FONT(14);
        _afterDealButton.tag = BIG_BUTTON;
        [_afterDealButton setBackgroundImage:[UIImage imageNamed:@"contacts_bottom"] forState:UIControlStateNormal];
        [_afterDealButton setTitle:@"聊聊呗" forState:UIControlStateNormal];
        [_afterDealButton addTarget:self action:@selector(clickDealButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_afterDealButton];
        [_afterDealButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kPaddingDistance);
            make.right.mas_equalTo(-kPaddingDistance);
            make.top.equalTo(_tagContent.mas_bottom).offset(kPaddingDistance);
            make.bottom.mas_equalTo(-kPaddingDistance);
        }];
        _afterDealButton.hidden = YES;
        
        //拒绝
        _refuseButton = [[UIButton alloc] init];
        _refuseButton.titleLabel.font = CONTENT_FONT(14);
        _refuseButton.tag = REFUSE_BUTTON;
        [_refuseButton setBackgroundImage:[UIImage imageNamed:@"contacts_bottom"] forState:UIControlStateNormal];
        [_refuseButton setTitle:@"拒绝" forState:UIControlStateNormal];
        [_refuseButton addTarget:self action:@selector(clickDealButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_refuseButton];
        [_refuseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kPaddingDistance);
            make.width.mas_equalTo((SCREEN_WIDTH - kPaddingDistance*4)/3);
            make.top.equalTo(_tagContent.mas_bottom).offset(kPaddingDistance);
            make.bottom.mas_equalTo(-kPaddingDistance);
        }];
        //通过
        _passButton = [[UIButton alloc] init];
        _passButton.titleLabel.font = CONTENT_FONT(14);
        _passButton.tag = PASS_BUTTON;
        [_passButton setBackgroundImage:[UIImage imageNamed:@"contacts_bottom"] forState:UIControlStateNormal];
        [_passButton setTitle:@"通过" forState:UIControlStateNormal];
        [_passButton addTarget:self action:@selector(clickDealButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_passButton];
        [_passButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.width.mas_equalTo((SCREEN_WIDTH - kPaddingDistance*4)/3);
            make.top.equalTo(_tagContent.mas_bottom).offset(kPaddingDistance);
            make.bottom.mas_equalTo(-kPaddingDistance);
        }];
        //发信
        _sendButton = [[UIButton alloc] init];
        _sendButton.titleLabel.font = CONTENT_FONT(14);
        _sendButton.tag = SEND_BUTTON;
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"contacts_bottom"] forState:UIControlStateNormal];
        [_sendButton setTitle:@"发信" forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(clickDealButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_sendButton];
        [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-kPaddingDistance);
            make.width.mas_equalTo((SCREEN_WIDTH - kPaddingDistance*4)/3);
            make.top.equalTo(_tagContent.mas_bottom).offset(kPaddingDistance);
            make.bottom.mas_equalTo(-kPaddingDistance);
        }];
    }
    return self;
}

-(void)setCellInfo:(ApplicantList *)applicantList
{
    _applicantList = applicantList;
    
    [_headImageView setFaceImageWithUrl:_applicantList.author.headPic];
    _nameLabel.text = _applicantList.author.name;
    _sexLabel.text = _applicantList.author.gender;
    
    BOOL hasRelate = false;
    for (int i = 0; i < _applicantList.author.tagsCommon.count; i++) {
        BOOL isRelate = [_applicantList.author.tagsCommon[i] equal];
        hasRelate |= isRelate;
        SKTag *tag = [SKTag tagWithText:[_applicantList.author.tagsCommon[i] name]];
        tag.font = CONTENT_FONT(10);
        if (isRelate) {
            tag.textColor = KCOLORGREEN_009688;
        } else {
            tag.textColor = KCOLORWHITE_696969;
        }
        [_tagContent addTag:tag];
    }
    [self setIsRelated:hasRelate];
    
    
}


//更新buttonshow
- (void)updateButtonShow {
    if (0 == _applicantList.status) {
        //未处理
    } else if (1 == _applicantList.status) {
        //已同意
    }
}

-(void)clickDealButton:(UIButton *) button
{
    switch (button.tag) {
        case BIG_BUTTON:
            NSLog(@"聊聊呗");
            break;
        case REFUSE_BUTTON:
            NSLog(@"拒绝");
            break;
        case PASS_BUTTON:
            NSLog(@"通过");
            break;
        case SEND_BUTTON:
            NSLog(@"发信");
            break;
            
        default:
            break;
    }
}

- (void)setIsRelated:(BOOL)isRelated {
    if (isRelated) {
        _flagImageView.image = [UIImage imageNamed:@"tag-green"];
    } else {
        _flagImageView.image = [UIImage imageNamed:@"tag-grey"];
    }
}

@end
