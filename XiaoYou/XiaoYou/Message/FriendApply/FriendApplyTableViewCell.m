//
//  FriendApplyTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FriendApplyTableViewCell.h"
#import "ConnectTag.h"
#import "Author.h"
#import "SKTagView.h"
#import "Tags.h"
#import "ContactManager.h"
#import "YUtils+HUD.h"
#import "ApplicantList.h"

#define kHeadCornerRadius              22.5
#define kPaddingDistance               12
#define kHeadImageWidthAndHeight       45
#define kNameWidth                     90
#define kNameHeight                    20
#define kDetailButtonHeight            14
#define kSexHeightAndWidth             20
#define kInfoLabelToNameLabel          20
#define kFlagImageViewWidth            11
#define kFlagImageViewHeight           14
#define kFlagImageViewToHead           33
#define kFlagLabelToHead               23
NSString *const kFriendApplyTableViewCell = @"FriendApplyTableViewCellId";

typedef enum : NSUInteger {
    BIG_BUTTON,
    IGNORE_BUTTON,
    OK_BUTTON,
} BOTTOM_BUTTON_TYPE;

@interface FriendApplyTableViewCell ()

@property(nonatomic,strong) UIImageView * headImageView;
@property(nonatomic,strong) UILabel * nameLabel;
@property(nonatomic,strong) UILabel * sexLabel;
@property(nonatomic,strong) UIButton * detailButton;
@property(nonatomic,strong) UILabel * infoLabel;
@property (nonatomic, strong) SKTagView *tagContent;                   //tag标签
@property(nonatomic,strong) UIImageView * flagImageView;

@property(nonatomic,strong) UIButton * afterDealButton;
@property(nonatomic,strong) UIButton * ignoreButton;
@property(nonatomic,strong) UIButton * confirmButton;

@property (strong, nonatomic)  ConnectTag * connectTag;

@property (nonatomic, weak) ApplicantList *applicantList;

@end

@implementation FriendApplyTableViewCell

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
        [self.contentView addSubview:_sexLabel];
        [_sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kPaddingDistance);
            make.left.equalTo(_nameLabel.mas_right).offset(kPaddingDistance);
            make.width.height.mas_equalTo(kSexHeightAndWidth);
        }];
        
        
        //标签
        _connectTag = [[ConnectTag alloc] init];
        [self.contentView addSubview:_connectTag];
        [_connectTag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-kPaddingDistance);
            make.top.mas_equalTo(kPaddingDistance);
//            make.left.equalTo(_sexLabel.mas_right).offset(kPaddingDistance);
            make.height.mas_equalTo(kDetailButtonHeight);
        }];
//        [_connectTag updateTag:@[@"班",@"社",@"系",@"团",@"啊"]];
        
        //院系信息
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.font = CONTENT_FONT(12);
        _infoLabel.text = @"计算机与控制工程学院     15级";
        _infoLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_infoLabel];
        [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel);
            make.top.equalTo(_nameLabel.mas_bottom).offset(kInfoLabelToNameLabel);
            make.height.mas_equalTo(kNameHeight);
            make.right.equalTo(self.contentView.mas_right).offset(-kPaddingDistance);
        }];
        
        //自选标签
        _flagImageView = [[UIImageView alloc] init];
        _flagImageView.image = [UIImage imageNamed:@"tag-green"];
        [self.contentView addSubview:_flagImageView];
        [_flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_headImageView.mas_centerX);
            make.top.equalTo(_headImageView.mas_bottom).offset(kFlagImageViewToHead);
            make.width.mas_equalTo(kFlagImageViewWidth);
            make.height.mas_equalTo(kFlagImageViewHeight);
        }];
        
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
        _afterDealButton.backgroundColor = KCOLORGREEN_009688;
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
        
        //忽略
        _ignoreButton = [[UIButton alloc] init];
        _ignoreButton.titleLabel.font = CONTENT_FONT(14);
        _ignoreButton.tag = IGNORE_BUTTON;
        _ignoreButton.backgroundColor = [UIColor hexChangeFloat:@"76a5ad"];
        [_ignoreButton setTitle:@"忽略" forState:UIControlStateNormal];
        [_ignoreButton addTarget:self action:@selector(clickDealButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_ignoreButton];
        [_ignoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kPaddingDistance);
            make.width.mas_equalTo((SCREEN_WIDTH - kPaddingDistance*3)/2);
            make.top.equalTo(_tagContent.mas_bottom).offset(kPaddingDistance);
            make.bottom.mas_equalTo(-kPaddingDistance);
        }];
        //好啊
        _confirmButton = [[UIButton alloc] init];
        _confirmButton.titleLabel.font = CONTENT_FONT(14);
        _confirmButton.tag = OK_BUTTON;
        _confirmButton.backgroundColor = KCOLORGREEN_009688;
        [_confirmButton setTitle:@"好啊" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(clickDealButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_confirmButton];
        [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-kPaddingDistance);
            make.width.mas_equalTo((SCREEN_WIDTH - kPaddingDistance*3)/2);
            make.top.equalTo(_tagContent.mas_bottom).offset(kPaddingDistance);
            make.bottom.mas_equalTo(-kPaddingDistance);
        }];
        
        //line
        UIView *line = [[UIView alloc] init];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.contentView);
            make.height.mas_equalTo(1);
        }];
        line.backgroundColor = KCOLORGREEN_e6ebea;
    }
    return self;
}

