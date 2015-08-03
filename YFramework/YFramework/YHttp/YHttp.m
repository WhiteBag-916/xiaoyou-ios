//
//  YHttp.m
//  YFramework
//
//  Created by abc on 15/4/11.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YHttp.h"

@interface YHttp ()
@end

@implementation YHttp

+ (YHttpRequest *)GET:(NSString *)URLString
           parameters:(id)parameters
           completion:(YHTTPRequstCompletionSuccessBlock)completionBlock
{
    return [self GET:URLString parameters:parameters success:completionBlock failure:completionBlock];
}

+ (YHttpRequest *)GET:(NSString *)URLString
           parameters:(NSDictionary *)parameters
              success:(YHTTPRequstCompletionSuccessBlock)success
              failure:(YHTTPRequstCompletionFailureBlock)failure
{
    return [YHttpRequest startWithURL:URLString
                          requestType:YHttpRequestTypeGetData
                           parameters:parameters
                              success:success
                              failure:failure
                     receivedProgress:nil
                         sentProgress:nil];
}

+ (YHttpRequest *)POST:(NSString *)URLString
            parameters:(id)parameters
            completion:(YHTTPRequstCompletionSuccessBlock)completionBlock
{
    return [self POST:URLString parameters:parameters success:completionBlock failure:completionBlock];
}

+ (YHttpRequest *)POST:(NSString *)URLString
            parameters:(NSDictionary *)parameters
               success:(YHTTPRequstCompletionSuccessBlock)success
               failure:(YHTTPRequstCompletionFailureBlock)failure
{
    return [YHttpRequest startWithURL:URLString
                          requestType:YHttpRequestTypePostData
                           parameters:parameters
                              success:success
                              failure:failure
                     receivedProgress:nil
                         sentProgress:nil];
}

+ (YHttpRequest *)Down:(NSString *)URLString
            parameters:(NSDictionary *)parameters
           destination:(NSString *)destination
               success:(YHTTPRequstCompletionSuccessBlock)success
               failure:(YHTTPRequstCompletionFailureBlock)failure
      receivedProgress:(YHTTPRequstProgressBlock)receivedProgress
{
    NSMutableDictionary *tparameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if (destination.length > 0)
    {
        tparameters[kYHttpRequestDownloadDestinationPath] = destination;
    }
    return [YHttpRequest startWithURL:URLString
                          requestType:YHttpRequestTypeDownloadFile
                           parameters:tparameters
                              success:success
                              failure:failure
                     receivedProgress:nil
                         sentProgress:nil];
}

+ (YHttpRequest *)Upload:(NSString *)URLString
                    file:(NSString *)filePath
                  forKey:(NSString *)key
              parameters:(NSDictionary *)parameters
                 success:(YHTTPRequstCompletionSuccessBlock)success
                 failure:(YHTTPRequstCompletionFailureBlock)failure
            sentProgress:(YHTTPRequstProgressBlock)sentProgress
{
    NSMutableDictionary *tparameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if (filePath.length > 0)
    {
        tparameters[kYHttpRequestUploadFile] = filePath;
    }

    if (key.length > 0)
    {
        tparameters[kYHttpRequestUploadKey] = key;
    }

    return [YHttpRequest startWithURL:URLString
                          requestType:YHttpRequestTypeUploadFile
                           parameters:tparameters
                              success:success
                              failure:failure
                     receivedProgress:nil
                         sentProgress:nil];
}

+ (YHttpRequest *)Upload:(NSString *)URLString
                    data:(NSString *)data
                  forKey:(NSString *)key
              parameters:(NSDictionary *)parameters
                 success:(YHTTPRequstCompletionSuccessBlock)success
                 failure:(YHTTPRequstCompletionFailureBlock)failure
            sentProgress:(YHTTPRequstProgressBlock)sentProgress
{
    NSMutableDictionary *tparameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if (data.length > 0)
    {
        tparameters[kYHttpRequestUploadData] = data;
    }

    if (key.length > 0)
    {
        tparameters[kYHttpRequestUploadKey] = key;
    }

    return [YHttpRequest startWithURL:URLString
                          requestType:YHttpRequestTypeUploadData
                           parameters:tparameters
                              success:success
                              failure:failure
                     receivedProgress:nil
                         sentProgress:nil];
}

@end
