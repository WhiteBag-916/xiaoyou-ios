//
//  YModel+ActionMessage.m
//  Component
//
//  Created by abc on 15/5/1.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YModel+ActionMessage.h"
#import "ResultCommon.h"

#define kYActionMessage_Server_Success 1

NSString *const kCommonObj = @"obj";

@implementation YModel (ActionMessage)
+ (YActionMessage *)actionMessageWithHttpRequest:(YHttpRequest *)request
{
    YLogI(@"YHttpRequest:%@", request);
    YModel<YModelActionMessage> *aObject = nil;
    NSInteger errorCode = kYActionMessage_Rustlt_Success;
    NSString *errorDescription = @"";
    if (0 == request.errorCode)
    {
        aObject = [ResultCommon modelObjectWithJSONData:request.responseData];
//        aObject = [self modelObjectWithJSONData:request.responseData];
        if ([aObject respondsToSelector:@selector(code)])
        {
            if (!(((NSInteger)[aObject code]) == kYActionMessage_Server_Success))
            {
                errorCode = kYYServerErrorBase + labs((NSInteger)[aObject code]);
            }
            	
            if (kYActionMessage_Rustlt_Success == errorCode)
            {
                errorDescription = ((ResultCommon*)aObject).message;

                //取出obj
                if (self != [ResultCommon class])
                {
                    aObject = [self modelObjectWithJSONDataByKey:request.responseData key:kCommonObj];
                }
            }
        }
        else
        {
            NSAssert([aObject respondsToSelector:@selector(code)], @"每个服务测接口response data 必存在 code字段!!");
        }
        
    }
    else
    {
        errorCode = kYYHTTPErrorBase + request.errorCode;
        errorDescription = request.error.description;
    }
    YActionMessage *message = [[YActionMessage alloc] initWithType:NSStringFromClass([self class])
                                                         errorCode:errorCode
                                                              desc:errorDescription
                                                            object:aObject];
    YLogI(@"Message:%@", message);
    return message;
}
@end
