//
//  YHTTPRequestAction.h
//  YFramework
//
//  Created by abc on 15/4/17.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YAction.h"
#import "YHttp.h"
#import "YFoundation.h"

//默认同步执行任务Queue类型
extern NSString* const kAsyncQueueTypeYHTTPRequestAction;

@interface YHTTPRequestAction : YAction <YAction>
#pragma mark - 执行
/**
 *  @author Abc
 *
 *  见YAction基类介绍
 */

#pragma mark - Http 请求封装

- (YHttpRequest *)GET:(NSString *)URLString
           parameters:(id)parameters
           completion:(YHTTPRequstCompletionSuccessBlock)completionBlock;

- (YHttpRequest *)GET:(NSString *)URLString
           parameters:(id)parameters
              success:(YHTTPRequstCompletionSuccessBlock)success
              failure:(YHTTPRequstCompletionFailureBlock)failure;

- (YHttpRequest *)POST:(NSString *)URLString
            parameters:(id)parameters
            completion:(YHTTPRequstCompletionSuccessBlock)completionBlock;

- (YHttpRequest *)POST:(NSString *)URLString
            parameters:(id)parameters
               success:(YHTTPRequstCompletionSuccessBlock)success
               failure:(YHTTPRequstCompletionFailureBlock)failure;

- (YHttpRequest *)Down:(NSString *)URLString
            parameters:(id)parameters
           destination:(NSString *)destination
               success:(YHTTPRequstCompletionSuccessBlock)success
               failure:(YHTTPRequstCompletionFailureBlock)failure
      receivedProgress:(YHTTPRequstProgressBlock)receivedProgress;

- (YHttpRequest *)Upload:(NSString *)URLString
                   files:(NSArray *)files
              parameters:(NSDictionary *)parameters
            sentProgress:(YHTTPRequstProgressBlock)sentProgress
              completion:(YHTTPRequstCompletionSuccessBlock)completionBlock;


#pragma mark - 解析

#pragma mark - HTTP Header
/**
 *  @author Abc
 *
 *  如下几个函数主要获取请求的Header字典
 *
 *  @return 头域字典
 */
+ (NSDictionary *)XMLRESTHeader;
+ (NSDictionary *)JSONRESTHeader;
+ (NSDictionary *)urlencodedFormHeader;


@end
