//
//  MessageTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "Masonry.h"
#import "YSystemDefine.h"

#define kHeadWidthAndHeight            40
#define kNameLabelWidth                80
#define kTimeLabelWidth                60
#define kHeadCornerRadius              20
#define kPaddingDistance               10
#define kLabelHeightDistacnce          14
#define kBadgeWidthDistance            21
#define kClassLabelDistance            5
#define kClassLabelWidthAndHeight      30

NSString *const kMessageTableViewCell = @"MessageTableViewCellId";

@interface MessageTableViewCell ()

@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *badgeNumberLabel;
@property (strong, nonatomic)  UILabel *timeLabel;
@property (strong, nonatomic)  UILabel *messageLabel;
@property (nonatomic,strong)  UILabel * defaultLabel;


@end

@implementation MessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = kHeadCornerRadius;
        _headImageView.clipsToBounds = YES;
        _headImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(kPaddingDistance);
            make.width.height.mas_equalTo(kHeadWidthAndHeight);
        }];
        //班
        _defaultLabel = [[UILabel alloc] init];
        _defaultLabel.textAlignment = NSTextAlignmentCenter;
        _defaultLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_defaultLabel];
        [_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headImageView.mas_top).offset(kClassLabelDistance);
            make.left.mas_equalTo(_headImageView.mas_left).offset(kClassLabelDistance);
            make.width.height.mas_equalTo(kClassLabelWidthAndHeight);
        }];
        //姓名
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kPaddingDistance);
            make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
            make.width.mas_equalTo(kNameLabelWidth);
            make.height.mas_equalTo(kLabelHeightDistacnce);
        }];
        //消息数
        _badgeNumberLabel = [[UILabel alloc] init];
        _badgeNumberLabel.textAlignment = NSTextAlignmentCenter;
        _badgeNumberLabel.backgroundColor = [UIColor hexChangeFloat:@"258f74"];
        [self.contentView addSubview:_badgeNumberLabel];
        [_badgeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-kPaddingDistance);
            make.right.equalTo(self.contentView).offset(-kPaddingDistance);
            make.height.mas_equalTo(kLabelHeightDistacnce);
            make.width.mas_equalTo(kBadgeWidthDistance);
        }];
        //时间
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kPaddingDistance);
            make.right.mas_equalTo(-kPaddingDistance); 
            make.width.mas_equalTo(kTimeLabelWidth);
            make.height.mas_equalTo(kLabelHeightDistacnce);
        }];
        //消息
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_messageLabel];
        [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-kPaddingDistance);
            make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
            make.right.equalTo(_badgeNumberLabel.mas_left).offset(-kPaddingDistance);
            make.height.mas_equalTo(kLabelHeightDistacnce);
        }];
    }
    return self;
}

-(void)setCellInfo:(NSDictionary *) dic
{
    if ([dic[@"type"] isEqualToString:@"1"])
    {
        self.headImageView.image = [UIImage imageNamed:@"friend-requests"];
        self.headImageView.clipsToBounds = NO;
        self.nameLabel.text = @"好友申请";
        self.badgeNumberLabel.text = @"";
        self.timeLabel.text = @"10:29";
        self.messageLabel.text = @"小红想添加你为好友";
    }
    else if ([dic[@"type"] isEqualToString:@"2"])
    {
        self.nameLabel.text = @"网球社";
        self.badgeNumberLabel.text = @"";
        self.timeLabel.text = @"10:29";
        self.messageLabel.text = @"动次打次";
        self.headImageView.image = nil;
        self.headImageView.backgroundColor = [UIColor hexChangeFloat:@"258f74"];
        self.defaultLabel.text = @"社";
    }
    else
    {
        self.headImageView.image = [UIImage imageNamed:@"default_head"];
        self.nameLabel.text = @"山本伊朗";
        self.badgeNumberLabel.text = @"99";
        self.timeLabel.text = @"10:29";
        self.messageLabel.text = @"新生报到通知";
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
