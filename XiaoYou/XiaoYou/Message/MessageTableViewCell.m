//
//  MessageTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "MessageTableViewCell.h"

NSString *const kMessageTableViewCell = @"MessageTableViewCellId";

@interface MessageTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgeView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;


@end

@implementation MessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.headImgeView.layer.cornerRadius = 20;
    self.headImgeView.backgroundColor = [UIColor orangeColor];
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
