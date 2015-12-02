//
//  FeedCellTopView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedCellTopView.h"
#import "YUtils+Component.h"
#import "ConnectTag.h"
#import "YFaceImageView.h"
#import "FeedInfo.h"
#import "Author.h"
#import "Feed.h"
#import "CommentListItems.h"
#import "Comment.h"


#define KHEADIMGWIDTH SCALE_NUM(40)//标准头像宽度
#define KHEADIMGWIDTHS SCALE_NUM(34)//评论头像宽度
#define KHEADIMGTOP SCALE_NUM(35)//头像中心距顶高度

#define KNAMEMARGIN_LEFT SCALE_NUM(12)//名字左间距
#define KTIMEMARGIN_LEFT SCALE_NUM(20)//时间左间距

#define KEMPTYHEIGHT SCALE_NUM(10)//空的占位高度


@interface FeedCellTopView()

@property (nonatomic, strong, readwrite) YFaceImageView *contactHeadImageView;    //头像
@property (nonatomic, strong, readwrite) UILabel *contactNameLabel;            //名字
@property (nonatomic, strong, readwrite) UILabel *timeLabel;                   //时间
@property (nonatomic, strong, readwrite) ConnectTag *tagList;                  //人脉标签
@property (nonatomic, strong, readwrite) UILabel *genderLabel;
@end

@implementation FeedCellTopView

- (id)initWithType:(int)type {
    self = [super init];
    if (self) {
        if (type == FeedOrganizationType) {
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(KEMPTYHEIGHT);
            }];
        } else {
            _contactHeadImageView = [[YFaceImageView alloc] init];
            [self addSubview:_contactHeadImageView];
            [_contactHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (type == FeedCommentType) {
                     make.width.height.mas_equalTo(KHEADIMGWIDTHS);
                } else {
                    make.width.height.mas_equalTo(KHEADIMGWIDTH);
                }
                make.centerX.equalTo(self.mas_left).offset(KHEADIMGWIDTH/2);
                make.centerY.equalTo(self.mas_top).offset(KHEADIMGTOP);
            }];
            _contactHeadImageView.layer.cornerRadius = KHEADIMGWIDTH / 2;
            _contactHeadImageView.clipsToBounds = true;
//            _contactHeadImageView.backgroundColor = [UIColor redColor];
            
            _genderLabel = [[UILabel alloc]init];
            
            _contactNameLabel = [YUtils initLabel:CONTENT_FONT(14)
                                            color:[UIColor blackColor]
                                             text:@"人名"
                                            frame:CGRectZero
                                        alignment:NSTextAlignmentLeft];
            [self addSubview:_contactNameLabel];
            [_contactNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_contactHeadImageView.mas_right).offset(KNAMEMARGIN_LEFT);
                make.centerY.equalTo(_contactHeadImageView);
            }];
            
            _timeLabel = [YUtils initLabel:CONTENT_FONT(11) color:KCOLORWHITE_696969
                                      text:@"刚刚" frame:CGRectZero alignment:NSTextAlignmentLeft];
            [self addSubview:_timeLabel];
            [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_contactNameLabel.mas_right).offset(KTIMEMARGIN_LEFT);
                make.bottom.equalTo(_contactNameLabel);
            }];
            
            _tagList = [[ConnectTag alloc] init];
            [self addSubview:_tagList];
            [_tagList mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self);
                make.bottom.equalTo(_contactNameLabel);
            }];
            
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_contactHeadImageView);
            }];
        }
    }
    return self;
}

- (void)setData:(id)inData {
    if ([inData isKindOfClass:[FeedInfo class]]) {
        FeedInfo *data = inData;
        [_contactHeadImageView setData:data.author.uid imageUrl:data.author.headPic];
        _contactNameLabel.text = data.author.name;
        _timeLabel.text = [YUtils distanceTimeToday:
                           [NSDate dateWithTimeIntervalSince1970:data.feed.createTime/1000]];
        [_tagList updateWithTag:data.author.propetiesCommon];
    }
    if ([inData isKindOfClass:[CommentListItems class]]) {
        CommentListItems *data = inData;
        [_contactHeadImageView setData:data.author.uid imageUrl:data.author.headPic];
        _contactNameLabel.text = data.author.name;
        _timeLabel.text = [YUtils distanceTimeToday:
                           [NSDate dateWithTimeIntervalSince1970:data.comment.createTime/1000]];
        [_tagList updateWithTag:data.author.propetiesCommon];
    }
}

@end
