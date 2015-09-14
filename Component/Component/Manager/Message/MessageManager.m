//
//  MessageManager.m
//  Component
//
//  Created by 熊宸 on 15/7/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "MessageManager.h"
#import "YFoundation.h"
#import "MessageListAction.h"
#import "YShareDataDefine.h"
#import "YManagerCenter.h"
#import "EaseMob.h"
#import "YNotificationDefine.h"
#import "EMErrorDefs.h"
#import <AudioToolbox/AudioToolbox.h>
#import "EMTextMessageBody.h"
#import "YSystemDefine.h"
#import "EMConversation.h"
#import "ProvisionManager.h"
#import "YModel+ActionMessage.h"
#import "ContactManager.h"
#import "EMTextMessageBody.h"
#import "SuggestListAction.h"


#define kMessageManagerSyncQueue @"kMessageManagerSyncQueue"
//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";

NSString *const KSYSTEM_MESSAGEID = @"100001";//系统消息
NSString *const KFRIEND_APPLYID = @"100002";//好友申请
NSString *const KGROUP_APPLYID = @"100003";//社团申请，ID累加


@interface MessageManager ()<EMChatManagerDelegate>

@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@property (nonatomic, strong) NSMutableArray *grouArray;//现有的group
@property (nonatomic, strong) NSMutableArray *forbiddenGroupArray;//屏蔽的群

@end

@implementation MessageManager

DEF_SINGLETON(MessageManager);

- (instancetype)init
{
    if (self = [super init]) {
        _grouArray = [NSMutableArray array];
        _forbiddenGroupArray = [NSMutableArray array];
    }
    return self;
}


- (void)getMessageListData:(ActionCompleteBlock)block
{
    MessageListAction * action = [[MessageListAction alloc] init];
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //子线程处理数据
        [YQueue dispatchInSyncQueueWithQueueType:kMessageManagerSyncQueue block:^{
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

//获取发送建议
- (void)getSuggestList:(ActionCompleteBlock)block
{
    SuggestListAction * action = [[SuggestListAction alloc] init];
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //子线程处理数据
        [YQueue dispatchInSyncQueueWithQueueType:kMessageManagerSyncQueue block:^{
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
    //注册一个同步队列,用于同步执行流程或者维护缓存数据(sqlite缓存或者内存缓存)
    [YQueue registerSyncQueueWithType:kMessageManagerSyncQueue];
}
- (void)clearSource
{
    [YQueue unregisterSyncQueueWithType:kMessageManagerSyncQueue];
}

-(void)registerNotifications
{
    [self unregisterNotifications];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)appDidLogin:(NSDictionary *)loginInfo
{
    [self registerNotifications];
    [self loginEaseMob];
}

- (void)appDidLogout:(NSDictionary *)logoutInfo
{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:[logoutInfo[@"logoutBySelf"] boolValue] completion:^(NSDictionary *info, EMError *error) {
        if (!error && info) {
            NSLog(@"退出成功");
        }
    } onQueue:nil];
}

- (void)loginEaseMob {
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[NSString stringWithFormat:@"%@_%@",[YShareData defaultData][kShareData_SchoolCode],[YShareData defaultData][kShareData_StudentNo]] password:[NSString stringWithFormat:@"%@_%@",[YShareData defaultData][kShareData_SchoolCode],[YShareData defaultData][kShareData_StudentNo]] completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            YLogD(@"登陆成功");
        
            //取群组id，进行管理
            [self initGroupIdArray];
            
            //获取屏蔽群组的id
            self.forbiddenGroupArray = [[[EaseMob sharedInstance].chatManager ignoredGroupIds] mutableCopy];
            
            //避免插入过晚
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self updateMessage];
            });
            
        } else if (nil != error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Refresh_Message object:nil userInfo:@{kNotification_Request_Error:error}];
        }
    } onQueue:nil];
}

