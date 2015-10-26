//
//  YHttpRequest.m
//  YFramework
//
//  Created by abc on 15/4/13.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YHttpRequest.h"
#import "YFoundation.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

//超时时间
static NSTimeInterval defaultHttpTimeOutSeconds = 20;
static NSTimeInterval defaultUpDownLoadHttpTimeOutSeconds = 60;

static NSMutableArray *Requests = nil;

@interface YHttpRequest ()
{
  @private
    ASIHTTPRequest *request;
}
@end

@implementation YHttpRequest

- (id)initWithURL:(NSString *)requestURLStr type:(YHttpRequestType)type parameters:(NSDictionary *)parameters
{
    self = [super init];
    if (self)
    {
        requestURLStr = [requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:requestURLStr];

        switch (type)
        {
            case YHttpRequestTypeGetData:
                request = [ASIHTTPRequest requestWithURL:url];
                request.absTimeOutSeconds = defaultHttpTimeOutSeconds;
                break;
            case YHttpRequestTypePostData:
                if ([parameters[kYHttpRequestPostData] isKindOfClass:[NSDictionary class]])
                {
                    request = [ASIFormDataRequest requestWithURL:url];
                    NSDictionary *paramDic = parameters[kYHttpRequestPostData];
                    [paramDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                        [(ASIFormDataRequest *)request setPostValue:obj forKey:key];
                    }];
                }
                else
                {
                    request = [ASIHTTPRequest requestWithURL:url];
                    id data = parameters[kYHttpRequestPostData];
                    if ([data isKindOfClass:[NSString class]])
                    {
                        [request appendPostData:[(NSString *) data dataUsingEncoding:NSUTF8StringEncoding]];
                    }
                    else
                    {
                        [request appendPostData:(NSData *) data];
                    }
                }
                request.absTimeOutSeconds = defaultHttpTimeOutSeconds;
                break;

            case YHttpRequestTypeDownloadFile:
                request = [ASIHTTPRequest requestWithURL:url];
                request.absTimeOutSeconds = defaultUpDownLoadHttpTimeOutSeconds;
                [request setDownloadDestinationPath:parameters[kYHttpRequestDownloadDestinationPath]];
                break;

            case YHttpRequestTypeUploadData:
            case YHttpRequestTypeUploadFile:
                request = [ASIFormDataRequest requestWithURL:url];
                request.absTimeOutSeconds = defaultUpDownLoadHttpTimeOutSeconds;
                if ([parameters[kYHttpRequestPostData] isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *paramDic = parameters[kYHttpRequestPostData];
                    [paramDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                        [(ASIFormDataRequest *)request setPostValue:obj forKey:key];
                    }];
                }
                
                if (YHttpRequestTypeUploadFile == type)
                {
                    if ([parameters[kYHttpRequestUploadFile] isKindOfClass:[NSArray class]])
                    {
                        NSArray *files = parameters[kYHttpRequestUploadFile];
//                        if (1 == files.count) {
//                            [(ASIFormDataRequest *) request setFile:[files objectAtIndex:0]
//                                                             forKey:@"imgfile"];
//                        } else {
//                            [files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                                [(ASIFormDataRequest *) request setFile:obj
//                                                                 forKey:[NSString stringWithFormat:@"%lu",idx+1]];
//                                
//                            }];
//                        }
                        [files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            [(ASIFormDataRequest *) request setFile:obj
                                                             forKey:@"imgs"];
                            
                        }];
                    }
                }
                else if (YHttpRequestTypeUploadData == type)
                {
                    if ([parameters[kYHttpRequestUploadData] isKindOfClass:[NSDictionary class]])
                    {
                        NSDictionary *paramDic = parameters[kYHttpRequestUploadData];
                        [paramDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                            [(ASIFormDataRequest *) request setData:obj
                                                             forKey:key];
                        }];
                    }
                }

                break;
            default:
                break;
        }

        NSDictionary *header = parameters[kYHttpRequestHeader];
        if (header)
        {
            id key, value;
            NSEnumerator *enumerator = [header keyEnumerator];
            while (key = [enumerator nextObject])
            {
                value = [header objectForKey:key];
                if (value)
                {
                    [request addRequestHeader:key value:value];
                }
            }
        }
        //request.timeOutSeconds = defaultHttpTimeOutSeconds;
    }
    return self;
}

