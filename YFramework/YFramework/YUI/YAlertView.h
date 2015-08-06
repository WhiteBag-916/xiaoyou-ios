//
//  Alert.h
//  Xiaoyou
//
//  Created by mac on 15/4/30.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YView.h"
@class YAlertView;


@protocol YAlertViewDelegate<NSObject>
@optional
- (void)clickedButtonAtIndex:(NSInteger)buttonIndex alertView:(YAlertView *)alertView;

@end

@interface YAlertView : YView

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content delegate:(id<YAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;
- (void)show:(UIViewController *)target;
@end
