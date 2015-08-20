
//
//  YCommonShare.m
//  YCPai
//
//  Created by ycpai on 15/7/7.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "YCommonShare.h"
#import "MobClick.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "YUrlDefine.h"

#define kWeChatSDKAppID @""
#define kWeChatSDKSecret @""

@interface YCommonShare ()<UMSocialUIDelegate>

@property (nonatomic, copy) void (^handler)(UMSocialAccountEntity *snsAccount, UMSocialResponseEntity *response, BOOL success);

@end

@implementation YCommonShare

+ (YCommonShare*) sharedInstance
{
    static YCommonShare *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    
    return sharedManagerInstance;
}

- (void)registUmengSDK{
    /**
     *  UMSDK所需
     */
    [UMSocialData setAppKey:UMENG_APPKEY];
    
    /**
     *  WeChat
     */
    [UMSocialWechatHandler setWXAppId:kWeChatSDKAppID
                            appSecret:kWeChatSDKSecret
                                  url:nil];
    
    //使用友盟统计
    [MobClick startWithAppkey:UMENG_APPKEY];
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatSession, UMShareToWechatTimeline]];

}

- (void)shareForViewControllerWithType:(YCommonShareDetailType)type dataModel:(NSDictionary *)obj shareType:(NSInteger)shareType
{
    NSString *url;
    switch (type) {
        case YCommonShareDetailTypeFeed:{
            /**
             *  feed
             */
            [UMSocialWechatHandler setWXAppId:kWeChatSDKAppID
                                    appSecret:kWeChatSDKSecret
                                          url:url];
            
            break;
        }
        case YCommonShareDetailTypePerson:{
            /**
             *  contact
             */
            [UMSocialWechatHandler setWXAppId:kWeChatSDKAppID
                                    appSecret:kWeChatSDKSecret
                                          url:url];
            
            break;
        }
        default:
            break;
    }
    
    NSString *typeStr;
    switch (shareType) {
        case YShareTypeToWechatSession:{
            /**
             *  好友
             */
            typeStr = UMShareToWechatSession;
            [UMSocialData defaultData].extConfig.wechatSessionData.title = @"标题";
            [UMSocialData defaultData].extConfig.wechatSessionData.shareText = @"描述";
            break;
        }
        case YShareTypeToWechatTimeline:{
            /**
             *  朋友圈
             */
            typeStr = UMShareToWechatTimeline;
            break;
        }
        default:
            break;
    }
    
    //share
    
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = @"描述";
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg"];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[typeStr] content:nil image:nil location:nil urlResource:urlResource presentedController:nil completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}

@end
