//
//  ContactManager.h
//  Component
//
//  Created by 熊宸 on 15/7/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YManager.h"
#import "YAction.h"
#import "LinkManModel.h"

@interface ContactManager : YManager<YManager>
AS_SINGLETON(ContactManager);

- (void)getContactsListData:(ActionCompleteBlock)block;

- (void)saveContactsList:(LinkManModel *) model;

- (void)initLinkManListData;

- (LinkManModel *)getContactsListData;

//获取人详细信息
- (void)getUserDetailInfo:(NSString *)userID block:(ActionCompleteBlock)block;

@end
