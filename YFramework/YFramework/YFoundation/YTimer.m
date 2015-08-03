//
//  YTimer.m
//  YFramework
//
//  Created by abc on 15/4/16.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YTimer.h"

static NSMutableDictionary *Timers;

NSString *id2str(YTimerID timerID)
{
    return [NSString stringWithFormat:@"%d", timerID];
}

@implementation YTimer

+ (NSMutableDictionary *)Timers
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Timers = [[NSMutableDictionary alloc] init];
    });
    return Timers;
}

+ (YTimerID)addTimer:(NSTimer *)timer
{
    static YTimerID timerID = InvalideTimerID;
    @synchronized([self Timers])
    {
        timerID++;
        [self Timers][id2str(timerID)] = timer;
    }
    return timerID;
}

+ (void)killTimerWithID:(YTimerID)timerID
{
    @synchronized([self Timers])
    {
        NSTimer *timer = [self Timers][id2str(timerID)];
        if ([timer isValid])
        {
            [timer invalidate];
        }
        [[self Timers] removeObjectForKey:id2str(timerID)];
    }
}

+ (void)killAllTimers
{
    @synchronized([self Timers])
    {
        [[self Timers] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([(NSTimer *)obj isValid])
            {
                [(NSTimer *)obj invalidate];
            }
        }];
        
        [[self Timers] removeAllObjects];
    }
}

+ (void)executeBlock:(NSTimer *)inTimer
{
    if ([inTimer userInfo])
    {
        void (^block)() = (void (^)())[inTimer userInfo];
        block();
    }
}

+ (YTimerID)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval repeats:(BOOL)yesOrNo block:(void (^)())inBlock
{
    void (^block)() = [inBlock copy];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(executeBlock:) userInfo:block repeats:yesOrNo];
    return [self addTimer:timer];
}

@end
