//
//  FeedCellMiddleView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedCellMiddleView.h"
#import "YUtils+Component.h"
#import "FeedImageGroup.h"
#import "Feed.h"
#import "FeedInfo.h"

#define KTAGHEIGHT SCALE_NUM(20)
#define KTAGMARGIN SCALE_NUM(6)
#define KTAGMARGIN_TOP SCALE_NUM(15)


@interface FeedCellMiddleView()

@property (nonatomic, strong, readwrite) UILabel *contentLabel;                //内容
@property (nonatomic, strong, readwrite) FeedImageGroup *imgGroup;             //图片

@end

@implementation FeedCellMiddleView
- (id)initWithType:(int)type {
    self = [super init];
    if (self) {
        _contentLabel = [YUtils initLabel:CONTENT_FONT(12)
                                    color:[UIColor blackColor]
                                     text:@"o be, or not to be —that is the question, Whether'tis nobler in the mind to suffer. The slings and arrows of outrageous fortune Or to take arms against a sea of troubles, And by opposing end them. To die —to sleep"
                                    frame:CGRectZero
                                alignment:NSTextAlignmentLeft];
        _contentLabel.numberOfLines = 0;
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
        }];
        if (type != FeedCommentType) {
            _imgGroup = [[FeedImageGroup alloc] init];
            [self addSubview:_imgGroup];
            [_imgGroup mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(_contentLabel);
                make.top.equalTo(_contentLabel.mas_bottom).offset(KTAGMARGIN_TOP);
            }];
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(_imgGroup);
            }];
        } else {
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(_contentLabel);
            }];
        }
        

    }
    return self;
}
- (void)setData:(FeedInfo *)data {
    _contentLabel.text = data.feed.content;
    if (data.feed.img.length == 0) {
        [_imgGroup updateWithImgs:nil bigPics:nil];
    } else {
        [_imgGroup updateWithImgs:[data.feed.img componentsSeparatedByString:@","] bigPics:[data.feed.img componentsSeparatedByString:@","]];
    }
}
@end