- (void)initGroupIdArray {
    NSMutableArray *conversations = [[NSMutableArray alloc] initWithArray:[[EaseMob sharedInstance].chatManager conversations]];
    NSMutableArray *groupIdArray = [@[] mutableCopy];
    [conversations enumerateObjectsUsingBlock:^(EMConversation *obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *ext = obj.latestMessage.ext;
        if (GROUP_APPLY == [ext[@"type"] integerValue]) {
            //群组
            [groupIdArray addObject:obj.chatter];
            
            [_grouArray addObject:@{@"group_id":ext[@"group_id"], @"chatter": obj.chatter}];
        }
    }];
}

- (BOOL)processReceiveCmdMessage:(EMMessage *)cmdMessage {
    BOOL needRefresh = NO;
    
    //解析
    NSDictionary *ext = cmdMessage.ext;
    if ([ext[@"server_flag"] boolValue])
    {
        switch ([ext[@"type"] integerValue])
        {
            case FORBIDDEN_ME:
            {
                [[ContactManager sharedInstance] addForbiddenMeListByID:ext[@"em_apns_ext"][@"em_push_title"]];
                break;
            }
            case UNFORBIDDEN_ME:
            {
                [[ContactManager sharedInstance] delForbiddenMeListByID:ext[@"em_apns_ext"][@"em_push_title"]];
                break;
            }
            case KICKGROUP:
            {
                NSString *groupCode = ext[@"em_apns_ext"][@"em_push_title"];
                NSString *groupName = [[ProvisionManager sharedInstance] delQueryCodesByGroupCode:groupCode];
                NSString *thirdCode = [[ContactManager sharedInstance] delClassListByGroupCode:groupName];
                //删除会话刷新界面
                if (thirdCode.length > 0) {
                    [[EaseMob sharedInstance].chatManager removeConversationByChatter:thirdCode deleteMessages:YES append2Chat:NO];
                    needRefresh = YES;
                }
                break;
            }
            case DELETEUSER:
            {
                NSString *thirdCode = ext[@"em_apns_ext"][@"em_push_title"];
                
                BOOL isDel = [[ContactManager sharedInstance] delUserByThirdCode:thirdCode];
                if (isDel) {
                    [[EaseMob sharedInstance].chatManager removeConversationByChatter:thirdCode deleteMessages:YES append2Chat:NO];
                    needRefresh = YES;
                }
                
                break;
            }
            default:
            {
                
                break;
            }
        }
    }
    
    return needRefresh;
}

-(void)didReceiveCmdMessage:(EMMessage *)cmdMessage
{
    //子线程处理数据
    [YQueue dispatchInSyncQueueWithQueueType:kMessageManagerSyncQueue block:^{
        BOOL needRefresh = [self processReceiveCmdMessage:cmdMessage];
        
        //主线程处理界面
        [YQueue dispatchInMainQueueWithBlock:^{
            if (needRefresh) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Refresh_Message object:nil userInfo:nil];
            }
        }];
    }];
}

//删除会话
- (void)delConversationByChatter:(NSString *)chatter {
    [[EaseMob sharedInstance].chatManager removeConversationByChatter:chatter deleteMessages:YES append2Chat:NO];
}

//设置群消息不提醒
- (void)forbiddenGroupByThirdCode:(NSString *)thirdCode block:(ForbiddenGroupBlock)block {
    BOOL isForbidden = [self isForbiddenGroupByThirdCode:thirdCode];
    [[EaseMob sharedInstance].chatManager asyncIgnoreGroupPushNotification:thirdCode isIgnore:!isForbidden completion:^(NSArray *ignoreGroupsList, EMError *error) {
        BOOL isSuccess = NO;
        if (!error) {
            self.forbiddenGroupArray = [ignoreGroupsList mutableCopy];
            isSuccess = YES;
        }
        block(isSuccess);
    } onQueue:nil];
}

//判断是否已屏蔽
- (BOOL)isForbiddenGroupByThirdCode:(NSString *)thirdCode {
    __block BOOL isForbidden = NO;
    
    [_forbiddenGroupArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([thirdCode isEqualToString:obj]) {
            isForbidden = YES;
            
            *stop = YES;
        }
    }];
    
    return isForbidden;
}

//更新会话
- (void)updateMessage {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Refresh_Message object:nil userInfo:nil];
    
    [self setupUnreadMessageCount];
}

