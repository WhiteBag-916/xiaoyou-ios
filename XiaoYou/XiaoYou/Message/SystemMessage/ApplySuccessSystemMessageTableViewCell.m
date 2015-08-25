//
//  ApplySuccessSystemMessageTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ApplySuccessSystemMessageTableViewCell.h"

#define kHeadImageViewHeightAndWidth        40
#define kPaddingDistance                    5
#define kHeadCornerRadius                   20
#define kBackTopAndBottom                   10
#define kBackLeft                           20
#define kBackRight                          16
#define kChatButtonHeight                   20

NSString *const kApplySuccessSystemMessageTableViewCell = @"ApplySuccessSystemMessageTableViewCellId";

@interface ApplySuccessSystemMessageTableViewCell ()

@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)UIImageView * backImageView;
@property(nonatomic,strong)UILabel * contentLabel;
@property(nonatomic,strong)UIButton * chatButton;

@end

@implementation ApplySuccessSystemMessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = kHeadCornerRadius;
        _headImageView.clipsToBounds = YES;
        _headImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(3*kPaddingDistance);
            make.left.mas_equalTo(2*kPaddingDistance);
            make.width.height.mas_equalTo(kHeadImageViewHeightAndWidth);
        }];
        
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [[UIImage imageNamed:@"chat_receiver_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 24, 30, 24) resizingMode:UIImageResizingModeStretch];;
        [self.contentView addSubview:_backImageView];
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(3*kPaddingDistance);
            make.right.mas_equalTo(-4*kPaddingDistance);
            make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
            make.height.mas_equalTo(kHeadImageViewHeightAndWidth);
        }];
        
        _chatButton = [[UIButton alloc] init];
        [_chatButton setTitle:@"进入群聊" forState:UIControlStateNormal];
        _chatButton.layer.cornerRadius = 3;
        _chatButton.clipsToBounds = YES;
        _chatButton.titleLabel.font = CONTENT_FONT(12);
        _chatButton.tintColor = [UIColor whiteColor];
        [_chatButton setBackgroundImage:[UIImage imageNamed:@"contacts_bottom"] forState:UIControlStateNormal];
        [_chatButton addTarget:self action:@selector(tapChatButton) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_chatButton];
        [_chatButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-2*kPaddingDistance);
            make.height.mas_equalTo(kChatButtonHeight);
            make.left.mas_equalTo(_backImageView.mas_left).offset(4*kPaddingDistance);
            make.right.mas_equalTo(-6*kPaddingDistance);
        }];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = CONTENT_FONT(12);
        _contentLabel.backgroundColor = [UIColor clearColor];
        [_backImageView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kBackTopAndBottom);
            make.left.mas_equalTo(kBackLeft);
            make.height.mas_equalTo(kPaddingDistance*4);
            make.right.mas_equalTo(-kBackRight);
        }];
        
        
    }
    return self;
}

-(void)setCellInfo:(NSDictionary *) dic
{
    _contentLabel.text = dic[@"text"];
}

-(void)tapChatButton
{
    NSLog(@"进入群聊");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
