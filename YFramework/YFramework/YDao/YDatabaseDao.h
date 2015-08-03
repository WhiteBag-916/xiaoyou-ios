//
//  YDatabaseDao.h
//  YFramework
//
//  Created by abc on 15/4/17.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YObject.h"

/**
 *  @author Abc
 *
 *  数据库数据管理的基类
 */
@interface YDatabaseDao : YObject

@property (nonatomic, copy) NSString *databasePath; //数据库路径

/**
 *  @author Abc
 *
 *  初始化
 *
 */
- (instancetype)initWitDatabasePath:(NSString *)path;

/**
 *  @author Abc
 *
 *  判断数据库中表是否存在,创建表前判断
 *
 *  @param tableName 表名称
 *
 *  @return 是否存在
 */
- (BOOL)tableExistsWithName:(NSString *)tableName;
/**
 *  @author liuli
 *
 * 更新很多字段 根据条件拼凑SQL语句
 *
 *  @param dictionary 字段组成的字典 tableName 表名称 where 条件 类似于byID
 *
 *
 */
- (void)updateWithDictionary:(NSDictionary *)dic
                    WithName:(NSString *)tableName
                     upWhere:(NSString *)where;

@end
