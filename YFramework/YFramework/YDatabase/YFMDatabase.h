//
//  YDatabase.h
//  YFramework
//
//  Created by abc on 15/4/16.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "FMDatabase.h"

@interface YFMDatabase : FMDatabase
/**
 *  @author Abc
 *
 *  根据Sql查询
 *
 *  @param sql sql语句
 *  @param args 格式化参数
 *
 *  @return 查询结果的数据字典(对象字段名:值,可以直接转换为JSON)的数组
 */
- (NSArray *)query:(NSString *)sql args:(va_list)args;

/**
 *  @author Abc
 *
 *  数据更新
 *
 *  @param sql sql语句
 *  @param args 格式化参数
 *
 *  @return 更新结果
 */
- (BOOL)update:(NSString *)sql args:(va_list)args;

/**
 *  @author Abc
 *
 *  数据更新
 *
 *  @param sql sql语句
 *
 *  @return 更新结果
 */
- (BOOL)update:(NSString *)sql;

@end
