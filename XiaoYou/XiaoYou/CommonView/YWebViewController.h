//
//  YWebViewController.h
//  XiaoYou
//
//  Created by 李思良 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YViewController.h"

@interface YWebViewController : YViewController
/**
 *  @author 李思良, 15-12-04
 *
 *  @brief 通用app内置浏览器controller
 *
 *  @param url      需要访问的url链接
 *  @param title    需要显示的controller的title
 *  @param canClick 是否支持点击操作
 *
 *  @return
 */
- (id)initWithUrl:(NSString *)url andTitle:(NSString *)title canClick:(BOOL)canClick;

@end
