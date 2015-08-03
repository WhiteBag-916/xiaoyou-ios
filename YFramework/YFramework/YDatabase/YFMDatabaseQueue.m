//
//  YDatabaseQueue.m
//  YFramework
//
//  Created by abc on 15/4/16.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YFMDatabaseQueue.h"
#import "YFMDatabase.h"

@implementation YFMDatabaseQueue

+ (Class)databaseClass
{
    return [YFMDatabase class];
}
- (void)inDatabase:(void (^)(YFMDatabase *db))block
{
    [super inDatabase:(void (^)(FMDatabase *db)) block];
}

- (void)inTransaction:(void (^)(YFMDatabase *db, BOOL *rollback))block
{
    [super inTransaction:(void (^)(FMDatabase *db, BOOL *rollback)) block];
}

@end
