//
//  MessageManager.h
//  Component
//
//  Created by 熊宸 on 15/7/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YManager.h"
#import "YAction.h"

@interface MessageManager : YManager<YManager>
AS_SINGLETON(MessageManager);


- (void)getMessageListData:(ActionCompleteBlock)block;



@end
