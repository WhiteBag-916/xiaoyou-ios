//
//  ConnectTag.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/16.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  @author 李思良, 15-08-24
 *
 *  @brief  人脉标签，动态宽度，高度固定
 */
@interface ConnectTag : UIView
/**
 *  @author 李思良, 15-08-24
 *
 *  @brief  更新人脉标签
 *
 *  @param tags array中的数据类型为Tags model
 */
- (void)updateWithTag:(NSArray *)tags;

@end
