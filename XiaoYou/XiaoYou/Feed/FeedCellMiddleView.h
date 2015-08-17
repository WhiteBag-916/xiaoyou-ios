//
//  FeedCellMiddleView.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FeedImageGroup;
@interface FeedCellMiddleView : UIView

@property (nonatomic, strong, readonly) UILabel *contentLabel;                //内容
@property (nonatomic, strong, readonly) UIImageView *tagIcon;                 //tag图标
@property (nonatomic, strong, readonly) UILabel *tagLabel;                    //feed标签
@property (nonatomic, strong, readonly) FeedImageGroup *imgGroup;             //图片

- (id)initWithType:(int)type;
- (void)setData;

@end
