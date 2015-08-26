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

#define kMessageManagerSyncQueue @"kMessageManagerSyncQueue"
//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";

typedef enum : NSUInteger {
    SYSTEM_MESSAGE = 1,
    FRIEND_APPLY,
    GROUP_APPLY,
} PUSH_Message_TYPE;


@interface MessageManager ()<EMChatManagerDelegate>

@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@end

@implementation MessageManager

DEF_SINGLETON(MessageManager);

- (instancetype)init
{
    if (self == [super init]) {
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
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Refresh_Message object:nil userInfo:@{kNotification_Request_Message:loginInfo}];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Refresh_Message object:nil userInfo:@{kNotification_Request_Error:error}];
        }
        
        [self setupUnreadMessageCount];
    } onQueue:nil];
}

-(void)didReceiveMessage:(EMMessage *)message
{
    if ([message.ext[@"server_flag"] boolValue])
    {
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:message.conversationChatter deleteMessages:YES append2Chat:NO];
        
        //解析
        NSDictionary *ext = message.ext;
        
        
//        EMTextMessageBody * body = message.messageBodies[0];
//        NSString * jasonStr = body.text;
//        NSData *data = [jasonStr dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"dic2 = %@",dic2);
        
        switch ([ext[@"type"] integerValue])
        {
            case SYSTEM_MESSAGE: {
                YLogD(@"系统消息推送");
                
                message.conversationChatter = @"000001";
                message.from = @"000001";
                //插入message
                [[EaseMob sharedInstance].chatManager insertMessagesToDB:@[message]];
                
                //插入conversation
                EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:@"000001"
                                                                            conversationType:eConversationTypeChat];
                
                [[EaseMob sharedInstance].chatManager insertConversationToDB:conversation append2Chat:YES];
                
                break;
            }
                
            case FRIEND_APPLY:
                YLogD(@"好友申请推送");
                
                message.conversationChatter = @"000002";
                message.from = @"000002";
                break;
            case GROUP_APPLY:
                YLogD(@"社团申请推送");
                
                message.conversationChatter = @"000003";
                message.from = @"000003";
                break;
                
            default:
                break;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Refresh_Message object:nil userInfo:nil];
        
    }
    [message updateMessageExtToDB];
    
    
#if !TARGET_IPHONE_SIMULATOR
    BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
    if (!isAppActivity) {
        [self showNotificationWithMessage:message];
    } else {
        [self playSoundAndVibration];
    }
#endif
    
    
}

// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
}

- (void)didFinishedReceiveOfflineMessages
{
    [self setupUnreadMessageCount];
}

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
    
    notification.alertBody = @"您有一条新消息";
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
