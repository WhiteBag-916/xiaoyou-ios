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

NSString *const kMessageTableViewCell = @"MessageTableViewCellId";

@interface MessageTableViewCell ()

@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *badgeNumberLabel;
@property (strong, nonatomic)  UILabel *timeLabel;
@property (strong, nonatomic)  UILabel *messageLabel;


@end

@implementation MessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = 20;
        _headImageView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        //姓名
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor magentaColor];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(60);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
        //消息数
        _badgeNumberLabel = [[UILabel alloc] init];
        _badgeNumberLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_badgeNumberLabel];
        [_badgeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(150);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
        //时间
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        //消息
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_messageLabel];
        [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(60);
            make.right.equalTo(self.contentView).offset(-100);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

-(void)setCellInfo
{
    self.nameLabel.text = @"系统消息";
    self.badgeNumberLabel.text = @"99";
    self.timeLabel.text = @"10:29";
    self.messageLabel.text = @"新生报到通知";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
