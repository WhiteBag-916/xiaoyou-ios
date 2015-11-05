//
//  CodeManager.m
//  Component
//
//  Created by 尹先森 on 15/11/3.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CodeManager.h"
#import "ShopListAction.h"
#import "ShopListDetailAction.h"

@implementation CodeManager
DEF_SINGLETON(CodeManager);

//获取商家列表
- (void)getShopListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block
{
    ShopListAction *action = [[ShopListAction alloc]init];
    action.limitStart = limitStart;
    action.limitEnd = limitEnd;
    
    [YAction startAction:action completionBlock:^(YActionMessage *message) {
        block(message);
    }];
}
//扫码后商家详情
- (void)getByQRCodeContent:(NSString *) qrCodeContent block:(ActionCompleteBlock)block
{
    ShopListDetailAction *action = [[ShopListDetailAction alloc] init];
    action.qrCodeContent = qrCodeContent;
    
    [YAction startAction:action completionBlock:^(YActionMessage *message) {
        block(message);
    }];
}

@end
