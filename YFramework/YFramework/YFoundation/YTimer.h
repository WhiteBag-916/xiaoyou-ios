//
//  YTimer.h
//  YFramework
//
//  Created by abc on 15/4/16.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YObject.h"
#import "YObject.h"

#define InvalideTimerID     0
typedef void (^YTimerBlock)(void);
typedef int YTimerID;

/**
 *  @author Abc
 *
 *  NSTimer的Block版本,添加了统一管理Timer的功能
 */
@interface YTimer : YObject
/**
 *  @author Abc
 *
 *  功能同NStimer相同,主要参数跟NSTimer相同.
 *
 *  @param inBlock        定时执行Block
 *
 *  @return 定时器的id,通过该id可以关闭指定定时器.
 */
+ (YTimerID)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval repeats:(BOOL)yesOrNo
                                     block:(void (^)())inBlock;

/**
 *  @author Abc
 *
 *  根据timerID关闭一个定时器
 *
 *  @param timerID 调用 scheduledTimerWithTimeInterval 返回的id
 */
+ (void)killTimerWithID:(YTimerID)timerID;

/**
 *  @author Abc
 *
 *  停止由本类 scheduledTimerWithTimeInterval 启动的所有定时器.
 */
+ (void)killAllTimers;
@end
