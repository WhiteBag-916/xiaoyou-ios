
//
//  NotifyInfoModel.m
//  Model
//
//  Created by sheng on 15/11/3.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "NotifyInfoModel.h"
#import "YShareData.h"
#import "YShareDataDefine.h"

@implementation NotifyInfoModel

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.em_push_title = dict[@"em_apns_ext"][@"em_push_title"];
        self.timestamp = [dict[@"timestamp"] doubleValue];
        self.isRead = @"NO";
        self.type = [[dict valueForKey:@"type"] integerValue];
        self.idStr = dict[@"id"];
        self.name = dict[@"name"];
        self.startTime = [dict[@"startTime"] doubleValue];
        self.headIcon = dict[@"headIcon"];
        self.organizer = dict[@"organizer"];
        self.uid = [[YShareData defaultData] valueForKey:kShareData_UserID];
        if (self.em_push_title == nil) {
            self.em_push_title = dict[@"contentTxt"];
        }
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return self;
}


//notiInfo.em_push_title = dict[@"em_apns_ext"][@"em_push_title"];
//notiInfo.timestamp = [dict[@"timestamp"] doubleValue];
//notiInfo.isRead = @"NO";
//notiInfo.type = [[dict valueForKey:@"type"] integerValue];
//notiInfo.idStr = dict[@"id"];
//notiInfo.name = dict[@"name"];
//notiInfo.startTime = [dict[@"startTime"] doubleValue];
//notiInfo.headIcon = dict[@"headIcon"];
//notiInfo.organizer = dict[@"organizer"];
//notiInfo.uid = [[YShareData defaultData] valueForKey:kShareData_UserID];
//
//if (notiInfo.em_push_title == nil) {
//    notiInfo.em_push_title = dict[@"contentTxt"];
//}

@end
