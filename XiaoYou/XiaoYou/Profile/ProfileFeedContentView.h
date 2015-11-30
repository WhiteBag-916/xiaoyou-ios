//
//  ProfileFeedContentView.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FeedInfo;
@class FeedTag;
@class FeedImageGroup;
@class YTextView;

typedef NS_ENUM(int, ProfileFeedType) {
    /**
     *  @author 李思良, 15-08-24
     *
     *  @brief  content和tag完全对齐
     */
    ProfileFeedMy       = 0,
    /**
     *  @author 李思良, 15-08-24
     *
     *  @brief  content和tag的content对齐
     */
    ProfileFeedList     = 1,
    /**
     *  @author 李思良, 15-08-24
     *
     *  @brief  content和tag的content对齐，tag的content额外指定left
     */
    ProfileFeedOthers   = 2,
};

@interface ProfileFeedContentView : UIView

@property (nonatomic, strong, readonly) FeedTag *tagView;//feed的标签
@property (nonatomic, strong, readonly) FeedImageGroup *imgGroup;//feed的图片
@property (nonatomic, strong, readonly) YTextView *contentLabel;//feed的内容


- (id)initWithType:(int)type;

- (id)initWithImageSize:(CGFloat)size type:(int)type;

- (void)setData:(FeedInfo *)info;



@end
