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
#import "Comment.h"
#import "CommentListItems.h"
#import "Author.h"
#import "ConvertToCommonEmoticonsHelper.h"

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
                                     text:@""
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
                make.bottom.equalTo(_imgGroup);
            }];
        } else {
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_contentLabel);
            }];
        }
    }
    return self;
}
- (void)setData:(id)inData {
    if ([inData isKindOfClass:[FeedInfo class]]) {
        FeedInfo *data = inData;
        _contentLabel.text = [ConvertToCommonEmoticonsHelper convertToSystemEmoticons:data.feed.content];
        if (data.feed.img.length == 0) {
            [_imgGroup updateWithImgs:nil];
        } else {
            [_imgGroup updateWithImgs:[data.feed.img componentsSeparatedByString:@","]];
        }
    }
    if ([inData isKindOfClass:[CommentListItems class]]) {
        CommentListItems *data = inData;
        _contentLabel.text = [ConvertToCommonEmoticonsHelper convertToSystemEmoticons:data.comment.content];
        if (data.replyUser.name.length != 0) {
            _contentLabel.text = [NSString stringWithFormat:@"回复%@:%@",data.replyUser.name, _contentLabel.text];
        }
    }
}
@end
