//
//  YDatabaseDao.m
//  YFramework
//
//  Created by abc on 15/4/17.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YDatabaseDao.h"
#import "YDatabase.h"
#import "YModel.h"
#import <objc/runtime.h>

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

- (void)deleteAllDataWithTableName:(NSString *)tableName
{
    NSString *sql = [NSString stringWithFormat:@"delete from %@",tableName];
    [YDatabase registerDB:self.databasePath];
    [YDatabase update:self.databasePath sql:sql];
}


//获取类名
- (NSString *)classNameFromModel:(YModel *)model
{
    return NSStringFromClass([model class]);
}

- (Class)classFromClassName:(NSString *)className
{
    return NSClassFromString(className);
}

/**
 根据类名获取类里面所有属性
 */
- (NSArray *)classAttributesFromClassName:(NSString *)className
{
    //属性的个数
    unsigned int outCount;
    unsigned int outCount2;
    //获取所有的属性
    Class class = [self classFromClassName:className];
    Class superClass = [class superclass];
    objc_property_t *properties = class_copyPropertyList(class, &outCount);
    objc_property_t *properties2 = class_copyPropertyList(superClass, &outCount2);
    
    //保存所有的属性名字
    NSMutableArray *attributes = [NSMutableArray array];
    
    //遍历属性
    for (int i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        //获取属性的名字
        const char *name = property_getName(property);
        //把属性添加到数组里面
        [attributes addObject:[NSString stringWithUTF8String:name]];
        
        
    }
    
    for (int i = 0; i < outCount2; i++) {
        objc_property_t property = properties2[i];
        //获取属性的名字
        const char *name = property_getName(property);
        const char *type = property_getAttributes(property);
        
        
        NSLog(@"%s\n %s",name,type);
        
        //把属性添加到数组里面
        [attributes addObject:[NSString stringWithUTF8String:name]];
    }
    
    //释放
    free(properties);
    free(properties2);
    return attributes;
}


/**
 创建表
 */
- (BOOL)isCreateTableSuccessWithModel:(YModel *)model
{
    NSMutableString *sql = [NSMutableString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement",[self classNameFromModel:model]];
    
    //获取所有的属性
    NSArray *attributes = [self classAttributesFromClassName:[self classNameFromModel:model]];
    
    //拼接sql语句
    for (int i = 0; i < attributes.count; i++)
    {
        [sql appendString:[NSString stringWithFormat:@",%@ text",attributes[i]]];
    }
    
    [sql appendString:@")"];
    
    //执行sql语句
    [YDatabase registerDB:self.databasePath];
    return [YDatabase update:self.databasePath sql:sql];
}

-(BOOL)insertModel:(YModel*)model
{
    if (![self tableExistsWithName:NSStringFromClass([model class])]) {
        return NO;
    }
    //获取表名
    NSString *tableName = NSStringFromClass([model class]);
    
    
    //判断表是否存在
    if (![self tableExistsWithName:tableName])
    {
        //创建表失败
        if (![self isCreateTableSuccessWithModel:model])
        {
            return NO;
        }
    }
    
    //插入数据
    NSMutableString *sql = [NSMutableString stringWithFormat:@"insert into %@ (",[self classNameFromModel:model]];
    NSMutableString *valueString = [NSMutableString stringWithFormat:@" values ("];
    
    //获取所有的属性
    NSArray *attributes = [self classAttributesFromClassName:[self classNameFromModel:model]];
    
    //拼接sql语句
    for (int i = 0; i < attributes.count; i++)
    {
        if (i == attributes.count - 1)
        {
            [sql appendString:[NSString stringWithFormat:@"%@)",attributes[i]]];
            [valueString appendFormat:@"'%@')",[model valueForKey:attributes[i]]];
        }
        else
        {
            [sql appendString:[NSString stringWithFormat:@"%@,",attributes[i]]];
            [valueString appendFormat:@"'%@',",[model valueForKey:attributes[i]]];
        }
    }
    
    //拼接
    [sql appendString:valueString];
    
    
    //执行插入
    [YDatabase registerDB:self.databasePath];
    BOOL isSuccessed = [YDatabase update:self.databasePath sql:sql];
    return isSuccessed;
}
/**
 读取所有的数据。
 数组保存的是模型
 */
-(NSArray*)queryModel:(NSString*)className
{
    if (![self tableExistsWithName:className]) {
        return nil;
    }
    NSString *sql = [NSString stringWithFormat:@"select * from %@",className];
    //查询
    [YDatabase registerDB:self.databasePath];
    return [YDatabase query:self.databasePath sql:sql];
}

@end
