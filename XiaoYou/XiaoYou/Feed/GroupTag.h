//
//  GroupTag.h
//  XiaoYou
//
//  Created by HuiYin on 15/9/10.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupTag : UIView

@property (nonatomic,strong) UIImageView * tagGroupIcon;
@property (nonatomic,strong) UILabel * tagGroupName;

- (void)setData:(id)inData;

@end