+ (instancetype)requestWithURL:(NSString *)requestURLStr type:(YHttpRequestType)type parameters:(NSDictionary *)parameters
{
    return [[self alloc] initWithURL:requestURLStr type:type parameters:parameters];
}

//===========================================================
//  operationCode
//===========================================================
- (YHttpOperationCode)operationCode
{
    return self.operationCode;
}
- (void)setOperationCode:(YHttpOperationCode)anOperationCode
{
    self.operationCode = anOperationCode;
}

//===========================================================
//  requestUrl
//===========================================================
- (NSString *)requestUrl
{
    return self.requestUrl;
}
- (void)setRequestUrl:(NSString *)aRequestUrl
{
    self.requestUrl = aRequestUrl;
}

//===========================================================
//  requestMethod
//===========================================================
- (YHttpRequestMethod)requestMethod
{
    if ([request.requestMethod isEqualToString:@"GET"])
    {
        return YHttpRequestMethodGet;
    }
    else if ([request.requestMethod isEqualToString:@"POST"])
    {
        return YHttpRequestMethodPost;
    }
    else
    {
        return YHttpRequestMethodGet;
    }
}

- (void)setRequestMethod:(YHttpRequestMethod)aRequestMethod
{
    switch (aRequestMethod)
    {
        case YHttpRequestMethodGet:
            request.requestMethod = @"GET";
            break;
        case YHttpRequestMethodPost:
            request.requestMethod = @"POST";
            break;
        default:
            request.requestMethod = @"GET";
            break;
    }
}

//===========================================================
//  requestHeaders
//===========================================================
- (NSDictionary *)requestHeaders
{
    return request.requestHeaders;
}
- (void)setRequestHeaders:(NSDictionary *)aRequestHeaders
{
    request.requestHeaders = [aRequestHeaders mutableCopy];
}

//===========================================================
//  timeout
//===========================================================
- (float)timeout
{
    return request.timeOutSeconds;
}
- (void)setTimeout:(float)aTimeout
{
    request.timeOutSeconds = aTimeout;
}

//===========================================================
//  isValidatesSecureCertificate
//===========================================================
- (BOOL)isValidatesSecureCertificate
{
    return request.validatesSecureCertificate;
}
- (void)setValidatesSecureCertificate:(BOOL)flag
{
    request.validatesSecureCertificate = flag;
}

//===========================================================
//  isCompressRequestBody
//===========================================================
- (BOOL)isCompressRequestBody
{
    return request.shouldCompressRequestBody;
}
- (void)setCompressRequestBody:(BOOL)flag
{
    request.shouldCompressRequestBody = flag;
}

//===========================================================
//  userInfo
//===========================================================
- (NSDictionary *)userInfo
{
    return request.userInfo;
}
- (void)setUserInfo:(NSDictionary *)anUserInfo
{
    request.userInfo = anUserInfo;
}

//===========================================================
//  downloadDestinationPath
//===========================================================
- (NSString *)downloadDestinationPath
{
    return request.downloadDestinationPath;
}
- (void)setDownloadDestinationPath:(NSString *)aDownloadDestinationPath
{
    request.downloadDestinationPath = aDownloadDestinationPath;
}

//===========================================================
//  uploadSourcePath
//===========================================================
- (NSString *)uploadSourcePath
{
    return self.uploadSourcePath;
}
- (void)setUploadSourcePath:(NSString *)anUploadSourcePath
{
    self.uploadSourcePath = anUploadSourcePath;
}

