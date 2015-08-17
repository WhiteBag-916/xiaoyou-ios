//
//  FeedCellBottomView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedCellBottomView.h"
#import "YUtils+Component.h"

#define KBOTTOMHEIGHT SCALE_NUM(25)
#define KSHAREWIDTH SCALE_NUM(25)
#define KCOMMENTWIDTH SCALE_NUM(25)
#define KBUTTONTEXTMARGIN SCALE_NUM(2)

@interface FeedCellBottomView()

@property (nonatomic, strong, readwrite) UIImageView *shareButton;             //分享按钮
@property (nonatomic, strong, readwrite) UILabel *commentNum;                  //评论数
@property (nonatomic, strong, readwrite) UILabel *respectNum;                  //敬酒数
@property (nonatomic, strong, readwrite) UIImageView *respectImg;              //敬酒按钮

@end

@implementation FeedCellBottomView

- (id)initWithType:(int)type {
    self = [super init];
    if (self) {
        if (type == FeedOrganizationType || type == FeedListType) {
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
               make.height.mas_equalTo(KBOTTOMHEIGHT); 
            }];
            _shareButton = [[UIImageView alloc] init];
            [self addSubview:_shareButton];
            [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.centerY.equalTo(self);
                make.width.mas_equalTo(KSHAREWIDTH);
            }];
            _shareButton.contentMode = UIViewContentModeCenter;
            _shareButton.image = [UIImage imageNamed:@"more"];
            _shareButton.userInteractionEnabled = true;
            [_shareButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openShare)]];
            
            UIView *commentView = [[UIView alloc] init];
            [self addSubview:commentView];
            [commentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.centerX.equalTo(self);
            }];
            
            UIImageView *commentImg = [[UIImageView alloc] init];
            [commentView addSubview:commentImg];
            [commentImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.bottom.equalTo(commentView);
                make.width.mas_equalTo(KCOMMENTWIDTH);
            }];
            commentImg.contentMode = UIViewContentModeCenter;
            commentImg.image = [UIImage imageNamed:@"comment"];
            
            _commentNum = [YUtils initLabel:CONTENT_FONT(10) color:[UIColor blackColor] text:@"50000" frame:CGRectZero alignment:NSTextAlignmentLeft];
            [commentView addSubview:_commentNum];
            [_commentNum mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(commentImg.mas_right).offset(KBUTTONTEXTMARGIN);
                make.top.bottom.right.equalTo(commentView);
            }];
            
            _respectNum = [YUtils initLabel:CONTENT_FONT(10) color:[UIColor blackColor] text:@"99" frame:CGRectZero alignment:NSTextAlignmentLeft];
            [self addSubview:_respectNum];
            [_respectNum mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.right.equalTo(self);
            }];
            
            _respectImg = [[UIImageView alloc] init];
            [self addSubview:_respectImg];
            [_respectImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(_respectNum.mas_left).offset(-KBUTTONTEXTMARGIN);
                make.top.bottom.equalTo(self);
                make.width.equalTo(commentImg);
            }];
            _respectImg.contentMode = UIViewContentModeCenter;
            _respectImg.image = [UIImage imageNamed:@"cup"];
        }

    }
    return self;
}
- (void)openShare {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Push_FeedDetail object:@{@"id":@"233"}];
}

- (void)setData {
    
}

@end
