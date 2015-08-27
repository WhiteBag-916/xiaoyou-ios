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
#import "FindFriendsAction.h"
#import "FriendsConditionAction.h"
#import "ApplyListAction.h"
#import "ApplicantListAction.h"
#import "GetFriendApplyListAction.h"
#import "GroupDetailAction.h"
#import "CommonAction.h"
#import "YUtils+Component.h"
#import "LinkManList.h"

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
    CommonAction* action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"bePraiseId":bePraiseId} needUserToken:YES];
    action.url = [YUtils getUrl:api_contact_Praise];
    
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
    CommonAction* action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"groupId":groupId} needUserToken:YES needAddUserID:YES];
    action.url = [YUtils getUrl:api_contact_SubmitApply];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//拒绝加入群组
- (void)rejectApply:(NSString *)applyId block:(ActionCompleteBlock)block {
    CommonAction* action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"applyId":applyId} needUserToken:YES needAddUserID:YES];
    action.url = [YUtils getUrl:api_contact_RejectApply];
    
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
    CommonAction* action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"applyIds":applyIds} needUserToken:YES needAddUserID:YES];
    action.url = [YUtils getUrl:api_contact_IgnoreApplyList];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//同意加入群组
- (void)agreeApply:(NSString *)applyId block:(ActionCompleteBlock)block {
    CommonAction* action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"applyId":applyId} needUserToken:YES needAddUserID:YES];
    action.url = [YUtils getUrl:api_contact_AgreeApply];
    
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
    CommonAction* action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"applyId":applyId} needUserToken:YES needAddUserID:YES];
    action.url = [YUtils getUrl:api_friend_AgreeApply];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//发送好友申请
- (void)submitFriendApply:(NSString *)targetId block:(ActionCompleteBlock)block {
    CommonAction* action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"targetId":targetId} needUserToken:YES needAddUserID:YES];
    action.url = [YUtils getUrl:api_friend_SubmitFriendApply];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//忽略好友申请
- (void)ignoreFriendApply:(NSString *)applyIds block:(ActionCompleteBlock)block {
    CommonAction* action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"applyIds":applyIds} needUserToken:YES needAddUserID:YES];
    action.url = [YUtils getUrl:api_friend_IgnoreApplyList];
    
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

//删除联系人
- (void)delLinkMan:(NSString *)delUids block:(ActionCompleteBlock)block {
    [self delLocalLinkManByUid:delUids];
    CommonAction* action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"delUids":delUids} needUserToken:YES];
    action.url = [YUtils getUrl:api_user_delLinkMan];

    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

-(void)delLocalLinkManByUid:(NSString *) delUids
{
    LinkManModel * linkManModel = [[ContactManager sharedInstance] getContactsListData];
    NSMutableArray * contactsArr = [[NSMutableArray alloc] initWithArray:linkManModel.linkManList];
    for (LinkManList * obj in contactsArr)
    {
        if ([delUids isEqualToString:obj.uid])
        {
            [contactsArr removeObject:obj];
            break;
        }
    }
    
    linkManModel.linkManList = [[NSArray alloc] initWithArray:contactsArr];
    
    [[ContactManager sharedInstance] saveContactsList:linkManModel];
}

//社长删除社团成员
- (void)deleteGroupUser:(NSString *)groupId deleteUserIds:(NSString *)deleteUserIds block:(ActionCompleteBlock)block {
    CommonAction* action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"groupId":groupId, @"deleteUserIds":deleteUserIds} needUserToken:YES];
    action.url = [YUtils getUrl:api_group_deleteGroupUser];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//是否为好友
- (BOOL)isFriendRelationShip:(NSString *) uid
{
    LinkManModel * linkManModel = [[ContactManager sharedInstance] getContactsListData];
    for (int i = 0; i < linkManModel.linkManList.count; i ++)
    {
        LinkManList * model = linkManModel.linkManList[i];
        if ([uid isEqualToString:model.uid])
        {
            return YES;
        }
    }
    
    return NO;
}

//获取好友详情
- (LinkManList *)getFriendInfo:(NSString *) uid
{
    LinkManModel * linkManModel = [[ContactManager sharedInstance] getContactsListData];
    for (int i = 0; i < linkManModel.linkManList.count; i ++)
    {
        LinkManList * model = linkManModel.linkManList[i];
        if ([uid isEqualToString:model.uid])
        {
            return model;
        }
    }
    
    return nil;
}

@end
