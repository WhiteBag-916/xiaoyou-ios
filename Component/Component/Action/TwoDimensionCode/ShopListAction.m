//
//  ShopListAction.m
//  Component
//
//  Created by 尹先森 on 15/11/3.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ShopListAction.h"
#import "YUtils+Component.h"
#import "ShopList.h"

@implementation ShopListAction

- (void)execute
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@(_limitStart) forKey:@"limitStart"];
    [dic setObject:@(_limitEnd) forKey:@"limitEnd"];
    NSDictionary *parameter = [YUtils getParameter:dic needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_supplier_shop_findList];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ShopList actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