-(void)setCellInfo:(ApplicantList *) model
{
    _applicantList = model;
    
    [_headImageView setFaceImageWithUrl:_applicantList.author.headPic];
    _nameLabel.text = _applicantList.author.name;
    _sexLabel.text = _applicantList.author.gender;
    if (_applicantList.author.tagsCommon.count == 0) {
        _flagImageView.hidden = true;
    } else {
        _flagImageView.hidden = false;
        
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
    [_connectTag updateWithTag:_applicantList.author.propetiesCommon];
}

//更新buttonshow
- (void)updateButtonShow {
    if (0 == _applicantList.status) {
        //未处理
        _afterDealButton.hidden = YES;
        _ignoreButton.hidden = NO;
        _confirmButton.hidden = NO;
    } else if (1 == _applicantList.status) {
        //已同意
        _afterDealButton.hidden = NO;
        [_afterDealButton setTitle:@"聊聊呗" forState:UIControlStateNormal];
        _afterDealButton.backgroundColor = KCOLORGREEN_009688;
        _afterDealButton.userInteractionEnabled = YES;
        _ignoreButton.hidden = YES;
        _confirmButton.hidden = YES;
    } else if (2 == _applicantList.status) {
        //拒绝
//        _afterDealButton.hidden = NO;
//        [_afterDealButton setTitle:@"已拒绝" forState:UIControlStateNormal];
//        _afterDealButton.backgroundColor = [UIColor hexChangeFloat:@"c0c5cb"];
//        _afterDealButton.userInteractionEnabled = NO;
//        _ignoreButton.hidden = YES;
//        _confirmButton.hidden = YES;
    } else if (3 == _applicantList.status) {
        //忽略
        _afterDealButton.hidden = NO;
        [_afterDealButton setTitle:@"已忽略" forState:UIControlStateNormal];
        _afterDealButton.backgroundColor = [UIColor hexChangeFloat:@"c0c5cb"];
        _afterDealButton.userInteractionEnabled = NO;
        _ignoreButton.hidden = YES;
        _confirmButton.hidden = YES;
    }
}

-(void)clickDealButton:(UIButton *) button
{
    switch (button.tag) {
        case BIG_BUTTON:
        {
            [self toChat];
            break;
        }
        case IGNORE_BUTTON:
        {
            [[ContactManager sharedInstance] ignoreFriendApply:_applicantList.applyId block:^(YActionMessage *message) {
                if (message.isSuccess) {
                    _applicantList.status = 3;
                    [self updateButtonShow];
                } else {
                    [YUtils showTitle:message.desc];
                }
            }];
            break;
        }
        case OK_BUTTON:
        {
            [[ContactManager sharedInstance] rejectApply:_applicantList.applyId block:^(YActionMessage *message) {
                if (message.isSuccess) {
                    _applicantList.status = 1;
                    [self updateButtonShow];
                } else {
                    [YUtils showTitle:message.desc];
                }
            }];
            break;
        }
            
        default:
            break;
    }
    
}

- (void)toChat {
}

- (void)setIsRelated:(BOOL)isRelated {
    if (isRelated) {
        _flagImageView.image = [UIImage imageNamed:@"tag-green"];
    } else {
        _flagImageView.image = [UIImage imageNamed:@"tag-grey"];
    }
}

@end
