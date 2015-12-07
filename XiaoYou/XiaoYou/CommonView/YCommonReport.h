//
//  YCommonReport.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/27.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCommonReport : NSObject
+ (void)reportWithType:(NSString *)type andData:(NSDictionary *)data;
@end
