//
//  RemindManager.m
//  Component
//
//  Created by sheng on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "NoticeManager.h"
#import "NoticeAction.h"
@implementation NoticeManager
DEF_SINGLETON(NoticeManager);

-(void)getMyNoticeInfoWithLimiteStart:(NSInteger)limiteStart limiteEnd:(NSInteger)limiteEnd block:(ActionCompleteBlock)block
{
    NoticeAction *action = [[NoticeAction alloc]init];
    action.limiteStart = limiteStart;
    action.limiteEnd = limiteEnd;
    [YAction startAction:action completionBlock:^(YActionMessage *message) {
        block(message);
    }];
}

@end
