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
#import "ProfileAction.h"
#import "PraiseAction.h"
#import "FindFriendsAction.h"
#import "FriendsConditionAction.h"
#import "SubmitApplyAction.h"
#import "RejectApplyAction.h"
#import "ApplyListAction.h"
#import "IgnoreApplyListAction.h"
#import "AgreeApplyAction.h"
#import "ApplicantListAction.h"
#import "GetFriendApplyListAction.h"
#import "AgreeFriendApplyAction.h"
#import "SubmitFriendApplyAction.h"
#import "GroupDetailAction.h"
#import "IgnoreFriendApplyAction.h"

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

//获取人详细信息,ProfileInfo
- (void)getUserDetailInfo:(NSString *)userID block:(ActionCompleteBlock)block {
    ProfileAction* action = [[ProfileAction alloc] init];
    action.userID = userID;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//点赞别人
- (void)praise:(NSString *)bePraiseId block:(ActionCompleteBlock)block {
    PraiseAction* action = [[PraiseAction alloc] init];
    action.bePraiseId = bePraiseId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//获取找人筛选条件
- (void)friendsCondition:(ActionCompleteBlock)block {
    FriendsConditionAction* action = [[FriendsConditionAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//找人
- (void)findFriends:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd conditionDic:(NSDictionary *)conditionDic block:(ActionCompleteBlock)block {
    FindFriendsAction* action = [[FindFriendsAction alloc] init];
    action.condition = [NSDictionary dictionaryWithDictionary:conditionDic];
    action.limitStart = limitStart;
    action.limitEnd = limitEnd;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//申请进入群组
- (void)submitApply:(NSString *)groupId block:(ActionCompleteBlock)block {
    SubmitApplyAction* action = [[SubmitApplyAction alloc] init];
    action.groupId = groupId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//拒绝加入群组
- (void)rejectApply:(NSString *)applyId block:(ActionCompleteBlock)block {
    RejectApplyAction* action = [[RejectApplyAction alloc] init];
    action.applyId = applyId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//申请记录列表,ApplicantList
- (void)applyListApply:(NSString *)groupId block:(ActionCompleteBlock)block {
    ApplyListAction* action = [[ApplyListAction alloc] init];
    action.groupId = groupId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//忽略申请列表
- (void)ignoreApplyList:(NSString *)applyIds block:(ActionCompleteBlock)block {
    IgnoreApplyListAction* action = [[IgnoreApplyListAction alloc] init];
    action.applyIds = applyIds;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//同意加入群组
- (void)agreeApply:(NSString *)applyId block:(ActionCompleteBlock)block {
    AgreeApplyAction* action = [[AgreeApplyAction alloc] init];
    action.applyId = applyId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//群组申请人员列表
- (void)applicantList:(NSString *)groupId block:(ActionCompleteBlock)block {
    ApplicantListAction* action = [[ApplicantListAction alloc] init];
    action.groupId = groupId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//获取申请列表,ApplicantList
- (void)getFriendApplyList:(ActionCompleteBlock)block {
    GetFriendApplyListAction* action = [[GetFriendApplyListAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//同意好友申请
- (void)agreeFriendApply:(NSString *)applyId block:(ActionCompleteBlock)block {
    AgreeFriendApplyAction* action = [[AgreeFriendApplyAction alloc] init];
    action.applyId = applyId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//发送好友申请
- (void)submitFriendApply:(NSString *)targetId block:(ActionCompleteBlock)block {
    SubmitFriendApplyAction* action = [[SubmitFriendApplyAction alloc] init];
    action.targetId = targetId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//忽略好友申请
- (void)ignoreFriendApply:(NSString *)applyIds block:(ActionCompleteBlock)block {
    IgnoreFriendApplyAction* action = [[IgnoreFriendApplyAction alloc] init];
    action.applyIds = applyIds;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//获取群组详情
- (void)groupDetail:(NSString *)groupId block:(ActionCompleteBlock)block {
    GroupDetailAction* action = [[GroupDetailAction alloc] init];
    action.groupId = groupId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

@end
