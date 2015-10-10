//
//  ContactsInfoFirstTableViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ContactsInfoFirstTableViewCell.h"

NSString *const kContactsInfoFirstTableViewCell = @"ContactsInfoFirstTableViewCellId";

@interface ContactsInfoFirstTableViewCell ()

@property(nonatomic,strong) UILabel * statesLabel;

@end

@implementation ContactsInfoFirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    _statesLabel = [[UILabel alloc] init];
    _statesLabel.font= CONTENT_FONT(12);
    _statesLabel.numberOfLines = 0;
    _statesLabel.textAlignment = NSTextAlignmentLeft;
    _statesLabel.textColor = [UIColor hexChangeFloat:@"666666"];
    [self.contentView addSubview:_statesLabel];
    [_statesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.contentView);
        make.right.mas_equalTo(-12);
        make.left.mas_equalTo(70);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellInfo:(ProfileInfo *) model
{
    _statesLabel.text = model.selfIntro;
}

@end
