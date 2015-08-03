//
//  YActionMessage.m
//  YFramework
//
//  Created by abc on 15/4/17.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YActionMessage.h"

@implementation YActionMessage
- (instancetype)initWithType:(NSString *)type errorCode:(NSInteger)code desc:(NSString *)desc object:(id)object
{
    if (self = [super init])
    {
        self.type = type;
        self.errorCode = code;
        self.desc = desc;
        self.object = object;
    }
    return self;
}

- (NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"{type:%@,code:%ld,desc:%@,object:%@}",
                                                self.type, (long) self.errorCode, self.desc, self.object];

    return desc;
}

- (BOOL)isSuccess
{
    return (self.errorCode == kYActionMessage_Rustlt_Success);
}

- (BOOL)isLocalError
{
    return (!self.isSuccess && self.errorCode < YHTTPCompressionErrorMax);
}

- (BOOL)isServerError
{
    return (!self.isSuccess && self.errorCode > YHTTPCompressionErrorMax);
}
@end
