//
//  RemindManager.m
//  Component
//
//  Created by sheng on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RemindManager.h"
#import "RemindAction.h"
@implementation RemindManager
DEF_SINGLETON(RemindManager);


-(void)getMyFeed:(NSString *)uid limitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block
{
    
    RemindAction *action = [[RemindAction alloc]init];
    [YAction startAction:action completionBlock:^(YActionMessage *message) {
        block(message);
    }];
    
}


@end
