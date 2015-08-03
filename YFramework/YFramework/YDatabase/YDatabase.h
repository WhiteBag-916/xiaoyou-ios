//
//  YDatabase.h
//  YFramework
//
//  Created by abc on 15/4/16.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YObject.h"

/**
 *  @author Abc
 *
 *  数据库操作类
 */
@class YDatabase;

/**
 *  @author Abc
 *
 *  事务操作回调Block
 *
 *  @param db       数据库操作类对象
 *  @param rollback 是否需要回滚
 */
typedef void (^YDatabaseTransactionBlock)(YDatabase *db, BOOL *rollback);

@interface YDatabase : YObject
{
}
/**
 *  @author Abc
 *
 *  数据库绝对路径
 */
@property (nonatomic, strong) NSString *databasePath;

#pragma mark - init
/**
 *  @author Abc
 *
 *  创建数据库操作类对象,生成此对象后,将自动调用registerDB注册, 
 *  类对象dealloc时自动调用unRegisterDB:反注册
 *  @param dbpath 数据库绝对路径
 *
 *  @return 操作对象
 */
- (instancetype)initWithPath:(NSString *)dbpath;

#pragma mark - 数据库管理
/**
 *  @author Abc
 *
 *  数据库注册,用于统一管理当前数据库文件,连接,操作线程池,数据库在使用前必须提前手动注册.
 *
 *  @param dbpath 数据库绝对路径
 */
+ (void)registerDB:(NSString *)dbpath;

/**
 *  @author Abc
 *
 *  反注册数据库
 *
 *  @param dbpath 数据库绝对路径
 */
+ (void)unRegisterDB:(NSString *)dbpath;

/**
 *  @author Abc
 *
 *  注销所有注册过的数据库
 */
+ (void)unRegisterAll;

#pragma mark - 数据库操作实例方法
/**
 *  @author Abc
 *
 *  根据Sql查询
 *
 *  @param sql sql语句
 *
 *  @return 查询结果的数据字典(对象字段名:值,可以直接转换为JSON)的数组
 */
- (NSArray *)queryWithSql:(NSString *)sql, ...;

/**
 *  @author Abc
 *
 *  更新数据库
 *
 *  @param sql 更新语句
 *
 *  @return 更新结果
 */
- (BOOL)updateWithSql:(NSString *)sql, ...;

/**
 *  @author Abc
 *
 *  批量更新数据
 *
 *  @param sqls sql数组,调用前sql语句已经format完成
 *
 *  @return 更新结果,如果有一条更新失败,则全局失败
 */
- (BOOL)updateWithSqls:(NSArray *)sqls;

/**
 *  @author Abc
 *
 *  数据库事物操作,如果同一业务中需要多个更新查询操作,请使用事物操作,避免频繁打开关闭数据库连接导致性能下降.
 *
 *  @param block 事物中执行的block
 *
 *  @return 操作结果
 */
- (BOOL)inTransactionWithBlock:(YDatabaseTransactionBlock)block;

/**
 *  @author Abc
 *
 *  事务中执行查询操作
 *
 *  @param sql 查询语句
 *
 *  @return 查询结果的数据字典(对象字段名:值,可以直接转换为JSON)的数组
 */
- (NSArray *)queryInTransactionWithSql:(NSString *)sql, ...;

/**
 *  @author Abc
 *
 *  事务中执行更新操作
 *
 *  @param sql 更新语句
 *
 *  @return 更新结果
 */
- (BOOL)updateInTransactionWithSql:(NSString *)sql, ...;

#pragma mark - 数据库操作类方法
/**
 *  @author Abc
 *
 *  查询操作
 *
 *  @param dbpath 数据库绝对路径
 *  @param sql    查询语句
 *
 *  @return 查询结果的数据字典(对象(字段名:值),可以直接转换为JSON)的数组
 */
+ (NSArray *)query:(NSString *)dbpath sql:(NSString *)sql, ...;

/**
 *  @author Abc
 *
 *  更新操作
 *
 *  @param dbpath 数据库绝对路径
 *  @param sql    更新语句
 *
 *  @return 更新结果
 */
+ (BOOL)update:(NSString *)dbpath sql:(NSString *)sql, ...;

/**
 *  @author Abc
 *
 *  更新操作
 *
 *  @param dbpath 数据库绝对路径
 *  @param sqls sql数组,调用前sql语句已经format完成
 *
 *  @return 更新结果,如果有一条更新失败,则全局失败
 */
+ (BOOL)update:(NSString *)dbpath sqls:(NSArray *)sqls;

/**
 *  @author Abc
 *
 *  数据库事物操作,如果同一业务中需要多个更新查询操作,请使用事物操作,避免频繁打开关闭数据库连接导致性能下降.
 *
 *  @param dbpath 数据库绝对路径
 *  @param block  事物中执行的block
 *
 *  @return 操作结果
 */
+ (BOOL)inTransaction:(NSString *)dbpath block:(YDatabaseTransactionBlock)block;

/**
 *  @author Abc
 *
 *  事务中执行查询操作
 *
 *  @param db  数据库操作类对象
 *  @param sql 查询语句
 *
 *  @return 查询结果的数据字典(对象字段名:值,可以直接转换为JSON)的数组
 */
+ (NSArray *)queryInTransaction:(YDatabase *)db sql:(NSString *)sql, ...;

/**
 *  @author Abc
 *
 *  事务中执行更新操作
 *
 *  @param db  数据库操作类对象
 *  @param sql 更新语句
 *
 *  @return 更新结果
 */
+ (BOOL)updateInTransaction:(YDatabase *)db sql:(NSString *)sql, ...;
@end
