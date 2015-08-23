//
//  ProfileFeedContentView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfileFeedContentView.h"
#import "FeedTag.h"
#import "FeedImageGroup.h"
#import "FeedInfo.h"
#import "Feed.h"

#define KTAGTEXTMARGIN SCALE_NUM(10)
#define KCONTENTMARGIN_TOP SCALE_NUM(20)
#define KIMGMARGIN_TOP SCALE_NUM(10)
@interface ProfileFeedContentView()

@property (nonatomic, strong) FeedTag *tagView;
@property (nonatomic, strong) FeedImageGroup *imgGroup;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation ProfileFeedContentView

- (id)init {
    self = [super init];
    if (self) {
        _tagView = [[FeedTag alloc] init];
        [self addSubview:_tagView];
        [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
        }];
        [_tagView.tagContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_tagView.tagIcon.mas_right).offset(KTAGTEXTMARGIN);
        }];
        
        _contentLabel = [YUtils initLabel:CONTENT_FONT(10) color:[UIColor blackColor] text:@"" frame:CGRectZero alignment:NSTextAlignmentLeft];
        [self addSubview:_contentLabel];
        _contentLabel.numberOfLines = 0;
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_tagView.tagContent);
            make.top.equalTo(_tagView.mas_bottom).offset(KCONTENTMARGIN_TOP);
        }];
        _imgGroup = [[FeedImageGroup alloc] init];
        [self addSubview:_imgGroup];
        [_imgGroup mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_contentLabel);
            make.top.equalTo(_contentLabel.mas_bottom).offset(KIMGMARGIN_TOP);
        }];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_imgGroup);
        }];
    }
    return self;
}

- (void)setData:(FeedInfo *)info {
    if (info == nil) {
        [_tagView setData:nil];
        [_imgGroup updateWithImgs:nil bigPics:nil];
        _contentLabel.text = nil;
    } else {
        [_tagView setData:info.tags];
        _contentLabel.text = info.feed.content;
        
        [_imgGroup updateWithImgs:[info.feed.img componentsSeparatedByString:@","] bigPics:[info.feed.img componentsSeparatedByString:@","]];
    }
}


@end
