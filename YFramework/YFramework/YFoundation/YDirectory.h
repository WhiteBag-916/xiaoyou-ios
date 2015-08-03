//
//  YDirectory.m
//  YFramework
//
//  Created by abc on 15/4/18.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YObject.h"

/**
 *  @author Abc
 *
 *  iOS 沙盒常用路径,你懂的...
 */
@interface YDirectory : YObject
+ (NSString *)documents;
+ (NSString *)temp;
+ (NSString *)library;
+ (NSString *)bundle;
+ (NSString *)cache;
+ (NSString *)preferences;

/**
 *  @author Abc
 *
 *  判断某一路径是否是文件夹
 *
 *  @param filePath 文件路径
 *
 *  @return 是否为文件夹
 */
+ (BOOL)isDirectory:(NSString *)filePath;

@end
