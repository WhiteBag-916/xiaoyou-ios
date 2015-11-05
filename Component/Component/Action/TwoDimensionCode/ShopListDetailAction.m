//
//  ShopListDetailAction.m
//  Component
//
//  Created by 尹先森 on 15/11/4.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ShopListDetailAction.h"
#import "YUtils+Component.h"
#import "ShopList.h"

@implementation ShopListDetailAction

- (void)execute
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_qrCodeContent forKey:@"qrCodeContent"];
    NSDictionary *parameter = [YUtils getParameter:dic needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_supplier_shop_getByQRCodeContent];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ShopList actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}
@end
