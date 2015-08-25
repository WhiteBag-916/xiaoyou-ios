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

//点赞别人
- (void)praise:(NSString *)bePraiseId block:(ActionCompleteBlock)block;

//找人筛选
- (void)friendsCondition:(ActionCompleteBlock)block;

//找人
- (void)findFriends:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd conditionDic:(NSDictionary *)conditionDic block:(ActionCompleteBlock)block;

//申请进入群组
- (void)submitApply:(NSString *)groupId applicant:(NSString *)applicant block:(ActionCompleteBlock)block;

//拒绝加入群组
- (void)rejectApply:(NSString *)userId applyId:(NSString *)applyId block:(ActionCompleteBlock)block;

//申请记录列表
- (void)applyListApply:(NSString *)groupId userId:(NSString *)userId block:(ActionCompleteBlock)block;

//忽略申请列表
- (void)ignoreApplyList:(NSString *)userId applyIds:(NSString *)applyIds block:(ActionCompleteBlock)block;

//同意加入群组
- (void)agreeApply:(NSString *)userId applyId:(NSString *)applyId block:(ActionCompleteBlock)block;

@end
