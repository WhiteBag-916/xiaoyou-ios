//
//  RemindManager.h
//  Component
//
//  Created by sheng on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YManager.h"
#import "YAction.h"
@interface NoticeManager : YManager<YManager>
AS_SINGLETON(NoticeManager);

/*********************************************************************
 函数名称 : getMyFeed
 函数描述 : 获取我的提醒
 返回值 : N/A
 作者 : sheng
*********************************************************************/

-(void)getMyNoticeInfoWithLimiteStart:(NSInteger)limiteStart limiteEnd:(NSInteger)limiteEnd block:(ActionCompleteBlock)block;

@end
