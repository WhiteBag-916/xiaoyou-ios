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

-(void)isEnableToRelease
{

    if (_ActivityDateEndApplyText == nil || _ActivityDateBeginText == nil || _ActivityDateEndText == nil || _ActivityDesciptionText == nil || _ActivityNameText == nil || _ActivityPlaceText == nil || _ActivityTypeStr == nil)
    {
        NSDictionary * dic = @{@"isEnabel":@NO};
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Enabel_ReleaseBtn object:dic];
        return;
    }
    else
    {
        if ([_ActivityDateEndApplyText isEqualToString:@"请选择活动报名时间"] || [_ActivityDateBeginText isEqualToString:@"请选择活动开始时间"] || [_ActivityDateEndText isEqualToString:@"请选择活动结束时间"] || [_ActivityDesciptionText isEqualToString:@""] || [_ActivityNameText isEqualToString:@""] || [_ActivityPlaceText isEqualToString:@""] || [_ActivityTypeStr isEqualToString:@""])
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

@end
