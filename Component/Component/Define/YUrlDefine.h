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
#define api_server_base_url @"http://api.xiaoyou.com"
#define UMENG_APPKEY @"55cda497e0f55ad43d00204c"
#else
#define api_server_base_url @"http://beta.xiaoyou.com"
#define UMENG_APPKEY @"55cda7c3e0f55a0de40018c7"
#endif
/** 获取图像接口*/
#define api_icon_base_url @"http://img.xiaoyou.com"
/**********************************************************
 Url Define: ProvisionManager
 **********************************************************/
//登录
#define api_user_login  @"/mobile/user/v2/login"
//学校列表
#define api_login_schoolList  @"/mobile/school/schoolList"
//获取验证码
#define api_login_receiveAuthCode  @"/mobile/user/receiveAuthCode"
//验证
#define api_login_phoneVerify @"/mobile/user/verify"
//忘记密码
#define api_login_forgetPwd @"/mobile/user/v2/forgetPwd"
//标签
#define api_login_listTag @"/mobile/tag/listTag"
//上传头像
#define api_login_updateHeadPic @"/mobile/user/updateHeadPic"
//上传标签
#define api_login_addTag @"/mobile/user/v2/addTag"
//个人信息
#define api_login_profile @"/mobile/user/v2/profile"

/**********************************************************
 Url Define: FeedManager
 **********************************************************/

/**********************************************************
 Url Define: ContactManager
 **********************************************************/

/**********************************************************
 Url Define: MessageManager
 **********************************************************/
//聊天列表
#define api_message_list  @"/mobile/user/getsenderlist"
//联系人列表
#define api_contacts_list  @"/mobile/user/linkManList"

#endif

