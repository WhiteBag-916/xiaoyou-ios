//
//  YActionMessage.h
//  YFramework
//
//  Created by abc on 15/4/17.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YObject.h"

#define kYActionMessage_Rustlt_Success 0

#define kYYHTTPErrorBase 1000
#define kYYServerErrorBase 4000

typedef enum _YHTTPErrorType {
    YHTTPConnectionFailureErrorType = kYYHTTPErrorBase + 1,
    YHTTPRequestTimedOutErrorType = kYYHTTPErrorBase + 2,
    YHTTPAuthenticationErrorType = kYYHTTPErrorBase + 3,
    YHTTPRequestCancelledErrorType = kYYHTTPErrorBase + 4,
    YHTTPUnableToCreateRequestErrorType = kYYHTTPErrorBase + 5,
    YHTTPInternalErrorWhileBuildingRequestType  = kYYHTTPErrorBase + 6,
    YHTTPInternalErrorWhileApplyingCredentialsType  = kYYHTTPErrorBase + 7,
    YHTTPFileManagementError = kYYHTTPErrorBase + 8,
    YHTTPTooMuchRedirectionErrorType = kYYHTTPErrorBase + 9,
    YHTTPUnhandledExceptionError = kYYHTTPErrorBase + 10,
    YHTTPCompressionError = kYYHTTPErrorBase + 11,
    
    //分割最大错误值
    YHTTPCompressionErrorMax = kYYHTTPErrorBase + 99
} YHTTPErrorType;

/**
 *  @author Abc
 *
 *  Action请求返给组件的消息回执
 */
@interface YActionMessage : YObject
@property (nonatomic, strong) NSString *type;      //请求的操作类型
@property (nonatomic, assign) NSInteger errorCode; //请求错误码(0为成功,其他为失败)
@property (nonatomic, assign,readonly) BOOL isSuccess;
@property (nonatomic, assign,readonly) BOOL isLocalError;
@property (nonatomic, assign,readonly) BOOL isServerError;
@property (nonatomic, strong) NSString *desc;      //错误描述
@property (nonatomic, strong) id object;           //请求返回的数据对象
- (instancetype)initWithType:(NSString *)type errorCode:(NSInteger)code desc:(NSString *)desc object:(id)object;
@end
