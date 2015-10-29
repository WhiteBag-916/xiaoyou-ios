//
//  FreeBuildingDetailAction.m
//  Component
//
//  Created by 熊宸 on 15/10/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "FreeBuildingDetailAction.h"
#import "YUtils+Component.h"
#import "FreeBuildingDetailModel.h"

@implementation FreeBuildingDetailAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"schoolCode":[YShareData defaultData][kShareData_SchoolCode], @"buildName":_buildName} needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_room_freeBuildingDetail];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [FreeBuildingDetailModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
