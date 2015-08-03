//
//  YHttpRequest.h
//  YFramework
//
//  Created by abc on 15/4/13.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHttpOperationCode.h"

#define kYHttpRequestHeader @"kYHttpRequestHeader"
#define kYHttpRequestPostData @"kYHttpRequestPostData"
#define kYHttpRequestDownloadDestinationPath @"kYHttpRequestDownloadDestinationPath"
#define kYHttpRequestUploadFile @"kYHttpRequestUploadFile"
#define kYHttpRequestUploadData @"kYHttpRequestUploadData"
#define kYHttpRequestUploadKey @"kYHttpRequestUploadKey"

@class YHttpRequest;

/**
 *  YHttpRequest 请求回调的块声明；
 *
 *  基本的请求成功，失败，上传，下载进度 Block回调；
 */
typedef void (^YHTTPRequstCompletionBlock)(YHttpRequest *request);
typedef void (^YHTTPRequstCompletionSuccessBlock)(YHttpRequest *request);
typedef void (^YHTTPRequstCompletionFailureBlock)(YHttpRequest *request);
typedef void (^YHTTPRequstProgressBlock)(unsigned long long size, unsigned long long total);

typedef NS_ENUM(NSInteger, YHttpRequestMethod)
{
    YHttpRequestMethodGet,
    YHttpRequestMethodPost,
};

typedef NS_ENUM(NSInteger, YHttpRequestType)
{
    YHttpRequestTypeGetData,
    YHttpRequestTypePostData,
    YHttpRequestTypeDownloadFile,
    YHttpRequestTypeUploadFile,
    YHttpRequestTypeUploadData,
};

@interface YHttpRequest : NSObject
@property (nonatomic, assign) YHttpOperationCode operationCode;
@property (nonatomic, copy) NSString *requestUrl;
@property (nonatomic, assign) YHttpRequestMethod requestMethod;
@property (nonatomic, strong) NSDictionary *requestHeaders;
@property (nonatomic, assign) float timeout;
@property (nonatomic, assign) BOOL isValidatesSecureCertificate;
@property (nonatomic, assign) BOOL isCompressRequestBody;
@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) NSString *downloadDestinationPath;
@property (nonatomic, strong) NSString *uploadSourcePath;
@property (nonatomic, strong, readonly) NSData *postData;

@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong, readonly) NSString *responseString;
@property (nonatomic, strong, readonly) NSData *responseData;
@property (nonatomic, strong, readonly) NSDictionary *responseHeaders;

+ (instancetype)requestWithURL:(NSString *)requestURLStr type:(YHttpRequestType)type parameters:(NSDictionary *)parameters;
+ (YHttpRequest *)startWithURL:(NSString *)URLString
                   requestType:(YHttpRequestType)type
                    parameters:(NSDictionary *)parameters
                       success:(YHTTPRequstCompletionSuccessBlock)success
                       failure:(YHTTPRequstCompletionFailureBlock)failure
              receivedProgress:(YHTTPRequstProgressBlock)receivedProgress
                  sentProgress:(YHTTPRequstProgressBlock)sentProgress;

- (void)startWithBlockSuccess:(YHTTPRequstCompletionSuccessBlock)success
                      failure:(YHTTPRequstCompletionFailureBlock)failure
             receivedProgress:(YHTTPRequstProgressBlock)receivedProgress
                 sentProgress:(YHTTPRequstProgressBlock)sentProgress;

- (void)stop;
@end
