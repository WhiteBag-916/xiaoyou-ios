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
#import "SKTagView.h"

#define kHeadWidthAndHeight            SCALE_NUM(40)
#define kNameLabelWidth                SCALE_NUM(120)
#define kHeadCornerRadius              SCALE_NUM(20)
#define kFlagImageViewWidth            SCALE_NUM(11)
#define kFlagImageViewHeight           SCALE_NUM(14)
#define kPaddingDistance               SCALE_NUM(10)
#define kLabelHeightDistacnce          SCALE_NUM(14)
#define kClassLabelDistance            SCALE_NUM(5)
#define kClassLabelWidthAndHeight      SCALE_NUM(30)
#define kRemindImageViewWidth          SCALE_NUM(13)
#define kRemindImageViewHeight         SCALE_NUM(15)
#define kBottomLineHeight              SCALE_NUM(0.4)
#define kFlagLabelToHead               SCALE_NUM(14)


NSString *const kContactsTableViewCell = @"ContactsTableViewCell";
@interface ContactsTableViewCell ()

@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UIImageView *flagImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *flagLabel;
@property (strong, nonatomic)  ConnectTag * connectTag;
@property (nonatomic,strong)  UILabel * defaultLabel;
@property (nonatomic,strong) UIImageView * remindImageView;
@property (nonatomic, strong) SKTagView *tagContent;

@end

@implementation ContactsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    self.contentView.backgroundColor = [UIColor clearColor];
    
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
    //
    _tagContent = [[SKTagView alloc] init];
    _tagContent.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_tagContent];
    [_tagContent mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_nameLabel.mas_bottom).offset(kFlagLabelToHead);
        make.centerY.equalTo(_flagImageView);
        make.left.equalTo(_flagImageView.mas_right).offset(kPaddingDistance);
        make.right.equalTo(self.contentView.mas_right).offset(-3*kPaddingDistance);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kPaddingDistance);
    }];
    _tagContent.maxLines = 1;
    _tagContent.clipsToBounds = true;
    _tagContent.insets = 21;
    _tagContent.lineSpace = -5;
    _tagContent.singleLine = false;
    _tagContent.preferredMaxLayoutWidth = SCALE_NUM(240);
    
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
        make.right.equalTo(self.contentView).offset(-kPaddingDistance);
        make.top.equalTo(self.contentView).offset(kPaddingDistance);
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

-(void)setCellInfo:(id) dic
{
    NSDictionary * modelDic = [dic dictionaryRepresentation];
    
    _headImageView.image = nil;
    _defaultLabel.text = @"";
    
    _studentDic = modelDic;
    
    //昵称
    _nameLabel.text = modelDic[@"name"];
    
    //标签
    BOOL hasRelate = false;
    [_tagContent removeAllTags];
    NSArray * tagsArr = modelDic[@"tagsCommon"];
    for (int i = 0; i < tagsArr.count; i++) {
        Tags * tempTag = [[Tags alloc]initWithDictionary:tagsArr[i]];
        BOOL isRelate = [tempTag equal];
        hasRelate |= isRelate;
        SKTag *tag = [SKTag tagWithText:[tempTag name]];
        tag.font = CONTENT_FONT(10);
        if (isRelate) {
            tag.textColor = KCOLOR_009688;
        } else {
            tag.textColor = KCOLORWHITE_696969;
        }
        [_tagContent addTag:tag];
    }
    [self setIsRelated:hasRelate];
    
    //头像
    if ([modelDic[@"icon"] isEqualToString:@""]) {
        if ([[modelDic[@"linkType"] stringValue] isEqualToString:@"2"])
        {
            _headImageView.backgroundColor = KCOLOR_009688;
            _defaultLabel.text = [modelDic[@"name"] substringWithRange:NSMakeRange(0, 1)];
        }
        else
        {
            _headImageView.image = [UIImage imageNamed:@"default_head"];

        }
        
    }
    else
    {
        [_headImageView setFaceImageWithUrl:modelDic[@"icon"]];

    }
    
    //共同标签
    NSArray * propetiesArr = modelDic[@"propetiesCommon"];
    NSMutableArray * propetiesCommonArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < propetiesArr.count; i++)
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

#pragma mark - 设置标签图标变色
- (void)setIsRelated:(BOOL)isRelated {
    if (isRelated) {
        _flagImageView.image = [UIImage imageNamed:@"tag-green"];
    } else {
        _flagImageView.image = [UIImage imageNamed:@"tag-grey"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
