//
//  YHTTPRequestAction.m
//  YFramework
//
//  Created by abc on 15/4/17.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YHTTPRequestAction.h"
#import "YHttpRequest.h"
#import "YQueue.h"

NSString *const kAsyncQueueTypeYHTTPRequestAction = @"kAsyncQueueTypeYHTTPRequestAction";
static int const kAsyncQueueTypeHTTPRequestActionMaxConcurrentOperationCount = 5;

@interface YHTTPRequestAction ()
//@property (nonatomic,strong) YHttpRequest *httpRequest;
@end

@implementation YHTTPRequestAction
+ (void)initialize
{
    if (self == [YHTTPRequestAction class])
    {
        [YQueue registerAsyncQueueWithType:kAsyncQueueTypeYHTTPRequestAction
               maxConcurrentOperationCount:kAsyncQueueTypeHTTPRequestActionMaxConcurrentOperationCount];
    }
}

#pragma mark - Action 操作
- (void)start {
    [super start];
    [YQueue dispatchInAsyncQueueWithQueueType:kAsyncQueueTypeYHTTPRequestAction
                                operationName:self.type
                                     priority:self.priority
                                        block:^{
                                            [self execute];
                                        }
                              completionBlock:^{
                                  [self completed];
                              }
     ];
}

- (void)cancel
{
    [super cancel];
    [YQueue cancelOpertionsWithName:self.type];
//    [self.httpRequest stop];
//    [YQueue dispatchInMainQueueWithBlock:^{
//        YActionMessage *message = [[YActionMessage alloc] initWithType:NSStringFromClass([self class]) errorCode:RequestCancelledErrorType desc:@"The request was cancelled" object:nil];
//        self.completionBlock(message);
//        self.completionBlock = nil;
//    }];
}

- (void)setTimeOutSeconds:(NSTimeInterval) timeout
{
//    self.httpRequest.timeout = timeout;
}

#pragma mark - Http 请求封装

- (YHttpRequest *)startWithURL:(NSString *)URLString
                   requestType:(YHttpRequestType)type
                    parameters:(NSDictionary *)parameters
                       success:(YHTTPRequstCompletionSuccessBlock)success
                       failure:(YHTTPRequstCompletionFailureBlock)failure
              receivedProgress:(YHTTPRequstProgressBlock)receivedProgress
                  sentProgress:(YHTTPRequstProgressBlock)sentProgress
{
//  self.httpRequest = [YHttpRequest requestWithURL:URLString type:type parameters:parameters];
//  [self.httpRequest startWithBlockSuccess:success
//                                  failure:failure
//                         receivedProgress:receivedProgress
//                             sentProgress:sentProgress];
//  return self.httpRequest;
    YHttpRequest *httpRequest = [YHttpRequest requestWithURL:URLString
                                                        type:type
                                                  parameters:parameters];
    [httpRequest startWithBlockSuccess:success
                               failure:failure
                      receivedProgress:receivedProgress
                          sentProgress:sentProgress];
    return httpRequest;
}

- (YHttpRequest *)GET:(NSString *)URLString
           parameters:(id)parameters
           completion:(YHTTPRequstCompletionSuccessBlock)completionBlock
{
    return [self GET:URLString parameters:parameters success:completionBlock failure:completionBlock];
}

- (YHttpRequest *)GET:(NSString *)URLString
           parameters:(NSDictionary *)parameters
              success:(YHTTPRequstCompletionSuccessBlock)success
              failure:(YHTTPRequstCompletionFailureBlock)failure
{
    return [self startWithURL:URLString
                  requestType:YHttpRequestTypeGetData
                   parameters:parameters
                      success:success
                      failure:failure
             receivedProgress:nil
                 sentProgress:nil];
}

- (YHttpRequest *)POST:(NSString *)URLString
            parameters:(id)parameters
            completion:(YHTTPRequstCompletionSuccessBlock)completionBlock
{
    return [self POST:URLString parameters:parameters success:completionBlock failure:completionBlock];
}

- (YHttpRequest *)POST:(NSString *)URLString
            parameters:(NSDictionary *)parameters
               success:(YHTTPRequstCompletionSuccessBlock)success
               failure:(YHTTPRequstCompletionFailureBlock)failure
{
    return [self startWithURL:URLString
                  requestType:YHttpRequestTypePostData
                   parameters:parameters
                      success:success
                      failure:failure
             receivedProgress:nil
                 sentProgress:nil];
}

- (YHttpRequest *)Down:(NSString *)URLString
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
    return [self startWithURL:URLString
                  requestType:YHttpRequestTypeDownloadFile
                   parameters:tparameters
                      success:success
                      failure:failure
             receivedProgress:nil
                 sentProgress:nil];
}

- (YHttpRequest *)Upload:(NSString *)URLString
                   files:(NSArray *)files
              parameters:(NSDictionary *)parameters
            sentProgress:(YHTTPRequstProgressBlock)sentProgress
              completion:(YHTTPRequstCompletionSuccessBlock)completionBlock
{
    NSMutableDictionary *tparameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if (files.count > 0)
    {
        tparameters[kYHttpRequestUploadFile] = files;
    }
    
    return [self startWithURL:URLString
                  requestType:YHttpRequestTypeUploadFile
                   parameters:tparameters
                      success:completionBlock
                      failure:completionBlock
             receivedProgress:nil
                 sentProgress:nil];
}

#pragma mark - Content-Type 头域获取

+ (NSDictionary *)XMLRESTHeader
{
    return @{ @"Content-Type" : @"application/xml;charset=UTF-8" };
}

+ (NSDictionary *)JSONRESTHeader
{
    return @{ @"Content-Type" : @"application/json;charset=UTF-8" };
}

+ (NSDictionary *)urlencodedFormHeader
{
    return @{ @"Content-Type" : @"application/json" };
}

@end
