
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

#define kWeChatSDKAppID @"wxd4a2f488921f9365"
#define kWeChatSDKSecret @"30da765d457715737d26de47057179d3"

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
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    
    NSString *typeStr = @"";
    UMSocialUrlResource *urlResource ;
    switch (shareType) {
        case YShareTypeToWechatSession:{
            /**
             *  好友
             */
            typeStr = UMShareToWechatSession;
            switch (type) {
                case YCommonShareDetailTypeFeed:
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = [NSString stringWithFormat:@"关于%@，Ta说", obj[@"tag"]];
                    if ([obj[@"content"] length] == 0) {
                        [UMSocialData defaultData].extConfig.wechatSessionData.shareText = @"字不重要，看图。";
                    } else {
                        [UMSocialData defaultData].extConfig.wechatSessionData.shareText = obj[@"content"];
                    }
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/feed/detailInfo?id=%@", obj[@"feedId"]];
                    break;
                case YCommonShareDetailTypePerson:
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"分享校友名片给你！";
                    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = [NSString stringWithFormat:@"校友人脉：%@-%@", obj[@"school"], obj[@"name"]];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/person/detailInfo?id=%@", obj[@"userId"]];
                    break;
                case YCommonShareDetailTypeAssociation:
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = [NSString stringWithFormat:@"一键申请加入%@", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/group/detailInfo?id=%@", obj[@"groupId"]];
                    break;
                default:
                    break;
            }
            break;
        }
        case YShareTypeToWechatTimeline:{
            /**
             *  朋友圈
             */
            typeStr = UMShareToWechatTimeline;
            switch (type) {
                case YCommonShareDetailTypeFeed:
                    [UMSocialData defaultData].extConfig.wechatTimelineData.title = [NSString stringWithFormat:@"关于%@，Ta说", obj[@"tag"]];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/feed/detailInfo?id=%@", obj[@"feedId"]];
                    break;
                case YCommonShareDetailTypePerson:
                    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = [NSString stringWithFormat:@"校友人脉：%@-%@", obj[@"school"], obj[@"name"]];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/person/detailInfo?id=%@", obj[@"userId"]];
                    break;
                case YCommonShareDetailTypeAssociation:
                    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = [NSString stringWithFormat:@"一键申请加入%@", obj[@"name"]];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/group/detailInfo?id=%@", obj[@"groupId"]];
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    
    //share
    
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[typeStr] content:nil image:[UIImage imageNamed:@"icon"] location:nil urlResource:urlResource presentedController:nil completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}

@end
