//
//  ActivityReleaseDataManager.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/15.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityReleaseDataManager.h"

@interface ActivityReleaseDataManager ()

@end

@implementation ActivityReleaseDataManager

#pragma mark 实现单例
+(instancetype)shareActivityReleaseDataManager
{
    static ActivityReleaseDataManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ActivityReleaseDataManager alloc] init];
    });
    return manager;
}


- (void)isEnableToRelease
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
    
    if (![self.ActivityDateBeginText isEqualToString:@"请选择活动开始时间"] &&
        self.ActivityDateBeginText != nil &&
        ![self.ActivityDateEndText isEqualToString:@"请选择活动结束时间"] &&
        self.ActivityDateEndText != nil)
    {
        NSTimeInterval timeBetween1 =
        [[formatter dateFromString:self.ActivityDateEndText]
         timeIntervalSinceDate:[formatter dateFromString:self.ActivityDateBeginText]];
        if (timeBetween1 < 900)
        {
            NSDictionary * dic = @{@"isEnabel":@NO};
            [[NSNotificationCenter defaultCenter]
             postNotificationName:KNotification_Enabel_ReleaseBtn object:dic];
            [YUtils showTitle:@"活动时长不能小于15分钟" hideAfter:2];
        }
        else
        {
            if (![self.ActivityDateBeginText isEqualToString:@"请选择活动开始时间"] &&
                self.ActivityDateBeginText != nil)
            {
                NSTimeInterval timeBetween2 = [[formatter dateFromString:self.ActivityDateBeginText]
                                               timeIntervalSinceDate:[NSDate date]];
                if (timeBetween2 < 0)
                {
                    NSDictionary * dic = @{@"isEnabel":@NO};
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:KNotification_Enabel_ReleaseBtn object:dic];
                    [YUtils showTitle:@"活动开始时间要大于当前时间" hideAfter:2];
                }
                else
                {
                    if (_ActivityDateEndApplyText == nil ||
                        _ActivityDateBeginText == nil ||
                        _ActivityDateEndText == nil ||
                        _ActivityDesciptionText == nil ||
                        _ActivityNameText == nil ||
                        _ActivityPlaceText == nil ||
                        _ActivityTypeStr == nil)
                    {
                        NSDictionary * dic = @{@"isEnabel":@NO};
                        [[NSNotificationCenter defaultCenter]
                         postNotificationName:KNotification_Enabel_ReleaseBtn object:dic];
                        return;
                    }
                    else
                    {
                        if ([_ActivityDateEndApplyText isEqualToString:@"请选择活动报名时间"] ||
                            [_ActivityDateBeginText isEqualToString:@"请选择活动开始时间"] ||
                            [_ActivityDateEndText isEqualToString:@"请选择活动结束时间"] ||
                            [_ActivityDesciptionText isEqualToString:@""] ||
                            [_ActivityNameText isEqualToString:@""] ||
                            [_ActivityPlaceText isEqualToString:@""] ||
                            [_ActivityTypeStr isEqualToString:@""])
                        {
                            NSDictionary * dic = @{@"isEnabel":@NO};
                            [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Enabel_ReleaseBtn object:dic];
                            return;
                        }
                        else
                        {
                            NSDictionary * dic = @{@"isEnabel":@YES};
                            [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Enabel_ReleaseBtn object:dic];
                        }
                    }
                }
            }
            
        }
    }
    
}

@end
