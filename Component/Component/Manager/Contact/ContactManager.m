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
- (void)saveContactsList:(LinkManModel *) model
{
    //存文件
    _linkManModel = model;
    NSString *cachePath = [[YDirectory fileCache] stringByAppendingString:NSStringFromClass([LinkManModel class])];
    [_linkManModel writeToFile:cachePath];
}
//读取联系人
- (void)initLinkManListData
{
    NSString *cachePath = [[YDirectory fileCache] stringByAppendingString:NSStringFromClass([LinkManModel class])];
    _linkManModel = [LinkManModel instanceWithFile:cachePath];

}

- (LinkManModel *)getContactsListData
{
    return _linkManModel;
}

-(void)getContactsListData:(ActionCompleteBlock)block
{
    ContactsListAction * action = [[ContactsListAction alloc] init];
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //子线程处理数据
        [YQueue dispatchInSyncQueueWithQueueType:kContactsManagerSyncQueue block:^{
            if (message.isSuccess)
            {
                [self saveContactsList:message.object];
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
    [self initLinkManListData];
}

- (void)appDidLogout
{
    //删除文件
    NSString *cachePath = [[YDirectory fileCache] stringByAppendingString:NSStringFromClass([LinkManModel class])];
    [YDirectory removeFolders:cachePath];
}

@end
