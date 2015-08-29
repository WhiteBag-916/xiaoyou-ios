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
#import "LinkManList.h"

@interface ContactManager : YManager<YManager>
AS_SINGLETON(ContactManager);

- (void)getContactsListData:(ActionCompleteBlock)block;

- (void)saveContactsList:(LinkManModel *) model;

- (void)initLinkManListData;

- (LinkManModel *)getContactsListData;

//获取人详细信息
- (void)getUserDetailInfo:(NSString *)userID block:(ActionCompleteBlock)block;

//点赞别人
- (void)praise:(NSString *)bePraiseId block:(ActionCompleteBlock)block;

//找人筛选
- (void)friendsCondition:(ActionCompleteBlock)block;

//找人
- (void)findFriends:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd conditionDic:(NSDictionary *)conditionDic block:(ActionCompleteBlock)block;

//申请进入群组
- (void)submitApply:(NSString *)groupId block:(ActionCompleteBlock)block;

//拒绝加入群组
- (void)rejectApply:(double)applyId block:(ActionCompleteBlock)block;

//申请记录列表
- (void)applyListApply:(NSString *)groupId block:(ActionCompleteBlock)block;

//忽略申请列表
- (void)ignoreApplyList:(NSString *)applyIds block:(ActionCompleteBlock)block;

//同意加入群组
- (void)agreeApply:(double)applyId block:(ActionCompleteBlock)block;

//群组申请人员列表
- (void)applicantList:(NSString *)groupId block:(ActionCompleteBlock)block;

//获取申请列表
- (void)getFriendApplyList:(ActionCompleteBlock)block;

//同意好友申请
- (void)agreeFriendApply:(double)applyId block:(ActionCompleteBlock)block;

//发送好友申请
- (void)submitFriendApply:(NSString *)targetId block:(ActionCompleteBlock)block;

//忽略好友申请
- (void)ignoreFriendApply:(NSString *)applyIds block:(ActionCompleteBlock)block;

//获取群组详情
- (void)groupDetail:(NSString *)groupId block:(ActionCompleteBlock)block;

//删除联系人
- (void)delLinkMan:(NSString *)delUids block:(ActionCompleteBlock)block;

//社长删除社团成员
- (void)deleteGroupUser:(NSString *)groupId deleteUserIds:(NSString *)deleteUserIds block:(ActionCompleteBlock)block;
//社长邀请成员
- (void)addGroupUser:(NSString *)groupId addUserIds:(NSString *)addUserIds block:(ActionCompleteBlock)block;

//是否为好友
- (BOOL)isFriendRelationShip:(NSString *) uid;

//获取好友详情
- (LinkManList *)getFriendInfo:(NSString *) uid;

@end
