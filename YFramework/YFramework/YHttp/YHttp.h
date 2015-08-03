//
//  YHttp.h
//  YFramework
//
//  Created by abc on 15/4/11.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHttpRequest.h"

/**
 *  @author Abc
 *
 *  HTTP 请求封装,目前仅封装了ASI,接口跟AFN类似,后续可对AFN进行封装选择.
 *  满足基本操作,支持Get,Post请求,支持上传下载文件.
 *  parameters参数说明:
    parameters是一个字典,用于填充请求Header,发送数据内容,以及相关本地路径的请求信息.
    1.通用
      parameters[kYHttpRequestHeader] = 请求Header字典
    2.普通Post请求
      parameters[kYHttpRequestPostData] = 发送的数据,可以为
        a)NSString类型,可能为json xml text x-www-form-urlencoded (需要在header中指定Content-Type)
        b)NSData类型,二进制数据
        c)NSDictionary类型-->x-www-form-urlencoded数据,自动指定Content-Type类型
    3.文件下载
      parameters[kYHttpRequestDownloadDestinationPath] = 文件下载的本地路径
    4.文件上传(二进制数据上传,类型为 multipart/form-data)
      parameters[kYHttpRequestUploadFile] = 上传的文件路径
      parameters[kYHttpRequestUploadData] = 上传的二进制数据,
      parameters[kYHttpRequestUploadKey]] = 上传数据类型(由接口指定)
      
 *
 */
@interface YHttp : NSObject
+ (YHttpRequest *)GET:(NSString *)URLString
           parameters:(id)parameters
           completion:(YHTTPRequstCompletionSuccessBlock)completionBlock;

+ (YHttpRequest *)GET:(NSString *)URLString
           parameters:(id)parameters
              success:(YHTTPRequstCompletionSuccessBlock)success
              failure:(YHTTPRequstCompletionFailureBlock)failure;

+ (YHttpRequest *)POST:(NSString *)URLString
            parameters:(id)parameters
               completion:(YHTTPRequstCompletionSuccessBlock)completionBlock;

+ (YHttpRequest *)POST:(NSString *)URLString
            parameters:(id)parameters
               success:(YHTTPRequstCompletionSuccessBlock)success
               failure:(YHTTPRequstCompletionFailureBlock)failure;

+ (YHttpRequest *)Down:(NSString *)URLString
            parameters:(id)parameters
           destination:(NSString *)destination
               success:(YHTTPRequstCompletionSuccessBlock)success
               failure:(YHTTPRequstCompletionFailureBlock)failure
      receivedProgress:(YHTTPRequstProgressBlock)receivedProgress;

+ (YHttpRequest *)Upload:(NSString *)URLString
                    file:(NSString *)filePath
                  forKey:(NSString *)key
              parameters:(id)parameters
                 success:(YHTTPRequstCompletionSuccessBlock)success
                 failure:(YHTTPRequstCompletionFailureBlock)failure
            sentProgress:(YHTTPRequstProgressBlock)sentProgress;

+ (YHttpRequest *)Upload:(NSString *)URLString
                    data:(NSString *)data
                  forKey:(NSString *)key
              parameters:(id)parameters
                 success:(YHTTPRequstCompletionSuccessBlock)success
                 failure:(YHTTPRequstCompletionFailureBlock)failure
            sentProgress:(YHTTPRequstProgressBlock)sentProgress;
@end
