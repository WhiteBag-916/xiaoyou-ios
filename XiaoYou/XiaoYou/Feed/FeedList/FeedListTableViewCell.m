//
//  FeedListTableViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/12.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedListTableViewCell.h"
#import "YUtils+Component.h"
#import "Masonry.h"
#import "FeedImageGroup.h"
#import "ConnectTag.h"
#import "FeedCellTopView.h"
#import "FeedCellMiddleView.h"
#import "FeedCellBottomView.h"
#import "FeedTag.h"
#import "YCommonActionSheet.h"
#import "FeedInfo.h"
#import "Author.h"
#import "Feed.h"

NSString *const kFeedListTableViewCell = @"FeedListTableViewCellId";
NSString *const kFeedDetailTableViewCell = @"kFeedDetailTableViewCell";
NSString *const kOrganizationFeedListTableViewCell = @"OrganizationFeedListTableViewCell";
NSString *const KCommentTableViewCell = @"CommentTableViewCell";

#define KLEFTMARGIN SCALE_NUM(15)//头像的左间距

#define KTAGMICONARGIN_TOP SCALE_NUM(18)
#define KBOTTOMMARGIN_TOP SCALE_NUM(12)

#define KHINTSIZE SCALE_NUM(34)

@interface FeedListTableViewCell ()

@property (nonatomic, strong) FeedCellTopView *topView;             //内容以上UI
@property (nonatomic, strong) FeedCellMiddleView *middleView;       //中间部分UI
@property (nonatomic, strong) FeedTag           *tagView;           //tag的view
@property (nonatomic, strong) FeedCellBottomView *bottomView;       //底下部分UI

@property (nonatomic, strong) UILabel *hintLabel;                   //动态

@property (nonatomic, assign) int feedType;                         //feed类型

@end

@implementation FeedListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        if ([reuseIdentifier isEqualToString:kFeedListTableViewCell]) {
            _feedType = FeedListType;
        }
        if ([reuseIdentifier isEqualToString:kFeedDetailTableViewCell]) {
            _feedType = FeedDetailType;
        }
        if ([reuseIdentifier isEqualToString:kOrganizationFeedListTableViewCell]) {
            _feedType = FeedOrganizationType;
        }
        if ([reuseIdentifier isEqualToString:KCommentTableViewCell]) {
            _feedType = FeedCommentType;
        }
        [self initTopView];
        [self initMiddleView];
        if (_feedType == FeedListType || _feedType == FeedDetailType) {
            [self initTagView];
        }
        [self initBottomView];
    }
    
    return self;
}


- (void)initTopView {
    _topView = [[FeedCellTopView alloc] initWithType:_feedType];
    [self.contentView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(KLEFTMARGIN);
        make.top.centerX.equalTo(self.contentView);
    }];
}


- (void)initMiddleView {
    _middleView = [[FeedCellMiddleView alloc] initWithType:_feedType];
    [self.contentView addSubview:_middleView];
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_feedType != FeedOrganizationType) {
            make.right.equalTo(_topView.tagList);
            if (_feedType != FeedCommentType) {
                make.top.equalTo(_topView.mas_bottom);
            } else {
                make.top.equalTo(_topView.mas_bottom).offset(KTAGMICONARGIN_TOP);
            }
            if (_feedType == FeedOrganizationType) {
                make.left.equalTo(_topView);
            } else {
                make.left.equalTo(_topView.contactNameLabel);
            }
        } else {
            make.left.mas_equalTo(SCALE_NUM(72));
            make.right.equalTo(self.contentView).offset(-KLEFTMARGIN);
            make.top.equalTo(self.contentView).offset(SCALE_NUM(20));
        }
    }];
    
    if (_feedType == FeedOrganizationType) {
        _hintLabel = [YUtils initLabel:CONTENT_FONT(10) color:KCOLORWHITE text:@"动态" frame:CGRectZero alignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_hintLabel];
        [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(SCALE_NUM(10));
            make.top.equalTo(self.contentView).offset(SCALE_NUM(12));
            make.width.height.mas_equalTo(KHINTSIZE);
        }];
        _hintLabel.layer.cornerRadius = KHINTSIZE/2;
        _hintLabel.clipsToBounds = true;
        _hintLabel.backgroundColor = KCOLORGREEN_009688;
    }
}

- (void)initTagView {
    _tagView = [[FeedTag alloc] init];
    [self.contentView addSubview:_tagView];
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_middleView);
        make.top.equalTo(_middleView.mas_bottom).offset(KTAGMICONARGIN_TOP);
    }];
    [_tagView.tagIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_topView.contactHeadImageView);
    }];
    [_tagView.tagContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_middleView.contentLabel);
    }];
    
}

- (void)initBottomView {
    _bottomView = [[FeedCellBottomView alloc] initWithType:_feedType];
    [self.contentView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_feedType == FeedCommentType) {
            make.top.equalTo(_middleView);
            make.right.equalTo(_middleView.mas_left);
            
        } else {
            make.right.equalTo(_topView);
            if (_feedType == FeedOrganizationType) {
                make.top.equalTo(_middleView.mas_bottom).offset(KBOTTOMMARGIN_TOP);
            } else {
                make.top.equalTo(_tagView.mas_bottom).offset(KBOTTOMMARGIN_TOP);
            }
        }
        make.bottom.lessThanOrEqualTo(self.contentView).offset(-10);
    }];
    if (_feedType == FeedListType) {
        [_bottomView.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_tagView.tagIcon);
        }];
    }
    if (_feedType == FeedOrganizationType) {
        [_bottomView.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_middleView);
        }];
        UIView *line = [[UIView alloc] init];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_bottomView);
            make.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
        line.backgroundColor = KCOLORGREEN_e6ebea;
    }
    if (_feedType == FeedDetailType || _feedType == FeedCommentType) {
        [_bottomView.respectImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_topView.contactHeadImageView);
        }];
    }
    if (_feedType == FeedDetailType) {
        [_bottomView.personList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_middleView);
        }];
    }
    if (_feedType == FeedCommentType) {
        [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-10);
        }];
    }
    
}

- (void)setData:(id)info
{
    if (_feedType != FeedOrganizationType) {
        [_topView setData:info];
    }
    [_middleView setData:info];
    [_bottomView setData:info];
    if (_feedType == FeedListType || _feedType == FeedDetailType) {
        [_tagView setData:[(FeedInfo *)info tags]];
    }
}

- (void)setHintHidden:(BOOL)isHidden {
    _hintLabel.hidden = isHidden;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
