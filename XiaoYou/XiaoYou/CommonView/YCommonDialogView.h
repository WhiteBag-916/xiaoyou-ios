//
//  YCommonDialogView.h
//  XiaoYou
//
//  Created by 熊宸 on 15/10/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YView.h"

@interface YCommonDialogView : YView

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *backgroundView;

//显示
- (void)show;

//隐藏
- (void)hide;

@end
