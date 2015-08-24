//
//  FeedCellBottomView.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FeedCellBottomDelegate <NSObject>

- (void)didClickShare;


@end

@class FeedInfo;

@interface FeedCellBottomView : UIView

@property (nonatomic, strong, readonly) UIImageView *shareButton;             //分享按钮
@property (nonatomic, strong, readonly) UILabel *commentNum;                  //评论数
@property (nonatomic, strong, readonly) UILabel *respectNum;                  //敬酒数
@property (nonatomic, strong, readonly) UIImageView *respectImg;              //敬酒按钮
@property (nonatomic, strong, readonly) UIView *personList;                   //敬酒人
@property (nonatomic, weak)             id<FeedCellBottomDelegate> delegate; //
- (id)initWithType:(int)type;

- (void)setData:(FeedInfo *)data;

@end
