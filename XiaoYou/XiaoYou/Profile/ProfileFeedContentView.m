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
@interface ProfileFeedContentView()<UITextViewDelegate>

@property (nonatomic, strong, readwrite) FeedTag *tagView;
@property (nonatomic, strong, readwrite) FeedImageGroup *imgGroup;
@property (nonatomic, strong, readwrite) UITextView *contentLabel;
@property (nonatomic, assign) int type;
@end

@implementation ProfileFeedContentView

-(id)initWithImageSize:(CGFloat)size type:(int)type
{
    if (self = [super init]) {
        _tagView = [[FeedTag alloc] init];
        [self addSubview:_tagView];
        [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
        }];
        
        _contentLabel = [[UITextView alloc] init];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.editable = false;
        _contentLabel.dataDetectorTypes = UIDataDetectorTypeLink;
        _contentLabel.scrollEnabled = false;
        _contentLabel.font = CONTENT_FONT(12);
        _contentLabel.textContainer.lineFragmentPadding = 0;
        _contentLabel.textContainerInset = UIEdgeInsetsZero;
        _contentLabel.delegate = self;
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_tagView.tagContent);
            make.top.equalTo(_tagView.mas_bottom).offset(KCONTENTMARGIN_TOP);
        }];
        
        //这里限制image大小至少50
        size = size > 50 ? size : SCALE_NUM(77);
        _imgGroup = [[FeedImageGroup alloc] initWithImageSize:size];
        
        [self addSubview:_imgGroup];
        [_imgGroup mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_contentLabel);
            make.top.equalTo(_contentLabel.mas_bottom).offset(KIMGMARGIN_TOP);
        }];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_imgGroup);
        }];
        [self updateLayoutWithType:type];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        _tagView = [[FeedTag alloc] init];
        [self addSubview:_tagView];
        [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
        }];
        
        _contentLabel = [[UITextView alloc] init];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.editable = false;
        _contentLabel.dataDetectorTypes = UIDataDetectorTypeLink;
        _contentLabel.scrollEnabled = false;
        _contentLabel.font = CONTENT_FONT(12);
        _contentLabel.textContainer.lineFragmentPadding = 0;
        _contentLabel.textContainerInset = UIEdgeInsetsZero;
        _contentLabel.delegate = self;
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_tagView.tagContent);
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

- (id)initWithType:(int)type {
    self = [self init];
    if (self) {
        _type = type;
//        if (_type != ProfileFeedMy) {
//            [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(_tagView.tagContent);
//            }];
//        } else {
//            [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(_tagView);
//            }];
//        }
//        if (_type != ProfileFeedOthers) {
//            [_tagView.tagContent mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(_tagView.tagIcon.mas_right).offset(KTAGTEXTMARGIN);
//            }];
//        }
        [self updateLayoutWithType:type];
    }
    return self;
}

-(void)updateLayoutWithType:(int)type
{
    if (_type != ProfileFeedMy) {
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_tagView.tagContent);
        }];
    } else {
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_tagView);
        }];
    }
    if (_type != ProfileFeedOthers) {
        [_tagView.tagContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_tagView.tagIcon.mas_right).offset(KTAGTEXTMARGIN);
        }];
    }
}

- (void)setData:(FeedInfo *)info {
    _contentLabel.text = nil;
    if (info == nil) {
        [_tagView setData:nil];
        [_imgGroup updateWithImgs:nil bigPics:nil];
    } else {
        [_tagView setData:info.tags];
        _contentLabel.text = [@"\u200B" stringByAppendingString:info.feed.content];
        if (info.feed.img.length == 0) {
            [_imgGroup updateWithImgs:nil bigPics:nil];
        } else {
            [_imgGroup updateWithImgs:[info.feed.img componentsSeparatedByString:@","] bigPics:[info.feed.bigImg componentsSeparatedByString:@","]];
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_OpenBrowser object:nil userInfo:@{@"url":[URL absoluteString], @"title":@""}];
    return false;
}

@end
