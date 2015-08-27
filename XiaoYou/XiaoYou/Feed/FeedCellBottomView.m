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
#import "Tags.h"
#import "CommentListItems.h"
#import "Comment.h"
#import "Author.h"
#import "FeedManager.h"
#import "ProvisionManager.h"
#import "ProfileInfo.h"


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
@property (nonatomic, strong)            id myInfo;
@property (nonatomic, strong)            FeedInfo *info;
@property (nonatomic, strong)            NSMutableDictionary *shareData;
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
            
            _commentNum = [YUtils initLabel:CONTENT_FONT(10) color:KCOLORWHITE_696969 text:@"0" frame:CGRectZero alignment:NSTextAlignmentLeft];
            [commentView addSubview:_commentNum];
            [_commentNum mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(commentImg.mas_right).offset(KBUTTONTEXTMARGIN);
                make.top.bottom.right.equalTo(commentView);
            }];
            
            _respectNum = [YUtils initLabel:CONTENT_FONT(10) color:[UIColor blackColor] text:@"0" frame:CGRectZero alignment:NSTextAlignmentLeft];
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
            
            _respectNum = [YUtils initLabel:CONTENT_FONT(8) color:KCOLORGREEN_009688 text:@"0" frame:CGRectZero alignment:NSTextAlignmentCenter];
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
- (void)setData:(id)inData {
    if (_type == FeedListType) {
        FeedInfo *data = inData;
        NSString *tag = (data.tags.count == 0?@"校友观点":[data.tags[0] name]);
        _myInfo = data.feed;
        NSString *content = (data.feed.content.length == 0?@"":data.feed.content);
        NSString *img = data.feed.img.length > 0?[data.feed.img componentsSeparatedByString:@","][0]:@"";
        
        _shareData = [NSMutableDictionary dictionaryWithObjectsAndKeys:tag,@"tag",content,@"content",img, @"pic", nil];
        _respectNum.text = [NSString stringWithFormat:@"%d", (int)data.feed.praiseCount];
        _commentNum.text = [NSString stringWithFormat:@"%d", (int)data.feed.commentCount];
        [self updateRespect:data.feed.isPraise];
    }
    if (_type == FeedDetailType) {
        FeedInfo *data = inData;
        _myInfo = data.feed;
        _info = data;
        _respectNum.text = [NSString stringWithFormat:@"%d", (int)data.feed.praiseCount];
        [self updateRespect:data.feed.isPraise];
        [self initPersonList];
    }
    if (_type == FeedCommentType) {
        CommentListItems *data = inData;
        _myInfo = data.comment;
        _respectNum.text = [NSString stringWithFormat:@"%d", (int)data.comment.praiseCount];
        [self updateRespect:data.comment.isRespect];
    }
}
- (void)initPersonList {
    [[_personList subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *tmp = nil;
    int max = (_info.praisePeoples.count > 4) ? 4:(int)_info.praisePeoples.count;
    for (int i = 0; i < max; i++) {
        Author *item = _info.praisePeoples[i];
        YFaceImageView *face = [[YFaceImageView alloc] init];
        [_personList addSubview:face];
        [face setData:item.uid imageUrl:item.headPic];
        [face mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(KHEADWIDTH);
            if (tmp == nil) {
                make.left.equalTo(_personList);
            } else {
                make.left.equalTo(tmp.mas_right).offset(KHEADMARGIN);
            }
        }];
        tmp = face;
    }
    if (_info.praisePeoples.count > 4) {
        UIImageView *open = [[UIImageView alloc] init];
        open.backgroundColor = [UIColor redColor];
        [_personList addSubview:open];
        open.userInteractionEnabled = true;
        [open mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tmp.mas_right).offset(KHEADMARGIN);
            make.top.bottom.width.equalTo(tmp);
        }];
        [open addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openDetail)]];
    }
}

- (void)respect {
    if ([_myInfo isKindOfClass:[Feed class]]) {
        Feed *fd = _myInfo;
        [[FeedManager sharedInstance] addPraise:[NSString stringWithFormat:@"%d", (int)fd.feedIdentifier] block:^(YActionMessage *message) {
            if (message.isSuccess) {
                fd.isPraise = !fd.isPraise;
                if (fd.isPraise) {
                    fd.praiseCount ++;
                } else {
                    fd.praiseCount --;
                }
                if (_type == FeedDetailType) {
                    if (fd.isPraise) {
                        Author *author = [Author new];
                        author.uid = [[ProvisionManager sharedInstance] getProfile].uid;
                        author.headPic = [[ProvisionManager sharedInstance] getProfile].headPic;
                        _info.praisePeoples = [@[author] arrayByAddingObjectsFromArray:_info.praisePeoples];
                    } else {
                        NSMutableArray *personArray = [NSMutableArray arrayWithArray:_info.praisePeoples];
                        for (int i = 0; i < personArray.count; i++) {
                            Author *obj = personArray[i];
                            if ([obj.uid isEqualToString:[[ProvisionManager sharedInstance] getProfile].uid]) {
                                [personArray removeObjectAtIndex:i];
                                break;
                            }
                        }
                        _info.praisePeoples = [NSArray arrayWithArray:personArray];
                        
                    }
                    [self initPersonList];
                }
                [self updateRespect:fd.isPraise];
            } else {
                [YUtils showTitle:message.desc];
            }
        }];
    }
    if ([_myInfo isKindOfClass:[Comment class]]) {
        Comment *cd = _myInfo;
        [[FeedManager sharedInstance] commentAddPraise:[NSString stringWithFormat:@"%d", (int)cd.commentIdentifier] block:^(YActionMessage *message) {
            if (message.isSuccess) {
                cd.isRespect = ! cd.isRespect;
                if (cd.isRespect) {
                    cd.praiseCount ++;
                } else {
                    cd.praiseCount --;
                }
                [self updateRespect:cd.isRespect];
            } else {
                [YUtils showTitle:message.desc];
            }
        }];
    }
}
- (void)updateRespect:(BOOL)isRepect {
    if ([_myInfo isKindOfClass:[Feed class]]) {
        _respectNum.text = [NSString stringWithFormat:@"%d", (int)[(Feed *)_myInfo praiseCount]];
    }
    if ([_myInfo isKindOfClass:[Comment class]]) {
        _respectNum.text = [NSString stringWithFormat:@"%d", (int)[(Comment *)_myInfo praiseCount]];
    }
    if (isRepect) {
        _respectImg.image = [UIImage imageNamed:@"cupgreen"];
        _respectNum.textColor = KCOLORGREEN_009688;
    } else {
        _respectImg.image = [UIImage imageNamed:@"cup"];
        _respectNum.textColor = KCOLORWHITE_696969;
    }
}
- (void)openShare {
    YActionSheetItem *item1 = [YActionSheetItem itemWithType:YCommonActionSheetItemTypeShare title:@"分享这条动态至" extraData:_shareData];
    
    
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"举报"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                            
                                                        }];
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item2] title:nil];
    [sheet show];
}
- (void)openDetail {
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Open_PraiseDetail object:nil userInfo:@{@"feedId":[NSString stringWithFormat:@"%d", (int)[(Feed *)_myInfo feedIdentifier]]}];
}

@end
