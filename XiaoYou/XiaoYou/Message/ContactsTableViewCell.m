//
//  ContactsTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ContactsTableViewCell.h"
#import "Masonry.h"

NSString *const kContactsTableViewCell = @"ContactsTableViewCell";
@interface ContactsTableViewCell ()

@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *flagLabel;


@end

@implementation ContactsTableViewCell

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
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        //标签
        _flagLabel = [[UILabel alloc] init];
        _flagLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_flagLabel];
        [_flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}


-(void)setCellInfo
{
    _nameLabel.text = @"系统消息";
    _flagLabel.text = @"同班 老乡 话剧团";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
