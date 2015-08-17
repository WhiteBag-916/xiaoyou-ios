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

NSString *const kFeedListTableViewCell = @"FeedListTableViewCellId";
NSString *const kFeedDetailTableViewCell = @"kFeedDetailTableViewCell";
NSString *const kOrganizationFeedListTableViewCell = @"OrganizationFeedListTableViewCell";
NSString *const KCommentTableViewCell = @"CommentTableViewCell";

#define KLEFTMARGIN SCALE_NUM(15)//头像的左间距




@interface FeedListTableViewCell ()

@property (nonatomic, strong) FeedCellTopView *topView;             //内容以上UI
@property (nonatomic, strong) FeedCellMiddleView *middleView;       //中间部分UI
@property (nonatomic, strong) FeedCellBottomView *bottomView;       //底下部分UI



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
        [self initBottomView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_topView.mas_bottom);
    }];
    if (_feedType == FeedListType || _feedType == FeedDetailType) {
        [_middleView.tagIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_topView.contactHeadImageView);
        }];
        [_middleView.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topView.contactNameLabel);
        }];
    } else if(_feedType == FeedOrganizationType){
        [_middleView.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topView);
        }];
    }
}

- (void)initBottomView {
    _bottomView = [[FeedCellBottomView alloc] initWithType:_feedType];
    [self.contentView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleView.mas_bottom).offset(15);
        make.centerX.equalTo(_topView);
        if (_feedType == FeedListType || _feedType == FeedDetailType) {
            make.left.equalTo(_middleView.tagIcon);
        } else {
            make.left.equalTo(_middleView.contentLabel);
        }
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    if (_feedType == FeedListType) {
        [_bottomView.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_middleView.tagIcon);
        }];
    }
    if (_feedType == FeedOrganizationType) {
        [_bottomView.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_middleView);
        }];
    }
    
}

- (void)initDetailBottomView {
    
}

- (void)setData
{
    [_topView setData];
    [_middleView setData];
    [_bottomView setData];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
