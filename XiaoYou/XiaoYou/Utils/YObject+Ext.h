//
//  YObject+Ext.h
//  XiaoYou
//
//  Created by sheng on 15/11/20.
//  Copyright © 2015年 xc. All rights reserved.
//


//说明：此工具类函数是为了替换部分冗长的switch或者if else选择结构
#import "YObject.h"

@interface YObject (Ext)

+(void)isElement:(id)element InArray:(NSArray *)array sucessed:( void(^)() )successedBlock failed:(void(^)())failedBlock;

@end
