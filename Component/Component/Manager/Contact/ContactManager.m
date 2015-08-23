//
//  ContactManager.m
//  Component
//
//  Created by 熊宸 on 15/7/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ContactManager.h"
#import "YFoundation.h"
#import "ContactsListAction.h"
#import "YShareDataDefine.h"
#import "YManagerCenter.h"
#import "MessageListAction.h"
#import "YDirectory+Data.h"
#import "LinkManModel.h"


#define kContactsManagerSyncQueue @"kContactsManagerSyncQueue"


@interface ContactManager ()

@property (nonatomic, strong) LinkManModel *linkManModel; //个人信息

@end

@implementation ContactManager

DEF_SINGLETON(ContactManager);

- (instancetype)init
{
    if (self == [super init]) {
    }
    return self;
}

//存储联系人到本地
- (void)saveContactsList
{
    //存文件
    NSString *cachePath = [[YDirectory fileCache] stringByAppendingString:NSStringFromClass([LinkManModel class])];
    [_linkManModel writeToFile:cachePath];
}
//读取联系人
- (void)initLinkManListData{
    NSString *cachePath = [[YDirectory fileCache] stringByAppendingString:NSStringFromClass([LinkManModel class])];
    _linkManModel = [LinkManModel instanceWithFile:cachePath];
}

-(void)getContactsListData:(ActionCompleteBlock)block
{
    ContactsListAction * action = [[ContactsListAction alloc] init];
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //子线程处理数据
        [YQueue dispatchInSyncQueueWithQueueType:kContactsManagerSyncQueue block:^{
            if (message.isSuccess)
            {
                
            }
            
            //主线程处理界面
            [YQueue dispatchInMainQueueWithBlock:^{
                block(message);
            }];
        }];
    }];
}

- (void)initSource
{
    [YQueue registerSyncQueueWithType:kContactsManagerSyncQueue];
}
- (void)clearSource
{
    [YQueue unregisterSyncQueueWithType:kContactsManagerSyncQueue];

}

- (void)appDidLogin:(NSDictionary *)loginInfo
{
    
}

- (void)appDidLogout
{
    
}

@end
