//
//  FreeBuildingListAction.m
//  Component
//
//  Created by 熊宸 on 15/10/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "FreeBuildingListAction.h"
#import "YUtils+Component.h"
#import "FreeBuildingListModel.h"

@implementation FreeBuildingListAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"schoolCode":[YShareData defaultData][kShareData_SchoolCode]} needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_room_freeBuildingList];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [FreeBuildingListModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