//会话列表信息更新时的回调
- (void)didUpdateConversationList:(NSArray *)conversationList {
    //过滤信息，避免产生服务器数据
    NSString *schoolCode = [YShareData defaultData][kShareData_SchoolCode];
    if (schoolCode.length > 0) {
        NSString *schoolId = [NSString stringWithFormat:@"school_%@_1", schoolCode];
        [conversationList enumerateObjectsUsingBlock:^(EMConversation *obj, NSUInteger idx, BOOL *stop) {
            if ([obj.chatter isEqualToString:schoolId])
            {
                //数据未转义，取出来数据重新转义
                NSArray *messageArray = [obj loadAllMessages];
                if (messageArray.count > 0) {
                    [self resetErrorMessageArray:messageArray];
                }
                *stop = YES;
            }
        }];
    }
}

- (void)resetErrorMessageArray:(NSArray *)messageArray {
    //子线程处理数据
    [YQueue dispatchInSyncQueueWithQueueType:kMessageManagerSyncQueue block:^{
        [messageArray enumerateObjectsUsingBlock:^(EMMessage *obj, NSUInteger idx, BOOL *stop) {
            [self resetMessage:obj];
        }];
        
        //主线程处理界面
        [YQueue dispatchInMainQueueWithBlock:^{
            [self updateMessage];
        }];
    }];
}

- (BOOL)resetMessage:(EMMessage *)message {
    NSDictionary *ext = message.ext;
    BOOL needReload = NO;
    BOOL needRefresh = NO;
    
    if ([ext[@"server_flag"] boolValue])
    {
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:message.conversationChatter deleteMessages:YES append2Chat:NO];
        
        switch ([ext[@"type"] integerValue])
        {
            case SYSTEM_MESSAGE: {
                YLogD(@"系统消息推送");
                
                message.conversationChatter = KSYSTEM_MESSAGEID;
                message.from = KSYSTEM_MESSAGEID;
                
                needRefresh = YES;
                needReload = YES;
                
                if (nil != ext[@"group_id"]) {
                    //如果是社团同意，则去拉取联系人列表和自己的tag
                    [[ContactManager sharedInstance] getContactsListData:^(YActionMessage *message) {
                        if (message.isSuccess) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Refresh_Message object:nil userInfo:nil];
                        }
                    }];
                    
                    [[ProvisionManager sharedInstance] getProfileInfo:^(YActionMessage *message) {
                        
                    }];
                }
                
                break;
            }
                
            case FRIEND_APPLY: {
                YLogD(@"好友申请推送");
                
                message.conversationChatter = KFRIEND_APPLYID;
                message.from = KFRIEND_APPLYID;
                
                needReload = YES;
                needRefresh = YES;
                break;
            }
            case GROUP_APPLY: {
                YLogD(@"社团申请推送");
                __block NSString *chatter;
                //先判断是否存在
                [_grouArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj[@"group_id"] integerValue] == [ext[@"group_id"] integerValue]) {
                        chatter = obj[@"chatter"];
                        
                        *stop = YES;
                    }
                }];
                
                if ([SStr(chatter) isEmpty]) {
                    chatter = [NSString stringWithFormat:@"%lu", [KGROUP_APPLYID integerValue]+_grouArray.count];
                    [_grouArray addObject:@{@"group_id":ext[@"group_id"], @"chatter": chatter}];
                }
                
                message.conversationChatter = chatter;
                message.from = chatter;
                
                needReload = YES;
                needRefresh = YES;
                break;
            }
            case ADD_COMMENT:
            case ADD_PRAOSE:
            case REPLY_COMMENT:
            case REPLY_PRAOSE:
            {
                //其他提醒消息
                [[ProvisionManager sharedInstance] addUnreadAlterCount:[ext[@"count"] integerValue]];
                break;
            }
            default:
            {
                
                break;
            }
        }
    } else {
        needRefresh = YES;
        
        if (eMessageTypeGroupChat == message.messageType) {
            //群聊
            //更新头像
            [[ContactManager sharedInstance] updateContactsHeadImageByThirdCode:message.groupSenderName headImage:message.ext[@"headImage"]];
        } else if (eMessageTypeChat == message.messageType) {
            
            EMTextMessageBody * body = message.messageBodies.lastObject;
            if (body.messageBodyType == eMessageBodyType_Text)
            {
                if ([body.text isEqualToString:@"我通过你的好友请求啦，聊聊呗"])
                {
                    //别人同意添加你为好友 
                    [[ContactManager sharedInstance] getContactsListData:^(YActionMessage *message) {
                        if (message.isSuccess)
                        {
                            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Refresh_Message object:nil];
                        }
                    }];
                }
            }
            
            //更新头像
            [[ContactManager sharedInstance] updateContactsHeadImageByThirdCode:message.from headImage:message.ext[@"headImage"]];
        }
    }
    
    if (needReload) {
        //插入message
        [[EaseMob sharedInstance].chatManager insertMessagesToDB:@[message]];
        
        //插入conversation
        [[EaseMob sharedInstance].chatManager conversationForChatter:KSYSTEM_MESSAGEID
                                                    conversationType:eConversationTypeChat];
    }
    
    return needRefresh;
}

