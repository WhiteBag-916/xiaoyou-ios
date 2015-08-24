//
//  FeedCellTopView.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConnectTag;
@class YFaceImageView;
@class FeedInfo;

@interface FeedCellTopView : UIView

@property (nonatomic, strong, readonly) YFaceImageView *contactHeadImageView;    //头像
@property (nonatomic, strong, readonly) UILabel *contactNameLabel;            //名字
@property (nonatomic, strong, readonly) UILabel *timeLabel;                   //时间
@property (nonatomic, strong, readonly) ConnectTag *tagList;                  //人脉标签


- (id)initWithType:(int)type;

- (void)setData:(FeedInfo *)data;

@end
