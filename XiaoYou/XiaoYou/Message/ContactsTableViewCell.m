//
//  ContactsTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ContactsTableViewCell.h"

NSString *const kContactsTableViewCell = @"ContactsTableViewCell";
@interface ContactsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *flagLabel;


@end

@implementation ContactsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _headImageView.layer.cornerRadius = 20;
    _headImageView.backgroundColor = [UIColor orangeColor];
    _nameLabel.text = @"系统消息";
    _flagLabel.text = @"同班 老乡 话剧团";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
