//
//  FeedTag.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKTagView.h"
@class Tags;
/**
 *  @author 李思良, 15-08-18
 *
 *  @brief  tag界面，高度动态调整
 */
@interface FeedTag : UIView

/**
 *  @author 李思良, 15-08-18
 *
 *  @brief  图标left与view的left对齐，top与view的top对齐
 */
@property (nonatomic, strong, readonly) UIImageView *tagIcon;                 //tag图标
/**
 *  @author 李思良, 15-08-18
 *
 *  @brief 内容与view的right对齐，由外部调用者来安排left位置
 */
@property (nonatomic, strong, readonly) SKTagView *tagContent;                      //tag标签内容

/**
 *  @author 李思良, 15-08-18
 *
 *  @brief  提供数据数组，模型为Tags,告知标签名称以及是否相关，数组需要排好序，即关联的标签排在最前面
 */
- (void)setData:(NSArray *)tags;
@end
