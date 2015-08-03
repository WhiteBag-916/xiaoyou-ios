//
//  YUtils.m
//  YFramework
//
//  Created by abc on 15/4/11.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YUtils.h"

@implementation YUtils
+ (NSString *)createUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);

    NSString *uuidValue = (__bridge_transfer NSString *) uuidStringRef;
    uuidValue = [uuidValue lowercaseString];
    uuidValue = [uuidValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return uuidValue;
}

@end
