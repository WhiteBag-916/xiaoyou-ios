//
//  YDirectory+Data.m
//  Model
//
//  Created by 熊宸 on 15/5/7.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YDirectory+Data.h"

@implementation YDirectory (Data)

+ (NSString *)fileCache
{
    NSString *path = [[self cache] stringByAppendingString:kFileCache];
    
    return path;
}

+ (NSString *)newProjectCache
{
    NSString *path = [[self cache] stringByAppendingString:kImgCache];
    
    return path;
}

+ (void)createFolders
{
    //所有进入程序需要的文件夹，都在这里创建
    NSString *path = [self fileCache];
    if (![self isDirectory:path])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    path = [self newProjectCache];
    if (![self isDirectory:path])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (instancetype)dataByJson:(NSString *)filePath type:(NSString *)fileType
{
    NSString *path = [[NSBundle mainBundle] pathForResource:filePath ofType:fileType];
    NSData *content = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:nil];
}

@end
