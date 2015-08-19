//
//  ContactsTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ContactsTableViewCell.h"
#import "Masonry.h"
#import "YSystemDefine.h"
#import "UIImageView+WebCache.h"
#import "YUrlDefine.h"
#import "ConnectTag.h"

#define kHeadWidthAndHeight            40
#define kNameLabelWidth                80
#define kHeadCornerRadius              20
#define kFlagImageViewWidth            11
#define kFlagImageViewHeight           14
#define kPaddingDistance               10
#define kLabelHeightDistacnce          14
#define kClassLabelDistance            5
#define kClassLabelWidthAndHeight      30

NSString *const kContactsTableViewCell = @"ContactsTableViewCell";
@interface ContactsTableViewCell ()

@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UIImageView *flagImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *flagLabel;
@property (strong, nonatomic)  ConnectTag * connectTag;
@property (nonatomic,strong)  UILabel * defaultLabel;


@end

@implementation ContactsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = kHeadCornerRadius;
        _headImageView.clipsToBounds = YES;
        _headImageView.backgroundColor = [UIColor orangeColor];
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
        _nameLabel.backgroundColor = [UIColor magentaColor];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kPaddingDistance);
            make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
            make.width.mas_equalTo(kNameLabelWidth);
            make.height.mas_equalTo(kLabelHeightDistacnce);
        }];
        //标签图
        _flagImageView = [[UIImageView alloc] init];
        _flagImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_flagImageView];
        [_flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-kPaddingDistance);
            make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
            make.width.mas_equalTo(kFlagImageViewWidth);
            make.height.mas_equalTo(kFlagImageViewHeight);
        }];
        //标签
        _flagLabel = [[UILabel alloc] init];
        _flagLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_flagLabel];
        [_flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-kPaddingDistance);
            make.left.equalTo(_flagImageView.mas_right).offset(kPaddingDistance);
            make.right.mas_equalTo(-kPaddingDistance);
            make.height.mas_equalTo(kLabelHeightDistacnce);
        }];
        
        _connectTag = [[ConnectTag alloc] init];
        [self.contentView addSubview:_connectTag];
        [_connectTag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-kPaddingDistance);
            make.top.mas_equalTo(kPaddingDistance);
        }];
        
    }
    return self;
}


-(void)setCellInfo:(NSDictionary *) dic
{
    self.linkStudentNo = dic[@"linkStudentNo"];
    
    _nameLabel.text = dic[@"name"];
    NSString * flagString = [dic[@"flag"] stringByReplacingOccurrencesOfString:@"," withString:@" "];
    _flagLabel.text = flagString;
    self.flagImageView.image = [UIImage imageNamed:@"tag-green"];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",api_icon_base_url,dic[@"icon"]]] placeholderImage:[UIImage imageNamed:@"icon_default_mine"]];
    
    [_connectTag updateTag:@[@"班",@"社",@"系",@"团",@"啊"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
