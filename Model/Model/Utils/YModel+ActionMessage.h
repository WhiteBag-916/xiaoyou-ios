//
//  YModel+ActionMessage.h
//  Component
//
//  Created by abc on 15/5/1.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YActionMessage.h"
#import "YFoundation.h"
#import "YHttpRequest.h"

#define kNotification_Server_Token_Fail  @"kNotification_Server_Token_Fail"//token失效

@interface YModel (ActionMessage)
+ (YActionMessage *)actionMessageWithHttpRequest:(YHttpRequest *)request;
@end

@protocol YModelActionMessage <NSObject>
@required
- (double)code;
@optional
- (NSString *)msg;
@end
