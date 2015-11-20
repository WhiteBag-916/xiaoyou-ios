//
//  YObject+Ext.m
//  XiaoYou
//
//  Created by sheng on 15/11/20.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YObject+Ext.h"

@implementation YObject (Ext)

+(void)isElement:(id)element InArray:(NSArray *)array sucessed:(void (^)())successedBlock failed:(void (^)())failedBlock
{
    NSSet *arrSets = [NSSet setWithArray:array];
    if ([arrSets containsObject:element]) {
        YLogD(@"包含111");
        successedBlock != nil ? successedBlock() : 0;
    } else {
        YLogD(@"不包含222");
        failedBlock != nil ? failedBlock() : 0;
    }
}


@end