-(void)didReceiveMessage:(EMMessage *)message
{
    YLogD(@"%@", message.ext);
    //解析
    
    //子线程处理数据
    [YQueue dispatchInSyncQueueWithQueueType:kMessageManagerSyncQueue block:^{
        BOOL needRefresh = [self resetMessage:message];
        
        //主线程处理界面
        [YQueue dispatchInMainQueueWithBlock:^{
            if (needRefresh) {
                [message updateMessageExtToDB];
                
                [self updateMessage];
            }
        }];
    }];
    
#if !TARGET_IPHONE_SIMULATOR
    BOOL needPush = NO;
    if (!message.ext[@"em_ignore_notification"]) {
        if (eMessageTypeChat == message.messageType) {
            needPush = YES;
        } else if (eMessageTypeGroupChat == message.messageType) {
            if (![self isForbiddenGroupByThirdCode:message.from]) {
                needPush = YES;
            }
        }
    }
    
    //判断是否发送本地推送
    if (needPush) {
        BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
        if (!isAppActivity) {
            [self showNotificationWithMessage:message];
        } else {
            [self playSoundAndVibration];
        }
    }
#endif
    
    
}

//环信踢出
- (void)didLoginFromOtherDevice {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Server_Token_Fail object:@{@"des":@"您的账号已在别的地方登录"}];
}

//// 未读消息数量变化回调
//-(void)didUnreadMessagesCountChanged
//{
//    [self setupUnreadMessageCount];
//}
//
//- (void)didFinishedReceiveOfflineMessages
//{
//    [self setupUnreadMessageCount];
//}

// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
    int unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Message_unread object:nil userInfo:@{@"unread":@(unreadCount)}];
    
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}


//自动登录
/*!
 @method
 @brief 用户将要进行自动登录操作的回调
 @discussion
 @param loginInfo 登录的用户信息
 @param error     错误信息
 @result
 */
- (void)willAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    
}

/*!
 @method
 @brief 用户自动登录完成后的回调
 @discussion
 @param loginInfo 登录的用户信息
 @param error     错误信息
 @result
 */
- (void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    
}


//重连
/*!
 @method
 @brief 将要发起自动重连操作时发送该回调
 @discussion
 @result
 */
- (void)willAutoReconnect
{
    
}

/*!
 @method
 @brief 自动重连操作完成后的回调（成功的话，error为nil，失败的话，查看error的错误信息）
 @discussion
 @result
 */
- (void)didAutoReconnectFinishedWithError:(NSError *)error
{
    
}

- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    AudioServicesPlaySystemSound(1007); //系统的通知声音
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);//震动
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    notification.alertBody = message.ext[@"em_apns_ext"][@"em_push_title"];
    //    notification.alertAction = @"查看";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.messageType] forKey:kMessageType];
    [userInfo setObject:message.conversationChatter forKey:kConversationChatter];
    notification.userInfo = userInfo;
    
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end
