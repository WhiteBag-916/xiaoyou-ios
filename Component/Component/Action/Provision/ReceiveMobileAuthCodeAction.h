//
//  ReceiveMobileAuthCodeAction.h
//  Component
//
//  Created by 熊宸 on 15/8/23.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface ReceiveMobileAuthCodeAction : YHTTPRequestAction<YAction>

@property (nonatomic, strong) NSString *mobilePhone;
@property (nonatomic, strong) NSString *authCode;

@end
