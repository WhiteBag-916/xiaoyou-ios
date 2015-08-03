//
//  YDatabaseQueue.h
//  YFramework
//
//  Created by abc on 15/4/16.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "FMDatabaseQueue.h"

@class YFMDatabase;

@interface YFMDatabaseQueue : FMDatabaseQueue

/**
 *  @author Abc
 *
 *  数据库操作,异步处理,返回结果前阻塞当前线程
 *
 *  @param block 此回调用于在数据库操作完成后进行相关数据处理.
 */
- (void)inDatabase:(void (^)(YFMDatabase *db))block;

/**
 *  @author Abc
 *
 *  数据库事务操作,异步处理,返回结果前阻塞当前线程.
 *
 *  @param block 此回调用于在数据库操作完成后进行相关数据处理.
 */
- (void)inTransaction:(void (^)(YFMDatabase *db, BOOL *rollback))block;
@end
