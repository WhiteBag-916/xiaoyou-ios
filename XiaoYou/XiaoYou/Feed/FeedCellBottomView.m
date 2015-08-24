//
//  FeedCellBottomView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedCellBottomView.h"
#import "YUtils+Component.h"
#import "YFaceImageView.h"
#import "YCommonActionSheet.h"
#import "FeedInfo.h"
#import "Feed.h"

#define KBOTTOMHEIGHT SCALE_NUM(25)                 //社团和feed列表中bottom的高度
#define KSHAREWIDTH SCALE_NUM(25)                   //分享按钮点击区域的大小
#define KCOMMENTWIDTH SCALE_NUM(15)                 //评论图标大小
#define KRESPECTWIDTH SCALE_NUM(16)                 //敬酒图标大小
#define KBUTTONTEXTMARGIN SCALE_NUM(2)              //图标和文字间距

#define KRESPECTLABELMARGIN_BOTTOM SCALE_NUM(0)     //敬酒文字与下边间距

#define KHEADWIDTH SCALE_NUM(34)                    //头像宽度
#define KHEADMARGIN SCALE_NUM(15)                   //头像间距

#define KRESPECTDETAILHEIGHT SCALE_NUM(30)          //敬酒detail中整体高度

@interface FeedCellBottomView()

@property (nonatomic, strong, readwrite) UIImageView *shareButton;             //分享按钮
@property (nonatomic, strong, readwrite) UILabel *commentNum;                  //评论数
@property (nonatomic, strong, readwrite) UILabel *respectNum;                  //敬酒数
@property (nonatomic, strong, readwrite) UIImageView *respectImg;              //敬酒按钮
@property (nonatomic, strong, readwrite) UIView *personList;                   //敬酒人
@property (nonatomic, assign)            int type;                             //类型
@property (nonatomic, assign)            BOOL isRespect;
@end

@implementation FeedCellBottomView

- (id)initWithType:(int)type {
    self = [super init];
    if (self) {
        _type = type;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respect)];
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
                make.top.bottom.equalTo(self);
                make.right.equalTo(self).offset(-SCALE_NUM(5));
            }];
            
            _respectImg = [[UIImageView alloc] init];
            [self addSubview:_respectImg];
            [_respectImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(_respectNum);
                make.left.equalTo(_respectNum).offset(-KBUTTONTEXTMARGIN-KRESPECTWIDTH);
                make.top.bottom.equalTo(self);
            }];
            _respectImg.contentMode = UIViewContentModeLeft;
            _respectImg.image = [UIImage imageNamed:@"cup"];
            _respectImg.userInteractionEnabled = true;
            [_respectImg addGestureRecognizer:tap];
        } else {
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(KHEADWIDTH);
            }];
            _respectImg = [[UIImageView alloc] init];
            [self addSubview:_respectImg];
            [_respectImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.centerY.equalTo(self);
                make.height.mas_equalTo(KRESPECTDETAILHEIGHT);
                make.width.mas_equalTo(KRESPECTWIDTH);
            }];
            _respectImg.contentMode = UIViewContentModeTop;
            _respectImg.image = [UIImage imageNamed:@"cup"];
            _respectImg.userInteractionEnabled = true;
            [_respectImg addGestureRecognizer:tap];
            
            _respectNum = [YUtils initLabel:CONTENT_FONT(8) color:KCOLORGREEN_009688 text:@"999" frame:CGRectZero alignment:NSTextAlignmentCenter];
            [self addSubview:_respectNum];
            [_respectNum mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_respectImg);
                make.bottom.equalTo(_respectImg).offset(-KRESPECTLABELMARGIN_BOTTOM);
            }];
            if (type == FeedDetailType) {
                _personList = [[UIView alloc] init];
                [self addSubview:_personList];
                [_personList mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.right.equalTo(self);
                }];
            }
        }
        
    }
    return self;
}
- (void)setData:(FeedInfo *)data {
    if (_type == FeedListType) {
        _respectNum.text = [NSString stringWithFormat:@"%d", (int)data.feed.praiseCount];
        _commentNum.text = [NSString stringWithFormat:@"%d", (int)data.feed.commentCount];
        _isRespect = data.feed.isPraise;
    }
}
//- (void)initPersonList {
//    [[_personList subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    UIView *tmp = nil;
//    int max = (_data.people.count > 4) ? 4:(int)_data.people.count;
//    for (int i = 0; i < max; i++) {
//        YFaceImageView *face = [[YFaceImageView alloc] init];
//        [_personList addSubview:face];
//        [face mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.equalTo(self);
//            make.width.mas_equalTo(KHEADWIDTH);
//            if (tmp == nil) {
//                make.left.equalTo(_personList);
//            } else {
//                make.left.equalTo(tmp.mas_right).offset(KHEADMARGIN);
//            }
//        }];
//        NSDictionary *dic = _data.people[i];
//        [face setData:dic[@"uid"] imageUrl:dic[@"pic"]];
//        tmp = face;
//    }
//    if (_data.people.count > 4) {
//        UIImageView *open = [[UIImageView alloc] init];
//        open.backgroundColor = [UIColor redColor];
//        [_personList addSubview:open];
//        open.userInteractionEnabled = true;
//        [open mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(tmp.mas_right).offset(KHEADMARGIN);
//            make.top.bottom.width.equalTo(tmp);
//        }];
//        [open addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openDetail)]];
//    }
//}

- (void)respect {
//    _isRespect = !_isRespect;
//    if (_isRespect) {
//        _data.respectNum++;
//        _respectNum.text = [NSString stringWithFormat:@"%d", _data.respectNum];
//    } else {
//        _data.respectNum--;
//        _respectNum.text = [NSString stringWithFormat:@"%d", _data.respectNum];
//    }
}
- (void)updateRespect {
    if (_isRespect) {
        _respectImg.image = [UIImage imageNamed:@"cup"];
    } else {
        _respectImg.image = [UIImage imageNamed:@"cup"];
    }
}
- (void)openShare {
    [_delegate didClickShare];
}
- (void)openDetail {
    
}
//- (void)setData:(FeedInfo *)data {
////    if (_type == FeedDetailType) {
////        [self initPersonList];
////    }
//    _respectNum.text = [NSString stringWithFormat:@"%d", _data.respectNum];
//    if (_type == FeedListType || _type == FeedOrganizationType) {
//        _commentNum.text = [NSString stringWithFormat:@"%d", _data.commentNum];
//    }
//}
@end
