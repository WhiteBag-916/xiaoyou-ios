//
//  ContactsSQLiteManager.m
//  Component
//
//  Created by HuiYin on 15/8/11.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SQLiteManager.h"
#import "FMDatabase.h"

@interface SQLiteManager ()

@property(nonatomic,strong)FMDatabase * fmDatabase;

@end

@implementation SQLiteManager

+(instancetype)shareSQLiteManager
{
    static SQLiteManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SQLiteManager alloc] init];
    });
    return manager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self creatDB];
    }
    return self;
}

-(BOOL)runSQL:(NSString *)sql
{
    return [self.fmDatabase executeUpdate:sql];
}

-(void)creatDB
{
    NSString * path = [NSString stringWithFormat:@"%@/Documents/app.db",NSHomeDirectory()];
    NSLog(@"path = %@",path);
    
    self.fmDatabase = [[FMDatabase alloc]initWithPath:path];
    
    if ([self.fmDatabase open])
    {
        BOOL isOpen =  [self.fmDatabase executeUpdate:@"CREATE TABLE  contacts (`internalBaseClassIdentifier` TEXT ,`faculty` TEXT,`schoolCode` TEXT,`time` TEXT,`college` TEXT,`tag` TEXT,`linkStudentName` TEXT,`grad` TEXT,`icon` TEXT,`studentClass` TEXT,`isShield` TEXT,`linkStudentNo` TEXT,`isRemind` TEXT,`schoolName` TEXT,`gender` TEXT,`myStudentNo` TEXT)"];
        if (isOpen)
        {
            NSLog(@"创建表成功");
        }
        else
        {
            NSLog(@"创建表失败");
        }
    }
    else
    {
        NSLog(@"数据库打开失败！");
    }
}

@end
