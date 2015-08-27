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
#import "Tags.h"
#import "ProvisionManager.h"
#import "ProfileInfo.h"

#define kHeadWidthAndHeight            40
#define kNameLabelWidth                120
#define kHeadCornerRadius              20
#define kFlagImageViewWidth            11
#define kFlagImageViewHeight           14
#define kPaddingDistance               10
#define kLabelHeightDistacnce          14
#define kClassLabelDistance            5
#define kClassLabelWidthAndHeight      30
#define kRemindImageViewWidth          13
#define kRemindImageViewHeight         15
#define kBottomLineHeight              0.4


NSString *const kContactsTableViewCell = @"ContactsTableViewCell";
@interface ContactsTableViewCell ()

@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UIImageView *flagImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *flagLabel;
@property (strong, nonatomic)  ConnectTag * connectTag;
@property (nonatomic,strong)  UILabel * defaultLabel;
@property (nonatomic,strong) UIImageView * remindImageView;


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
        _headImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(kPaddingDistance);
            make.width.height.mas_equalTo(kHeadWidthAndHeight);
        }];
        //班
        _defaultLabel = [[UILabel alloc] init];
        _defaultLabel.textAlignment = NSTextAlignmentCenter;
        _defaultLabel.textColor = [UIColor clearColor];
        [self.contentView addSubview:_defaultLabel];
        [_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headImageView.mas_top).offset(kClassLabelDistance);
            make.left.mas_equalTo(_headImageView.mas_left).offset(kClassLabelDistance);
            make.width.height.mas_equalTo(kClassLabelWidthAndHeight);
        }];
        //姓名
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = CONTENT_FONT(14);
        _nameLabel.backgroundColor = [UIColor clearColor];
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
        _flagLabel.font = CONTENT_FONT(11);
        _flagLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_flagLabel];
        [_flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-kPaddingDistance);
            make.left.equalTo(_flagImageView.mas_right).offset(kPaddingDistance);
            make.right.mas_equalTo(-kPaddingDistance);
            make.height.mas_equalTo(kLabelHeightDistacnce);
        }];
        //提醒
        _remindImageView = [[UIImageView alloc] init];
        _remindImageView.image = [UIImage imageNamed:@"chat_remindnot"];
        [self.contentView addSubview:_remindImageView];
        [_remindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-kPaddingDistance);
            make.right.mas_equalTo(-kPaddingDistance);
            make.height.mas_equalTo(kRemindImageViewHeight);
            make.width.mas_equalTo(kRemindImageViewWidth);
        }];
        
        _connectTag = [[ConnectTag alloc] init];
        [self.contentView addSubview:_connectTag];
        [_connectTag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-kPaddingDistance);
            make.top.mas_equalTo(kPaddingDistance);
        }];
        
        UIView * bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor grayColor];
        bottomView.alpha = 0.6;
        [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(kBottomLineHeight);
        }];
        
    }
    return self;
}


-(void)setCellInfo:(id) dic
{
    NSDictionary * modelDic = [dic dictionaryRepresentation];
    
    _studentDic = modelDic;
    
    //昵称
    _nameLabel.text = modelDic[@"name"];
    
    //标签
    NSString * flagString = [modelDic[@"tags"] stringByReplacingOccurrencesOfString:@"," withString:@" "];
    _flagLabel.text = flagString;
    _flagImageView.image = [UIImage imageNamed:@"tag-green"];
    
    //头像
    if ([modelDic[@"icon"] isEqualToString:@""]) {
        _headImageView.image = [UIImage imageNamed:@"default_head"];
    }
    else
    {
        [_headImageView setFaceImageWithUrl:modelDic[@"icon"]];

    }
    
    //共同标签
    NSArray * tagsArr = modelDic[@"propetiesCommon"];
    NSMutableArray * propetiesCommonArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < tagsArr.count; i++)
    {
        [propetiesCommonArr addObject:[[Tags alloc]initWithDictionary:modelDic[@"propetiesCommon"][i]]];
    }
    [_connectTag updateWithTag:propetiesCommonArr];
    
    //消息提醒
    if ([modelDic[@"isRemind"] isEqualToString:@"y"])
    {
        _remindImageView.hidden = YES;
    }
    else
    {
        _remindImageView.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
