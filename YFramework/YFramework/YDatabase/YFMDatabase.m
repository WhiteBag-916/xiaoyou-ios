//
//  YDatabase.m
//  YFramework
//
//  Created by abc on 15/4/16.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YFMDatabase.h"
#import "FMDB.h"
#import "YFoundation.h"

@implementation YFMDatabase
- (NSArray *)query:(NSString *)sql args:(va_list)args
{
    FMResultSet *result = [self executeQuery:sql withVAList:args];
    if (!result || [self hadError])
    {
        YLogE(@"YFMDatabase Query Error:\ncode:%d\nmessage:%@\nsql:%@\nFilePath:%@", [self lastErrorCode], [self lastErrorMessage], sql, [self databasePath]);
    }

    NSMutableArray *resultArray = [NSMutableArray array];
    while ([result next])
    {
        [resultArray addObject:[result resultDictionary]];
    }
    return resultArray;
}

- (BOOL)update:(NSString *)sql args:(va_list)args
{
    BOOL result = [self executeUpdate:sql withVAList:args];
    if (!result)
    {
        YLogE(@"YFMDatabase Update Error:\ncode:%d\nmessage:%@\nsql:%@\nFilePath:%@", [self lastErrorCode], [self lastErrorMessage], sql, [self databasePath]);
    }
    return result;
}

- (BOOL)update:(NSString *)sql
{
    BOOL result = [self executeUpdate:sql];
    if (!result)
    {
        YLogE(@"YFMDatabase Update Error:\ncode:%d\nmessage:%@\nsql:%@\nFilePath:%@", [self lastErrorCode], [self lastErrorMessage], sql, [self databasePath]);
    }
    return result;
}

@end
