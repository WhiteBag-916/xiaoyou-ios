//
//  NSNull+InternalNullExtention.h
//  TestProject
//
//  Created by sheng on 15/12/12.
//  Copyright © 2015年 sheng. All rights reserved.
//
/**
 *  此文件为了处理程序中所有因为NSNull调用造成崩溃的情况
 *  添加此文件之后，程序中字典等为null的调用不需要if在判断
 */
#import <Foundation/Foundation.h>

@interface NSNull (InternalNullExtention)

@end
