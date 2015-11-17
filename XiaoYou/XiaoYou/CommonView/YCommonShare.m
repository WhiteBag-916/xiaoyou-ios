
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
#import "UMSocialQQHandler.h"

#define kWeChatSDKAppID @"wxd4a2f488921f9365"
#define kWeChatSDKSecret @"30da765d457715737d26de47057179d3"

#define kQQSDKAppID @"1104882368"
#define kQQSDKSecret @"gpSqaoX4vThFibKT"

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
    
    /**
     *  QQ
     */
    [UMSocialQQHandler setQQWithAppId:kQQSDKAppID
                               appKey:kQQSDKSecret
                                  url:nil];
    
    //使用友盟统计
    [MobClick startWithAppkey:UMENG_APPKEY];
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQQ, UMShareToQzone]];

}

- (void)shareForViewControllerWithType:(YCommonShareDetailType)type dataModel:(NSDictionary *)obj shareType:(NSInteger)shareType
{
    NSString *typeStr = @"";
    UMSocialUrlResource *urlResource;
    switch (shareType) {
        case YShareTypeToWechatSession:{
            /**
             *  好友
             */
            typeStr = UMShareToWechatSession;
            [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
            switch (type) {
                case YCommonShareDetailTypeFeed:
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"你的小伙伴在「校友」说";
                    if ([obj[@"content"] length] == 0) {
                        [UMSocialData defaultData].extConfig.wechatSessionData.shareText = @"字不重要，看图。";
                    } else {
                        [UMSocialData defaultData].extConfig.wechatSessionData.shareText = obj[@"content"];
                    }
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/feed/detailInfo?id=%@", obj[@"feedId"]];
                    break;
                case YCommonShareDetailTypePerson:
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"同学，加个「校友」呗";
                    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/person/detailInfo?id=%@", obj[@"userId"]];
                    break;
                case YCommonShareDetailTypeAssociation:
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"小伙伴介绍给你一个社团，快去看看";
                    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/group/detailInfo?id=%@", obj[@"groupId"]];
                    break;
                case YCommonShareDetailTypeActivity:
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = [NSString stringWithFormat:@"快来参加：%@", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/activity/detailInfo?id=%@", obj[@"activityId"]];
                    break;
                case YCommonShareDetailTypeAssociationFeed:
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = [NSString stringWithFormat:@"%@说", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/feed/detailInfo?id=%@", obj[@"feedId"]];
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
            [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
            switch (type) {
                case YCommonShareDetailTypeFeed:
                    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"你的小伙伴在「校友」说";
                    if ([obj[@"content"] length] == 0) {
                        [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = @"字不重要，看图。";
                    } else {
                        [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = obj[@"content"];
                    }
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/feed/detailInfo?id=%@", obj[@"feedId"]];
                    break;
                case YCommonShareDetailTypePerson:
                    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"同学，加个「校友」呗";
                    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/person/detailInfo?id=%@", obj[@"userId"]];
                    break;
                case YCommonShareDetailTypeAssociation:
                    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"小伙伴介绍给你一个社团，快去看看";
                    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/group/detailInfo?id=%@", obj[@"groupId"]];
                    break;
                case YCommonShareDetailTypeActivity:
                    [UMSocialData defaultData].extConfig.wechatTimelineData.title = [NSString stringWithFormat:@"快来参加：%@", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/activity/detailInfo?id=%@", obj[@"activityId"]];
                    break;
                case YCommonShareDetailTypeAssociationFeed:
                    [UMSocialData defaultData].extConfig.wechatTimelineData.title = [NSString stringWithFormat:@"%@说", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/feed/detailInfo?id=%@", obj[@"feedId"]];
                    break;
                default:
                    break;
            }
            break;
        }
        case YShareTypeToQQ:{
            /**
             *  QQ
             */
            typeStr = UMShareToQQ;
            switch (type) {
                case YCommonShareDetailTypeFeed:
                    [UMSocialData defaultData].extConfig.qqData.title = @"你的小伙伴在「校友」说";
                    if ([obj[@"content"] length] == 0) {
                        [UMSocialData defaultData].extConfig.qqData.shareText = @"字不重要，看图。";
                    } else {
                        [UMSocialData defaultData].extConfig.qqData.shareText = obj[@"content"];
                    }
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qqData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/feed/detailInfo?id=%@", obj[@"feedId"]];
                    break;
                case YCommonShareDetailTypePerson:
                    [UMSocialData defaultData].extConfig.qqData.title = @"同学，加个「校友」呗";
                    [UMSocialData defaultData].extConfig.qqData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qqData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/person/detailInfo?id=%@", obj[@"userId"]];
                    break;
                case YCommonShareDetailTypeAssociation:
                    [UMSocialData defaultData].extConfig.qqData.title = @"小伙伴介绍给你一个社团，快去看看";
                    [UMSocialData defaultData].extConfig.qqData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qqData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/group/detailInfo?id=%@", obj[@"groupId"]];
                    break;
                case YCommonShareDetailTypeActivity:
                    [UMSocialData defaultData].extConfig.qqData.title = [NSString stringWithFormat:@"快来参加：%@", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.qqData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qqData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/activity/detailInfo?id=%@", obj[@"activityId"]];
                    break;
                case YCommonShareDetailTypeAssociationFeed:
                    [UMSocialData defaultData].extConfig.qqData.title = [NSString stringWithFormat:@"%@说", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.qqData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qqData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/feed/detailInfo?id=%@", obj[@"feedId"]];
                    break;
                default:
                    break;
            }
            [UMSocialQQHandler setQQWithAppId:kQQSDKAppID
                                       appKey:kQQSDKSecret
                                          url:[UMSocialData defaultData].extConfig.qqData.url];
            break;
        }
        case YShareTypeToQZone:{
            /**
             *  QQ空间
             */
            typeStr = UMShareToQzone;
            switch (type) {
                case YCommonShareDetailTypeFeed:
                    [UMSocialData defaultData].extConfig.qzoneData.title = @"你的小伙伴在「校友」说";
                    if ([obj[@"content"] length] == 0) {
                        [UMSocialData defaultData].extConfig.qzoneData.shareText = @"字不重要，看图。";
                    } else {
                        [UMSocialData defaultData].extConfig.qzoneData.shareText = obj[@"content"];
                    }
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qzoneData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/feed/detailInfo?id=%@", obj[@"feedId"]];
                    break;
                case YCommonShareDetailTypePerson:
                    [UMSocialData defaultData].extConfig.qzoneData.title = @"同学，加个「校友」呗";
                    [UMSocialData defaultData].extConfig.qzoneData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qzoneData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/person/detailInfo?id=%@", obj[@"userId"]];
                    break;
                case YCommonShareDetailTypeAssociation:
                    [UMSocialData defaultData].extConfig.qzoneData.title = @"小伙伴介绍给你一个社团，快去看看";
                    [UMSocialData defaultData].extConfig.qzoneData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qzoneData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/group/detailInfo?id=%@", obj[@"groupId"]];
                    break;
                case YCommonShareDetailTypeActivity:
                    [UMSocialData defaultData].extConfig.qzoneData.title = [NSString stringWithFormat:@"快来参加：%@", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.qzoneData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qzoneData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/activity/detailInfo?id=%@", obj[@"activityId"]];
                    break;
                case YCommonShareDetailTypeAssociationFeed:
                    [UMSocialData defaultData].extConfig.qzoneData.title = [NSString stringWithFormat:@"%@说", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.qzoneData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qzoneData.url = [NSString stringWithFormat:@"http://share.xiaoyou.com/feed/detailInfo?id=%@", obj[@"feedId"]];
                    break;
                default:
                    break;
            }

            [UMSocialQQHandler setQQWithAppId:kQQSDKAppID
                                       appKey:kQQSDKSecret
                                          url:[UMSocialData defaultData].extConfig.qzoneData.url];
            
            break;
        }
        default:
            break;
    }
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[typeStr] content:nil image:[UIImage imageNamed:@"icon"] location:nil urlResource:urlResource presentedController:nil completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}

@end
