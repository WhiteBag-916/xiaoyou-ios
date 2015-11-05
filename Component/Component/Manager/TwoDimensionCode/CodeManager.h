//
//  CodeManager.h
//  Component
//
//  Created by 尹先森 on 15/11/3.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YManager.h"
#import "YAction.h"
@interface CodeManager : YManager<YManager>
AS_SINGLETON(CodeManager);

/*********************************************************************
 函数名称 : getShopListLimitStart
 函数描述 : 获取商家列表
 参数 : limitStart：开始
 limitEnd：结束
 返回值 : return：ShopList
 作者 : yinhui
 *********************************************************************/
- (void)getShopListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : getByQRCodeContent
 函数描述 : 扫码后商家详情
 参数 : limitStart：开始
 limitEnd：结束
 返回值 : return：ShopList
 作者 : yinhui
 *********************************************************************/
- (void)getByQRCodeContent:(NSString *) qrCodeContent block:(ActionCompleteBlock)block;

@end
