//
//  YBaseService.m
//  XiaoYou
//
//  Created by sheng on 15/11/2.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <objc/runtime.h>
#import "YBaseService.h"
#import "YModel.h"
#import "YDatabase.h"
#import "YDirectory.h"


@interface YBaseService ()

@property (nonatomic,strong) YDatabase *dataBase;

@end


@implementation YBaseService


-(YDatabase *)dataBase
{
    if (!_dataBase) {
        _dataBase = [[YDatabase alloc]init];
    }
    return _dataBase;
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
    return [self.dataBase updateWithSql:sql];
}

/**
 判断表是否存在
 */
- (BOOL)isTableExistsWithTableName:(NSString *)tableName
{
    self.dataBase.databasePath = [NSString stringWithFormat:@"%@//%@",[YDirectory documents],tableName];
    [YDatabase registerDB:self.dataBase.databasePath];
    NSString *sql = @"select name from sqlite_master where type = 'table' and name = ?";
    //判断表是否存在
    
    NSArray *array = [self.dataBase queryWithSql:sql,tableName];
    if (!array)
    {
        return YES;
    }
    
    return NO;
}


-(BOOL)insertModel:(YModel*)model
{
    //获取表名
    NSString *tableName = NSStringFromClass([model class]);
    
    
    //判断表是否存在
    if (![self isTableExistsWithTableName:tableName])
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
    BOOL isSuccessed = [self.dataBase updateWithSql:sql];
    
    return isSuccessed;
}
/**
 读取所有的数据。
 数组保存的是模型
 */
-(NSArray*)queryModel:(NSString*)className
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@",className];
    //查询
    return [self.dataBase queryWithSql:sql];
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
        //const char *type = property_getAttributes(property);
        //把属性添加到数组里面
        [attributes addObject:[NSString stringWithUTF8String:name]];
    }
    
    //释放
    free(properties);
    free(properties2);
    return attributes;
}


-(BOOL)deleteModel:(NSString *)className andIdstr:(NSString *)idstr
{
    return [self.dataBase updateWithSql:[NSString stringWithFormat:@"delete from %@ where idstr = ?",className],idstr];

}

-(BOOL)updateModel:(YModel *)baseModel andIdstr:(NSString *)idstr andNeedUpdataString:(NSString *)needUpdataStr andUpdataString:(NSString *)updataStr
{
    NSString *tableName = NSStringFromClass([baseModel class]);
    return [self.dataBase updateWithSql:[NSString stringWithFormat:@"update %@ set  %@=?  where idstr=?",tableName,needUpdataStr],updataStr,idstr];
}
@end
