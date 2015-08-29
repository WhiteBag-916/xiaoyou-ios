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

#define kMessageManagerSyncQueue @"kMessageManagerSyncQueue"
//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";

NSString *const KSYSTEM_MESSAGEID = @"100001";//系统消息
NSString *const KFRIEND_APPLYID = @"100002";//好友申请
NSString *const KGROUP_APPLYID = @"100003";//社团申请，ID累加


@interface MessageManager ()<EMChatManagerChatDelegate>

@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@property (nonatomic, strong) NSMutableArray *grouArray;//现有的group

@end

@implementation MessageManager

DEF_SINGLETON(MessageManager);

- (instancetype)init
{
    if (self == [super init]) {
        _grouArray = [NSMutableArray array];
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

- (void)appDidLogout
{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (!error && info) {
            NSLog(@"退出成功");
        }
    } onQueue:nil];
}

- (void)loginEaseMob {
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[NSString stringWithFormat:@"4_%@",[YShareData defaultData][kShareData_StudentNo]] password:[NSString stringWithFormat:@"4_%@",[YShareData defaultData][kShareData_StudentNo]] completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            YLogD(@"登陆成功");
            
            [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
            
            //取群组id，进行管理
            [self initGroupIdArray];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Refresh_Message object:nil userInfo:@{kNotification_Request_Message:loginInfo}];
        } else if (nil != error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Refresh_Message object:nil userInfo:@{kNotification_Request_Error:error}];
        }
        
        [self setupUnreadMessageCount];
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
-(void)didReceiveCmdMessage:(EMMessage *)cmdMessage
{
    int i = 0;
    NSLog(@"test");
}


-(void)didReceiveMessage:(EMMessage *)message
{
    //解析
    NSDictionary *ext = message.ext;
    BOOL needReload = NO;
    
    if ([ext[@"server_flag"] boolValue])
    {
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:message.conversationChatter deleteMessages:YES append2Chat:NO];
        
        switch ([ext[@"type"] integerValue])
        {
            case SYSTEM_MESSAGE: {
                YLogD(@"系统消息推送");
                
                message.conversationChatter = KSYSTEM_MESSAGEID;
                message.from = KSYSTEM_MESSAGEID;
                
                needReload = YES;
                
                break;
            }
                
            case FRIEND_APPLY: {
                YLogD(@"好友申请推送");
                
                message.conversationChatter = KFRIEND_APPLYID;
                message.from = KFRIEND_APPLYID;
                
                needReload = YES;
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
        needReload = YES;
    }
    
    if (needReload) {
        //插入message
        [[EaseMob sharedInstance].chatManager insertMessagesToDB:@[message]];
        
        //插入conversation
        [[EaseMob sharedInstance].chatManager conversationForChatter:KSYSTEM_MESSAGEID
                                                    conversationType:eConversationTypeChat];
        
        [message updateMessageExtToDB];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Refresh_Message object:nil userInfo:nil];
        
        [self setupUnreadMessageCount];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
    if (!isAppActivity) {
        [self showNotificationWithMessage:message];
    } else {
        [self playSoundAndVibration];
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
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    int unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Message_unread object:nil userInfo:@{@"unread":@(unreadCount)}];
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
