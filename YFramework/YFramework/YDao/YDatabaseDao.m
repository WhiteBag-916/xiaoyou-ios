//
//  YDatabaseDao.m
//  YFramework
//
//  Created by abc on 15/4/17.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YDatabaseDao.h"
#import "YDatabase.h"

@implementation YDatabaseDao
- (instancetype)initWitDatabasePath:(NSString *)path
{
    if (self = [super init])
    {
        self.databasePath = path;
        [YDatabase registerDB:self.databasePath];
    }
    return self;
}

- (BOOL)tableExistsWithName:(NSString *)tableName
{
    NSString *sql = @"SELECT * FROM sqlite_master WHERE type='table' AND name=?";
    NSArray *resutl = [YDatabase query:self.databasePath sql:sql, tableName];
    return (resutl.count > 0);
}

- (void)updateWithDictionary:(NSDictionary *)dic
                    WithName:(NSString *)tableName
                     upWhere:(NSString *)where
{
    NSMutableString *str = [NSMutableString string];
    for (NSString *key in dic) {
        NSString *newValue = [[dic valueForKey:key] stringByReplacingOccurrencesOfString:@"'" withString:@""];
        [str appendFormat:@"%@ = '%@',",key,newValue];
        
        
    }
    
    str = (NSMutableString *)[str substringToIndex:str.length - 1];
    NSString *SQL = [NSString stringWithFormat:@"update %@ set %@ where %@",tableName, str, where];
    
    [YDatabase registerDB:self.databasePath];
    [YDatabase update:self.databasePath sql:SQL];
   
}

@end
