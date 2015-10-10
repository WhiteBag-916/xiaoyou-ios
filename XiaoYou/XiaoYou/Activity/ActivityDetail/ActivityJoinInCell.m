//
//  ActivityJoinInCell.m
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityJoinInCell.h"
#import "TagListView.h"
#import "TagsCommonView.h"

#define REUSEID @"joinincell"
#define kHeadCornerRadius                   22.5
#define kPaddingDistance                    12
#define kNameLabelWidth                     90
#define kLabelHeightDistacnce               14

@interface ActivityJoinInCell ()
////上面部分通用部分View
//@property (nonatomic,strong) UIImageView    *headImageView;
//@property (nonatomic,strong) UILabel        *nameLabel;
//@property (nonatomic,strong) UIImageView    *genderImageView;
//@property (nonatomic,strong) UIView         *detailInfoView;
@property (nonatomic,strong) TagListView *tagListView;
@property (nonatomic,strong) TagsCommonView * tagsCommonView;

@property (nonatomic,strong) UIImageView * headImageView;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UIImageView * sexImageView;
@property (nonatomic,strong) UIImageView * addFriendImageView;

@end

@implementation ActivityJoinInCell


+(ActivityJoinInCell *)cellWithTableView:(UITableView *)tableView
{
    ActivityJoinInCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEID];
    if (!cell) {
        cell = [[ActivityJoinInCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSEID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView {
//    _tagListView = [[TagListView alloc]init];
//    [self.contentView addSubview:_tagListView];
//    [_tagListView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.contentView);
//    }];

    //头像
    _headImageView = [[UIImageView alloc] init];
    _headImageView.userInteractionEnabled = YES;
    _headImageView.layer.cornerRadius = kHeadCornerRadius;
    _headImageView.clipsToBounds = YES;
    _headImageView.backgroundColor = [UIColor clearColor];
    [_headImageView setFaceImageWithUrl:nil];
    [self.contentView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(kPaddingDistance);
        make.width.height.mas_equalTo(45);
    }];
    
    //姓名
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = CONTENT_FONT(14);
    _nameLabel.text = @"还需要多多";
    _nameLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headImageView);
        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
        make.width.mas_equalTo(kNameLabelWidth);
        make.height.mas_equalTo(kLabelHeightDistacnce);
    }];
    
    //性别
    _sexImageView = [[UIImageView alloc] init];
    _sexImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_sexImageView];
    [_sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headImageView);
        make.left.equalTo(_nameLabel.mas_right).offset(kPaddingDistance);
        make.width.height.mas_equalTo(10);
    }];
    
    //加好友
    _addFriendImageView = [[UIImageView alloc] init];
    _addFriendImageView.backgroundColor = [UIColor redColor];
    _addFriendImageView.layer.cornerRadius = 15;
    _addFriendImageView.clipsToBounds = YES;
    [self.contentView addSubview:_addFriendImageView];
    [_addFriendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headImageView);
        make.right.equalTo(self.contentView.mas_right).offset(-kPaddingDistance);
        make.width.height.mas_equalTo(30);
    }];
    
    
    //标签
    _tagsCommonView = [[TagsCommonView alloc]initWithCollectionViewHeight:100 andModel:nil];
    [self.contentView addSubview:_tagsCommonView];
    [_tagsCommonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImageView.mas_bottom);
        make.left.equalTo(_nameLabel.mas_left);
        make.right.bottom.equalTo(self.contentView);
    }];
}

-(void)setCellInfo
{
    
}

@end
