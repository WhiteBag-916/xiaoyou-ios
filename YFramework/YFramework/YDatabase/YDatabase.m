//
//  YDatabase.m
//  YFramework
//
//  Created by abc on 15/4/16.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YDatabase.h"
#import "YFMDatabase.h"
#import "YFMDatabaseQueue.h"
#import "YFoundation.h"

static NSMutableDictionary *dbs;

#define VA_START(sql, pArgs) \
    va_list args;            \
    va_start(args, sql);     \
    va_list *pArgs = &args;

#define VA_END() \
    va_end(args);

@interface YDatabase ()
{
}
@property (nonatomic, strong) YFMDatabase *database;
@end

@implementation YDatabase

#pragma mark - init
- (instancetype)initWithPath:(NSString *)dbpath
{
    if (self = [super init])
    {
        self.databasePath = dbpath;
        [YDatabase registerDB:dbpath];
    }
    return self;
}

- (instancetype)initWithDatabase:(YFMDatabase *)database
{
    if (self = [super init])
    {
        self.database = database;
        self.databasePath = database.databasePath;
    }
    return self;
}

- (void)dealloc
{
    [YDatabase unRegisterDB:self.databasePath];
}

#pragma mark - 数据库管理
+ (NSMutableDictionary *)dbs
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbs = [[NSMutableDictionary alloc] init];
    });
    return dbs;
}

+ (YFMDatabaseQueue *)dbQueue:(NSString *)dbpath
{
    YFMDatabaseQueue *dbQueue = nil;

    if (0 == dbpath.length)
    {
        YLogE(@"file path empty!");
    }
    else
    {
        @synchronized([self dbs])
        {
            dbQueue = [self dbs][dbpath];
        }
    }

    return dbQueue;
}

+ (void)registerDB:(NSString *)dbpath
{
    if (0 == dbpath.length)
    {
        YLogE(@"file path empty!");
        return;
    }
    @synchronized([self dbs])
    {
        if ([self dbs][dbpath])
        {
            //已经存在
            return;
        }
        else
        {
            YFMDatabaseQueue *dbQueue = [[YFMDatabaseQueue alloc] initWithPath:dbpath];
            if (dbQueue == nil)
            {
                YLogE(@"DatabaseQueue initialize failed [file path is :%@]!", dbpath);
                return;
            }
            [self dbs][dbpath] = dbQueue;
        }
    }
}

+ (void)unRegisterDB:(NSString *)dbpath;
{
    if (0 == dbpath.length)
    {
        YLogE(@"file path empty!");
        return;
    }
    @synchronized([self dbs])
    {
        [[self dbs] removeObjectForKey:dbpath];
    }
}

+ (void)unRegisterAll;
{
    @synchronized([self dbs])
    {
        [[self dbs] removeAllObjects];
    }
}

#pragma mark - 数据库操作实例方法
- (NSArray *)queryWithSql:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);
    va_list *pArgs = &args;
    NSArray *result = [YDatabase query:self.databasePath sql:sql args:*pArgs];
    va_end(args);

    return result;
}

- (BOOL)updateWithSql:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);
    va_list *pArgs = &args;
    BOOL result = [YDatabase update:self.databasePath sql:sql args:*pArgs];
    va_end(args);
    return result;
}

- (BOOL)updateWithSqls:(NSArray *)sqls
{
    return [YDatabase update:self.databasePath sqls:sqls];
}

- (BOOL)inTransactionWithBlock:(YDatabaseTransactionBlock)block
{
    return [YDatabase inTransaction:self.databasePath block:block];
}

- (NSArray *)queryInTransactionWithSql:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);
    va_list *pArgs = &args;
    NSArray *result = [self.database query:sql args:*pArgs];
    va_end(args);

    return result;
}

- (BOOL)updateInTransactionWithSql:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);
    va_list *pArgs = &args;
    BOOL result = [self.database update:sql args:*pArgs];
    va_end(args);

    return result;
}

#pragma mark - 数据库操作类方法
+ (NSArray *)query:(NSString *)dbpath sql:(NSString *)sql args:(va_list)args
{
    YFMDatabaseQueue *dbQueue = [self dbQueue:dbpath];
    if (dbQueue == nil)
    {
        YLogE(@"DatabaseQueue is null,file path:%@!", dbpath);
        return nil;
    }

    __block NSArray *result = nil;
    [dbQueue inDatabase:^(YFMDatabase *db) {
        result = [db query:sql
                      args:args];
    }];
    return result;
}

+ (NSArray *)query:(NSString *)dbpath sql:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);
    va_list *pArgs = &args;
    NSArray *result = [self query:dbpath sql:sql args:*pArgs];
    va_end(args);

    return result;
}

+ (BOOL)update:(NSString *)dbpath sql:(NSString *)sql args:(va_list)args
{
    YFMDatabaseQueue *dbQueue = [self dbQueue:dbpath];
    if (dbQueue == nil)
    {
        YLogE(@"DatabaseQueue is null,file path:%@!", dbpath);
        return NO;
    }

    __block BOOL result = NO;
    [dbQueue inDatabase:^(YFMDatabase *db) {
        result = [db update:sql args:args];
    }];
    return result;
}

+ (BOOL)update:(NSString *)dbpath sql:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);
    va_list *pArgs = &args;
    BOOL result = [self update:dbpath sql:sql args:*pArgs];
    va_end(args);

    return result;
}

+ (BOOL)update:(NSString *)dbpath sqls:(NSArray *)sqls
{
    YFMDatabaseQueue *dbQueue = [self dbQueue:dbpath];
    if (dbQueue == nil)
    {
        YLogE(@"DatabaseQueue is null,file path:%@!", dbpath);
        return NO;
    }

    __block BOOL result = NO;

    [dbQueue inTransaction:^(YFMDatabase *db, BOOL *rollback) {
        for (NSString *sql in sqls)
        {
            result = [db update:sql];
            if (!result)
            {
                *rollback = YES;
                return;
            }
        }
    }];

    return result;
}

+ (BOOL)inTransaction:(NSString *)dbpath block:(YDatabaseTransactionBlock)block
{
    YFMDatabaseQueue *dbQueue = [self dbQueue:dbpath];
    if (dbQueue == nil)
    {
        YLogE(@"DatabaseQueue is null,file path:%@!", dbpath);
        return NO;
    }

    __block BOOL result = NO;

    [dbQueue inTransaction:^(YFMDatabase *db, BOOL *rollback) {
        YDatabase *Ydb = [[YDatabase alloc] initWithDatabase:db];
        block(Ydb, rollback);
        result = !*rollback;
    }];

    return result;
}

+ (NSArray *)queryInTransaction:(YDatabase *)db sql:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);
    va_list *pArgs = &args;
    NSArray *result = [db.database query:sql args:*pArgs];
    va_end(args);

    return result;
}

+ (BOOL)updateInTransaction:(YDatabase *)db sql:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);
    va_list *pArgs = &args;
    BOOL result = [db.database update:sql args:*pArgs];
    va_end(args);

    return result;
}

@end
