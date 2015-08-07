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
#else
#define api_server_base_url @"http://beta.xiaoyou.com"
#endif
/** 获取图像接口*/
#define api_icon_base_url @"http://101.200.188.100:8080"

/**********************************************************
 Url Define: ProvisionManager
 **********************************************************/
//登录
#define api_user_login  @"/mobile/user/login"

/**********************************************************
 Url Define: AssistantManager
 **********************************************************/

/**********************************************************
 Url Define: ContactManager
 **********************************************************/

/**********************************************************
 Url Define: MessageManager
 **********************************************************/
//聊天列表
#define api_message_list  @"/mobile/user/getsenderlist"
#endif

