//
//  NSNull+InternalNullExtention.m
//  TestProject
//
//  Created by sheng on 15/12/12.
//  Copyright © 2015年 sheng. All rights reserved.
//

#import "NSNull+InternalNullExtention.h"


@implementation NSNull (InternalNullExtention)

//当前面两步都无法处理消息时，运行时系统便会给接收者最后一个机会，
//将其转发给其它代理对象来处理
- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([self respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:self];
    }
}

//设置代码签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:selector];
    if(sig == nil) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    return sig;
}


@end
