//
//  DataConvert.m
//  XiaoYou
//
//  Created by sheng on 15/10/7.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "DataConvert.h"

@implementation DataConvert

+(CGFloat)pxConvertToFontSize:(CGFloat)px {
    return (px*1.0/96.0)*72.0;
}

@end