//===========================================================
//  errorCode
//===========================================================
- (NSInteger)errorCode
{
    NSInteger code = 0;
    if (0 == request.error.code)
    {
        if (200 != request.responseStatusCode)
        {
            code = request.responseStatusCode;
        }
    }
    else
    {
        code = request.error.code;
    }
    return code;
}

- (void)setErrorCode:(NSInteger)anErrorCode
{
    return;
}

//===========================================================
//  error
//===========================================================
- (NSError *)error
{
    return request.error;
}
- (void)setError:(NSError *)anError
{
    request.error = anError;
}

//===========================================================
//  responseString
//===========================================================
- (NSString *)responseString
{
    return request.responseString;
}

//===========================================================
//  responseData
//===========================================================
- (NSData *)responseData
{
    return request.responseData;
}

//===========================================================
//  postData
//===========================================================
- (NSData *)postData
{
    return request.postBody;
}

//===========================================================
//  responseHeaders
//===========================================================
- (NSDictionary *)responseHeaders
{
    return request.responseHeaders;
}

- (void)start
{
    NSAssert(![[NSThread currentThread] isMainThread], @"YHttpRequest:HTTP request can not run in main thread!!");
    [request startSynchronous];
}

- (void)stop
{
    [request cancel];
}

- (void)startWithBlockSuccess:(YHTTPRequstCompletionSuccessBlock)success
                      failure:(YHTTPRequstCompletionFailureBlock)failure
             receivedProgress:(YHTTPRequstProgressBlock)receivedProgress
                 sentProgress:(YHTTPRequstProgressBlock)sentProgress
{
    @synchronized([YHttpRequest Requests])
    {
        [[YHttpRequest Requests] addObject:self];
    }
    
    WS(weakSelf);
    [request setCompletionBlock:^{
        success(weakSelf);
        @synchronized([YHttpRequest Requests])
        {
            [[YHttpRequest Requests] removeObject:weakSelf];
        }
    }];

    if (receivedProgress)
    {
        [request setBytesReceivedBlock:^(unsigned long long size,
                                         unsigned long long total) {
            receivedProgress(size, total);
        }];
    }

    if (sentProgress)
    {
        [request setBytesSentBlock:^(unsigned long long size,
                                     unsigned long long total) {
            sentProgress(size,total);
        }];
    }

    [request setFailedBlock:^{
        failure(weakSelf);
        @synchronized([YHttpRequest Requests])
        {
            [[YHttpRequest Requests] removeObject:weakSelf];
        }
    }];

    [self start];
}

- (NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"\nrequestClass:%@\nmetod:%@\nurl:%@\nrequestHeaders:%@\npostBody:%@\nresponseStatusCode:%d\nrequestHeaders:%@\nresponseString:%@\nerror:%@\n",
                                                NSStringFromClass([request class]),
                                                request.requestMethod,
                                                request.url,
                                                request.requestHeaders,
                                                [[NSString alloc] initWithData:request.postBody encoding:NSUTF8StringEncoding],
                                                request.responseStatusCode,
                                                request.requestHeaders,
                                                request.responseString,
                                                request.error];
    return desc;
}

+ (NSMutableArray *)Requests
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Requests = [[NSMutableArray alloc] init];
    });
    return Requests;
}

+ (YHttpRequest *)startWithURL:(NSString *)URLString
                   requestType:(YHttpRequestType)type
                    parameters:(NSDictionary *)parameters
                       success:(YHTTPRequstCompletionSuccessBlock)success
                       failure:(YHTTPRequstCompletionFailureBlock)failure
              receivedProgress:(YHTTPRequstProgressBlock)receivedProgress
                  sentProgress:(YHTTPRequstProgressBlock)sentProgress
{
    YHttpRequest *httpRequest = [YHttpRequest requestWithURL:URLString
                                                        type:type
                                                  parameters:parameters];
    [httpRequest startWithBlockSuccess:success
                               failure:failure
                      receivedProgress:receivedProgress
                          sentProgress:sentProgress];
    return httpRequest;
}

@end
