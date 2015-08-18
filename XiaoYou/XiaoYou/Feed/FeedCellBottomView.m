//
//  FeedCellBottomView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedCellBottomView.h"
#import "YUtils+Component.h"

#define KBOTTOMHEIGHT SCALE_NUM(25)                 //社团和feed列表中bottom的高度
#define KBOTTOMHEIGHTH SCALE_NUM(34)                //其余的bottom的高度
#define KSHAREWIDTH SCALE_NUM(25)                   //分享按钮点击区域的大小
#define KCOMMENTWIDTH SCALE_NUM(15)                 //评论图标大小
#define KRESPECTWIDTH SCALE_NUM(16)                 //敬酒图标大小
#define KBUTTONTEXTMARGIN SCALE_NUM(2)              //图标和文字间距

#define KRESPECTLABELMARGIN_BOTTOM SCALE_NUM(4)     //敬酒文字与下边间距

@interface FeedCellBottomView()

@property (nonatomic, strong, readwrite) UIImageView *shareButton;             //分享按钮
@property (nonatomic, strong, readwrite) UILabel *commentNum;                  //评论数
@property (nonatomic, strong, readwrite) UILabel *respectNum;                  //敬酒数
@property (nonatomic, strong, readwrite) UIImageView *respectImg;              //敬酒按钮
@property (nonatomic, strong, readwrite) UIView *personList;                   //敬酒人
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
                make.left.equalTo(self);
            }];
            _shareButton.contentMode = UIViewContentModeCenter;
            _shareButton.image = [UIImage imageNamed:@"feedmore"];
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
                make.width.mas_equalTo(KRESPECTWIDTH);
            }];
            _respectImg.contentMode = UIViewContentModeCenter;
            _respectImg.image = [UIImage imageNamed:@"cup"];
        } else {
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(KBOTTOMHEIGHTH);
            }];
            _respectImg = [[UIImageView alloc] init];
            [self addSubview:_respectImg];
            [_respectImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.left.equalTo(self);
                make.width.mas_equalTo(KRESPECTWIDTH);
            }];
            _respectImg.contentMode = UIViewContentModeTop;
            _respectImg.image = [UIImage imageNamed:@"cup"];
            
            _respectNum = [YUtils initLabel:CONTENT_FONT(8) color:KCOLORGREEN_009688 text:@"999" frame:CGRectZero alignment:NSTextAlignmentCenter];
            [self addSubview:_respectNum];
            [_respectNum mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(_respectImg);
                make.bottom.equalTo(_respectImg).offset(-KRESPECTLABELMARGIN_BOTTOM);
            }];
            if (type == FeedDetailType) {
                [self initPersonList];
            }
        }
        
    }
    return self;
}

- (void)initPersonList {
    
}

- (void)openShare {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Push_FeedDetail object:@{@"id":@"233"}];
}

- (void)setData {
    
}

@end
