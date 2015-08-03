//
//  YDirectory.m
//  YFramework
//
//  Created by abc on 15/4/18.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YObject.h"

/**
 *  @author Abc
 *
 *  所有Model的基类
 */
@interface YModel : YObject

/**
 *  @author Abc
 *
 *  将JSON或者NSDictionary转换为对象实例.
 *  如下几个方法是对MJExtension开源的扩展,主要应对服务器返回的JSON数据字段名称太古怪,不适合用来命名ObjC的成员名.
 *
 *  @param data json数据
           keyValues:字典对象
 *
 *  @return 实例化生成的对象,或者数组
 */
+ (instancetype)modelObjectWithJSONData:(NSData *)data;
+ (instancetype)modelObjectWithJSONDataByKey:(NSData *)data key:(NSString *)commonKey;
+ (instancetype)modelObjectWithKeyValues:(NSDictionary *)keyValues;
+ (NSArray *)modelObjectArrayWithJSONData:(NSData *)data;
+ (NSArray *)modelObjectArrayWithKeyValuesArray:(NSArray *)keyValuesArray;

/**
 *  @author YCPai
 *
 *  序列化反序列化方法
 *
 *  @param path 文件路径
 */
- (void)writeToFile:(NSString *)path;
+ (instancetype) instanceWithFile:(NSString *)path;

@end
