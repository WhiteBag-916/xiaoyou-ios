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
#define kYActionMessage_Server_Token_Fail 1016

NSString *const kCommonObj = @"obj";

@implementation YModel (ActionMessage)
+ (YActionMessage *)actionMessageWithHttpRequest:(YHttpRequest *)request
{
    YLogI(@"YHttpRequest:%@", request);
    id aObject = nil;
    NSInteger errorCode = kYActionMessage_Rustlt_Success;
    NSString *errorDescription = @"";
    if (0 == request.errorCode)
    {
        aObject = [ResultCommon modelObjectWithJSONData:request.responseData];
//        aObject = [self modelObjectWithJSONData:request.responseData];
        if ([aObject respondsToSelector:@selector(code)])
        {
            NSInteger code = (NSInteger)[(ResultCommon*)aObject code];
            errorDescription = ((ResultCommon*)aObject).message;
            
            if (kYActionMessage_Server_Token_Fail == code) {
                //Token失效
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Server_Token_Fail object:@{@"des":errorDescription}];
            }
            
            if (!(code == kYActionMessage_Server_Success))
            {
                errorCode = kYYServerErrorBase + labs(code);
            }
            	
            if (kYActionMessage_Rustlt_Success == errorCode)
            {
                //取出obj
                if (self != [ResultCommon class])
                {
                    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:nil];
                    NSDictionary *dataDicByKey = [self objectOrNilForKey:kCommonObj fromDictionary:dataDic];
                    if (nil != dataDicByKey) {
                        if ([dataDicByKey isKindOfClass:[NSArray class]])
                        {
                            NSArray *array = [self modelObjectArrayWithKeyValuesArray:(NSArray *)dataDicByKey];
                            aObject = array;
                        }
                        else
                        {
                            aObject = [self modelObjectWithKeyValues:dataDicByKey];
                        }
                    } else {
                        aObject = nil;
                    }
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
        if (YHTTPConnectionFailureErrorType == errorCode) {
            errorDescription = @"无网络连接";
        } else if (YHTTPRequestTimedOutErrorType == errorCode) {
            errorDescription = @"请求超时";
        }else {
            errorDescription = request.error.description;
        }
    }
    YActionMessage *message = [[YActionMessage alloc] initWithType:NSStringFromClass([self class])
                                                         errorCode:errorCode
                                                              desc:errorDescription
                                                            object:aObject];
    YLogI(@"Message:%@", message);
    return message;
}

#pragma mark - Helper Method
+ (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end