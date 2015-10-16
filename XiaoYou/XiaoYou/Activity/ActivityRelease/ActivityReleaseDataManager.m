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

    if (_ActivityDateBeginText == nil || _ActivityDateEndText == nil || _ActivityDesciptionText == nil || _ActivityNameText == nil || _ActivityPlaceText == nil || _ActivityTypeStr == nil)
    {
        NSDictionary * dic = @{@"isEnabel":@NO};
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Enabel_ReleaseBtn object:dic];
        return;
    }
    else
    {
        if ([_ActivityDateBeginText isEqualToString:@"点击后可以选择时间"] || [_ActivityDateEndText isEqualToString:@"点击后可以选择时间"] || [_ActivityDesciptionText isEqualToString:@""] || [_ActivityNameText isEqualToString:@""] || [_ActivityPlaceText isEqualToString:@""] || [_ActivityTypeStr isEqualToString:@""])
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
