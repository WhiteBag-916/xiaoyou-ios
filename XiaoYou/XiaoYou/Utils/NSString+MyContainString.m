//
//  NSString+MyContainString.m
//  XiaoYou
//
//  Created by sheng on 15/10/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "NSString+MyContainString.h"

@implementation NSString (MyContainString)

//-(BOOL)containsString:(NSString *)str
//{
//    return [self myContainsString:str];
//}


-(BOOL)myContainsString:(NSString*)other {
    NSRange range = [self rangeOfString:other];
    return range.length != 0;
}

@end
