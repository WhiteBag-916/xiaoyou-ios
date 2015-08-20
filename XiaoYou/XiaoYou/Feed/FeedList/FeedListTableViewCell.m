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

NSString *const kFeedListTableViewCell = @"FeedListTableViewCellId";
NSString *const kFeedDetailTableViewCell = @"kFeedDetailTableViewCell";
NSString *const kOrganizationFeedListTableViewCell = @"OrganizationFeedListTableViewCell";
NSString *const KCommentTableViewCell = @"CommentTableViewCell";

#define KLEFTMARGIN SCALE_NUM(15)//头像的左间距

#define KTAGMICONARGIN_TOP SCALE_NUM(18)
#define KBOTTOMMARGIN_TOP SCALE_NUM(12)



@interface FeedListTableViewCell () <FeedCellBottomDelegate>

@property (nonatomic, strong) FeedCellTopView *topView;             //内容以上UI
@property (nonatomic, strong) FeedCellMiddleView *middleView;       //中间部分UI
@property (nonatomic, strong) FeedTag           *tagView;           //tag的view
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
        if (_feedType == FeedListType || _feedType == FeedDetailType) {
            [self initTagView];
        }
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
    }];
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
    _bottomView.delegate = self;
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
            make.bottom.equalTo(self.contentView).offset(-10);
        }
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
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    }
    
}

- (void)setData
{
    FeedCellTopModel *topData = [[FeedCellTopModel alloc] init];
    topData.userId = @"233";
    topData.userName = @"用户";
    topData.imgUrl = @"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg";
    topData.publishDate = [NSDate dateWithTimeIntervalSince1970:[[NSDate dateWithTimeIntervalSinceNow:-1000] timeIntervalSince1970]];
    topData.tagList = @[@"班",@"系",@"社"];
    [_topView setData:topData];
    [_middleView setData];
    FeedCellBottomModel *bottomData = [[FeedCellBottomModel alloc] init];
    bottomData.feedId = @"233";
    bottomData.respectNum = 999;
    if (_feedType == FeedListType || _feedType == FeedOrganizationType) {
        bottomData.commentNum = 1000;
    }
    if (_feedType == FeedDetailType) {
        bottomData.people = @[@{@"uid":@"123",@"pic":@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg"},@{@"uid":@"123",@"pic":@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg"},@{@"uid":@"123",@"pic":@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg"},@{@"uid":@"123",@"pic":@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg"},@{@"uid":@"123",@"pic":@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg"}];
    }
    [_bottomView setData:bottomData];
    [_tagView setData];
}

- (void)didClickShare {
    YActionSheetItem *item1 = [YActionSheetItem itemWithType:YCommonActionSheetItemTypeShare title:@"分享这条动态至" extraData:@{@"tag":@"互联网",@"content":@"balabala",@"pic":@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg"}];
    
    
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"举报"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                            
                                                        }];
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item2] title:nil];
    [sheet show];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
