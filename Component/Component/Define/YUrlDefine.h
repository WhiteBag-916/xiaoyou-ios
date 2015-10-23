//
//  YUrlDefine.h
//  Component
//
//  Created by abc on 15/4/17.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#ifndef Component_UrlDefine_h
#define Component_UrlDefine_h

#pragma mark - Common
/**********************************************************
 Url Define: Common
 **********************************************************/
/** https接口*/
#if 0
#define api_server_base_url @"http://release.xiaoyou.com/mobile"
#define UMENG_APPKEY @"55cda497e0f55ad43d00204c"
#define hx_AppKey            @"jiankun#xiaoyou"
#define hx_AppCertificate           @"xiaoyou_producation"
#else
#define api_server_base_url @"http://beta.xiaoyou.com:9081/mobile"
#define UMENG_APPKEY @"55cda7c3e0f55a0de40018c7"
#define hx_AppKey            @"jiankun#xiaoyoubeta"
#define hx_AppCertificate           @"xiaoyou_development_beta"
#endif

/** 获取图像接口*/
#define api_icon_base_url @"http://img.xiaoyou.com"
/**********************************************************
 Url Define: ProvisionManager
 **********************************************************/
//登录
#define api_user_login  @"/user/v2/login"
//注册
#define api_user_reg  @"/user/v2/reg"
//学校列表
#define api_login_schoolList  @"/school/schoolList"
//忘记密码
#define api_login_forgetPwd @"/user/v2/forgetPwd"
//标签
#define api_login_listTag @"/tag/listTag"
//上传头像
#define api_login_updateHeadPic @"/user/updateHeadPic"
//上传标签
#define api_login_addTag @"/user/v2/addTag"
//个人信息
#define api_login_profile @"/user/v2/profile"
//评论过我的人
#define api_login_myCommentPersons @"/user/v2/myCommentPersons"
//点赞过我的人
#define api_login_myPraisePersons @"/user/v2/myPraisePersons"
//认为我很酷的人
#define api_login_myCoolPersons @"/user/v2/myCoolPersons"
//修改签名
#define api_login_UpdateSelfIntro @"/user/v2/updateSelfIntro"
//退出登录
#define api_user_logOut  @"/user/v2/logout"
//注册须知
#define api_user_notice  @"/user/v2/notice"
//绑定手机号
#define api_login_ReceiveMobileAuthCode  @"/user/v2/verifyAuthCode"
//修改密码
#define api_login_ModifyPassword  @"/user/v2/modifyPassword"
//获取验证码
#define api_login_ReceiveAuthCode  @"/user/v2/receiveAuthCode"
//重置密码
#define api_login_resetPwd  @"/user/v2/resetPwd"

/**********************************************************
 Url Define: FeedManager
 **********************************************************/
//我的动态
#define api_feed_MyFeed @"/user/v2/userFeeds"
//动态详情
#define api_feed_DetailFeed @"/feed/detailFeed"
//动态列表
#define api_feed_ListFeed @"/feed/listFeed"
//上传feed图片
#define api_feed_UpdateImg @"/feed/updateImg"
//发送feed
#define api_feed_AddFeed @"/feed/addFeed"
//动态人列表
#define api_feed_FindFriendsByTags @"/feed/findFriendsByTags"
//feed敬酒
#define api_feed_addPraise @"/feed/addPraise"
//feed评论敬酒
#define api_feed_commonAddPraise @"/feed/comment/addPraise"
//feed提醒列表
#define api_alert_list @"/alert/list"
//动态评论
#define api_feed_addComment @"/feed/comment/addComment"
//回复评论
#define api_feed_addReply @"/feed/comment/addReply"
//评论列表
#define api_feed_listComment @"/feed/comment/listComment"
//删除关于一个feed的提醒
#define api_alert_readByFeed @"/alert/readByFeed"
//删除这个用户所有的提醒
#define api_alert_readAll @"/alert/readAll"
//社团搜索条件
#define api_group_groupConditions @"/group/groupConditions"
//社团列表
#define api_group_groupList @"/group/groupList"
//社团详情
#define api_group_groupDetailInfo @"/group/groupDetailInfo"
//社团feed列表
#define api_group_groupFeeds @"/group/groupFeeds"
//社团点赞
#define api_group_addPraise @"/group/addPraise"
//feed点赞人列表
#define api_feed_listPraisePeoples @"/feed/listPraisePeoples"
//Feed评论删除
#define api_feed_deleteComment @"/feed/comment/deleteComment"
//feed删除
#define api_feed_deleteFeed @"/feed/deleteFeed"

/**********************************************************
 Url Define: ContactManager
 **********************************************************/
//给别人点赞
#define api_contact_Praise @"/user/v2/praise"
//找朋友筛选条件
#define api_contact_FriendsCondition @"/user/v2/friendsCondition"
//找朋友
#define api_contact_FindFriends @"/user/v2/findFriends"
//同意加入群组
#define api_contact_AgreeApply @"/group/agreeApply"
//申请记录列表
#define api_contact_ApplyList @"/group/applyList"
//拒绝加入群组
#define api_contact_RejectApply @"/group/rejectApply"
//申请进入群组
#define api_contact_SubmitApply @"/group/submitApply"
//忽略进入群组
#define api_contact_IgnoreApplyList @"/group/ignoreApplyList"
//群组申请人员列表
#define api_contact_ApplicantList @"​/group/applicantList"
//获取申请列表
#define api_friend_GetApplyList @"/friend/getApplyList"
//发送好友申请
#define api_friend_SubmitFriendApply @"/friend/submitFriendApply"
//获取社团详情
#define api_group_GroupDetail @"/group/groupDetail"
//忽略申请列表
#define api_friend_IgnoreApplyList @"/friend/ignoreApplyList"
//同意好友申请
#define api_friend_AgreeApply @"/friend/agreeApply"
//删除联系人
#define api_user_delLinkMan @"/user/v2/delLinkMan"
//社长删除社团成员
#define api_group_deleteGroupUser @"/group/deleteGroupUser"
//社长邀请社团成员
#define api_group_addGroupUser @"/group/addGroupUser"
//屏蔽人列表
#define api_contact_forbiddenMeList @"/user/v2/forbiddenMeList"
//屏蔽他人
#define api_contact_forbiddenLinkMan @"/user/v2/forbiddenLinkMan"

/**********************************************************
 Url Define: MessageManager
 **********************************************************/
//聊天列表
#define api_message_list  @"/user/getsenderlist"
//联系人列表
#define api_contacts_list  @"/user/v2/listLinkMan"
//发送建议
#define api_suggest_list  @"/suggest/list?flag=groupManager"


/**********************************************************
 Url Define: Activity
 **********************************************************/
//提醒列表
#define api_remind_list     @"/user/getsenderlist"
#define api_schedule_list   @"/user/getschedulelist"
//查询当前用户相关的活动列表
#define api_activity_findActivityTypes   @"/activity/findActivityTypes"
//当前用户相关的活动列表接口
#define api_available_list   @"/activity/list"
//根据发布后的活动id查询发布后的活动信息
#define api_available_findByActivityPublishedId   @"/activity/findByActivityPublishedId"
//活动报名
#define api_available_enrollActivity   @"/activity/enrollActivity"
#endif

