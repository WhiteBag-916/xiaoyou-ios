//
//  YControlsDefine.h
//  Component
//
//  Created by 熊宸 on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#ifndef Component_YControlsDefine_h
#define Component_YControlsDefine_h

#import "YUtils+Macros.h"
#import "YColor+Ext.h"

#define CONTENT_FONT(font) [UIFont systemFontOfSize:SCALE_NUM(font)]

#define SCALE_NUM(number)   number * SCREEN_WIDTH / 320

#define SCALE_NUM_4_7(number)   number * 375 / 320

#define KCOLOR_455A64 [UIColor hexChangeFloat:@"455A64"]
#define KCOLORWHITE [UIColor whiteColor]
#define KCOLORWHITE_b8b7b7 [UIColor hexChangeFloat:@"b8b7b7"]
#define KCOLORWHITE_696969 [UIColor hexChangeFloat:@"696969"]
#define KCOLOR_32424A [UIColor colorWithRed:0.196f green:0.259f blue:0.290f alpha:1.00f]
#define KCOLOR_009688 [UIColor hexChangeFloat:@"009688"]
#define KCOLOR_f2f2f2 [UIColor hexChangeFloat:@"f2f2f2"]
#define KCOLOR_e5e5e5 [UIColor hexChangeFloat:@"e5e5e5"]
#define KCOLOR_79909e [UIColor hexChangeFloat:@"79909e"]
#define KCOLOR_e6ebea [UIColor hexChangeFloat:@"e6ebea"]
#define KCOLOR_BLUE_2da8e1 [UIColor hexChangeFloat:@"2da8e1"]

#define KCOLOR_W1 [UIColor hexChangeFloat:@"FFFFFF"]
#define KCOLOR_B1 [UIColor hexChangeFloat:@"F9F9F9"]
#define KCOLOR_B2 [UIColor hexChangeFloat:@"e9e9e9"]
#define KCOLOR_B3 [UIColor hexChangeFloat:@"666666"]
#define KCOLOR_B4 [UIColor hexChangeFloat:@"333333"]
#define KCOLOR_B5 [UIColor hexChangeFloat:@"999999"]
#define KCOLOR_g1 [UIColor hexChangeFloat:@"009f92"]
#define KCOLOR_g2 [UIColor hexChangeFloat:@"95d5d0"]


#define KCOLORGRAY_B6 [UIColor hexChangeFloat:@"F6F6F6"]

#define KCOLORGRAY     [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]

#endif
