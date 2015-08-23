//
//  FriendApplyTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FriendApplyTableViewCell.h"
#import "ConnectTag.h"

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
@property(nonatomic,strong) UILabel * flagLabel;
@property(nonatomic,strong) UIImageView * flagImageView;

@property(nonatomic,strong) UIButton * afterDealButton;
@property(nonatomic,strong) UIButton * ignoreButton;
@property(nonatomic,strong) UIButton * confirmButton;

@property (strong, nonatomic)  ConnectTag * connectTag;

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
        _flagImageView.image = [UIImage imageNamed:@"tag-green"];
        [self.contentView addSubview:_flagImageView];
        [_flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_headImageView.mas_centerX);
            make.top.equalTo(_headImageView.mas_bottom).offset(kFlagImageViewToHead);
            make.width.mas_equalTo(kFlagImageViewWidth);
            make.height.mas_equalTo(kFlagImageViewHeight);
        }];
        
        //标签内容
        _flagLabel = [[UILabel alloc] init];
        _flagLabel.font = CONTENT_FONT(11);
        _flagLabel.backgroundColor = [UIColor whiteColor];
        _flagLabel.numberOfLines = 0;
        _flagLabel.text = @"互联网就业 留学陶瓷 网球社 互联网就业 留学陶瓷 网球社 互联网就业 留学陶瓷 网球社 ";
        [self.contentView addSubview:_flagLabel];
        [_flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headImageView.mas_bottom).offset(kFlagLabelToHead);
            make.left.equalTo(_nameLabel.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(-kPaddingDistance);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-53);
        }];
        
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
            make.top.equalTo(_flagLabel.mas_bottom).offset(kPaddingDistance);
            make.bottom.mas_equalTo(-kPaddingDistance);
        }];
        _afterDealButton.hidden = YES;
        
        //忽略
        _ignoreButton = [[UIButton alloc] init];
        _ignoreButton.titleLabel.font = CONTENT_FONT(14);
        _ignoreButton.tag = IGNORE_BUTTON;
        [_ignoreButton setBackgroundImage:[UIImage imageNamed:@"contacts_bottom"] forState:UIControlStateNormal];
        [_ignoreButton setTitle:@"忽略" forState:UIControlStateNormal];
        [_ignoreButton addTarget:self action:@selector(clickDealButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_ignoreButton];
        [_ignoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kPaddingDistance);
            make.width.mas_equalTo((SCREEN_WIDTH - kPaddingDistance*3)/2);
            make.top.equalTo(_flagLabel.mas_bottom).offset(kPaddingDistance);
            make.bottom.mas_equalTo(-kPaddingDistance);
        }];
        //好啊
        _confirmButton = [[UIButton alloc] init];
        _confirmButton.titleLabel.font = CONTENT_FONT(14);
        _confirmButton.tag = OK_BUTTON;
        [_confirmButton setBackgroundImage:[UIImage imageNamed:@"contacts_bottom"] forState:UIControlStateNormal];
        [_confirmButton setTitle:@"好啊" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(clickDealButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_confirmButton];
        [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-kPaddingDistance);
            make.width.mas_equalTo((SCREEN_WIDTH - kPaddingDistance*3)/2);
            make.top.equalTo(_flagLabel.mas_bottom).offset(kPaddingDistance);
            make.bottom.mas_equalTo(-kPaddingDistance);
        }];
    }
    return self;
}

-(void)setCellInfo:(NSDictionary *) dic
{

}

-(void)clickDealButton:(UIButton *) button
{
    switch (button.tag) {
        case BIG_BUTTON:
            NSLog(@"聊聊呗");
            break;
        case IGNORE_BUTTON:
            NSLog(@"忽略");
            break;
        case OK_BUTTON:
            NSLog(@"好啊");
            break;
            
        default:
            break;
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
