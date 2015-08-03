//
//  YUtils.h
//  YFramework
//
//  Created by abc on 15/4/11.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YUtils+Macros.h"

/**
 *  @author Abc
 *
 *  公共方法,同类功能方法如果超过三个,请建立单独类移到YFoundation下.
 */
@interface YUtils : NSObject

/**
 *  @author Abc
 *
 *  创建UUID
 *
 *  @return UUID
 */
+ (NSString *)createUUID;

@end
