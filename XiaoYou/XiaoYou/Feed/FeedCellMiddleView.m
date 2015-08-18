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
        
        _imgGroup = [[FeedImageGroup alloc] init];
        [self addSubview:_imgGroup];
        [_imgGroup mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_contentLabel);
            make.top.equalTo(_contentLabel.mas_bottom).offset(KTAGMARGIN_TOP);
        }];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_imgGroup);
        }];

    }
    return self;
}

- (void)setData {
    _contentLabel.text = @"To be, or not to be —that is the question, Whether'tis nobler in the mind to suffer. The slings and arrows of outrageous fortune Or to take arms against a sea of troubles, And by opposing end them. To die —to sleep";
    [_imgGroup updateWithImgs:@[@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg"] bigPics:@[@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg"]];
}
@end
