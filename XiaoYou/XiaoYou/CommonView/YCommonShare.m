
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
             *  微信好友
             */
            typeStr = UMShareToWechatSession;
            [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
            switch (type) {
                case YCommonShareDetailTypeFeed:
                    [YAnalysis trackEvent:@"分享至微信_FEED详情_更多操作"
                                 withPara:[YAnalysis getDataFromShareInFeed:obj]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"你的小伙伴在「校友」说";
                    if ([obj[@"content"] length] == 0) {
                        [UMSocialData defaultData].extConfig.wechatSessionData.shareText = @"字不重要，看图。";
                    } else {
                        [UMSocialData defaultData].extConfig.wechatSessionData.shareText = obj[@"content"];
                    }
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"%@/feed/detailInfo?id=%@", share_url, obj[@"feedId"]];
                    break;
                case YCommonShareDetailTypePerson:
                    [YAnalysis trackEvent:@"分享至微信_人的详情_更多操作"
                                 withPara:[YAnalysis getDataFromShareInProfile:obj]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"同学，加个「校友」呗";
                    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"%@/person/detailInfo?id=%@", share_url, obj[@"userId"]];
                    break;
                case YCommonShareDetailTypeAssociation:
                    [YAnalysis trackEvent:@"分享至微信_社团详情_更多操作" withPara:@{@"社团":obj[@"name"],
                                                                        @"学校":obj[@"schoolCode"]}];
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"小伙伴介绍给你一个社团，快去看看";
                    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"%@/group/detailInfo?id=%@", share_url, obj[@"groupId"]];
                    break;
                case YCommonShareDetailTypeActivity:
                    [YAnalysis trackEvent:@"分享至微信_活动详情_更多操作" withPara:@{@"活动":obj[@"name"]}];
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = [NSString stringWithFormat:@"快来参加：%@", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"%@/activity/detailInfo?id=%@", share_url, obj[@"activityId"]];
                    break;
                case YCommonShareDetailTypeAssociationFeed:
                    [YAnalysis trackEvent:@"分享至微信_FEED详情_更多操作"
                                 withPara:[YAnalysis getDataFromShareInFeed:obj]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = [NSString stringWithFormat:@"%@说", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"%@/feed/detailInfo?id=%@", share_url, obj[@"feedId"]];
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
                    [YAnalysis trackEvent:@"分享至朋友圈_FEED详情_更多操作"
                                 withPara:[YAnalysis getDataFromShareInFeed:obj]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"你的小伙伴在「校友」说";
                    if ([obj[@"content"] length] == 0) {
                        [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = @"字不重要，看图。";
                    } else {
                        [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = obj[@"content"];
                    }
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"%@/feed/detailInfo?id=%@", share_url, obj[@"feedId"]];
                    break;
                case YCommonShareDetailTypePerson:
                    [YAnalysis trackEvent:@"分享至朋友圈_人的详情_更多操作"
                                 withPara:[YAnalysis getDataFromShareInProfile:obj]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"同学，加个「校友」呗";
                    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"%@/person/detailInfo?id=%@", share_url, obj[@"userId"]];
                    break;
                case YCommonShareDetailTypeAssociation:
                    [YAnalysis trackEvent:@"分享至朋友圈_社团详情_更多操作" withPara:@{@"社团":obj[@"name"],
                                                                         @"学校":obj[@"schoolCode"]}];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"小伙伴介绍给你一个社团，快去看看";
                    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"%@/group/detailInfo?id=%@", share_url, obj[@"groupId"]];
                    break;
                case YCommonShareDetailTypeActivity:
                    [YAnalysis trackEvent:@"分享至朋友圈_活动详情_更多操作" withPara:@{@"活动":obj[@"name"]}];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.title = [NSString stringWithFormat:@"快来参加：%@", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"%@/activity/detailInfo?id=%@", share_url, obj[@"activityId"]];
                    break;
                case YCommonShareDetailTypeAssociationFeed:
                    [YAnalysis trackEvent:@"分享至朋友圈_FEED详情_更多操作"
                                 withPara:[YAnalysis getDataFromShareInFeed:obj]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.title = [NSString stringWithFormat:@"%@说", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"%@/feed/detailInfo?id=%@", share_url, obj[@"feedId"]];
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
                    [YAnalysis trackEvent:@"分享至QQ_FEED详情_更多操作"
                                 withPara:[YAnalysis getDataFromShareInFeed:obj]];
                    [UMSocialData defaultData].extConfig.qqData.title = @"你的小伙伴在「校友」说";
                    if ([obj[@"content"] length] == 0) {
                        [UMSocialData defaultData].extConfig.qqData.shareText = @"字不重要，看图。";
                    } else {
                        [UMSocialData defaultData].extConfig.qqData.shareText = obj[@"content"];
                    }
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qqData.url = [NSString stringWithFormat:@"%@/feed/detailInfo?id=%@", share_url, obj[@"feedId"]];
                    break;
                case YCommonShareDetailTypePerson:
                    [YAnalysis trackEvent:@"分享至QQ_人的详情_更多操作"
                                 withPara:[YAnalysis getDataFromShareInProfile:obj]];
                    [UMSocialData defaultData].extConfig.qqData.title = @"同学，加个「校友」呗";
                    [UMSocialData defaultData].extConfig.qqData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qqData.url = [NSString stringWithFormat:@"%@/person/detailInfo?id=%@", share_url, obj[@"userId"]];
                    break;
                case YCommonShareDetailTypeAssociation:
                    [YAnalysis trackEvent:@"分享至QQ_社团详情_更多操作" withPara:@{@"社团":obj[@"name"],
                                                                        @"学校":obj[@"schoolCode"]}];
                    [UMSocialData defaultData].extConfig.qqData.title = @"小伙伴介绍给你一个社团，快去看看";
                    [UMSocialData defaultData].extConfig.qqData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qqData.url = [NSString stringWithFormat:@"%@/group/detailInfo?id=%@", share_url, obj[@"groupId"]];
                    break;
                case YCommonShareDetailTypeActivity:
                    [YAnalysis trackEvent:@"分享至QQ_活动详情_更多操作" withPara:@{@"活动":obj[@"name"]}];
                    [UMSocialData defaultData].extConfig.qqData.title = [NSString stringWithFormat:@"快来参加：%@", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.qqData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qqData.url = [NSString stringWithFormat:@"%@/activity/detailInfo?id=%@", share_url, obj[@"activityId"]];
                    break;
                case YCommonShareDetailTypeAssociationFeed:
                    [YAnalysis trackEvent:@"分享至QQ_FEED详情_更多操作"
                                 withPara:[YAnalysis getDataFromShareInFeed:obj]];
                    [UMSocialData defaultData].extConfig.qqData.title = [NSString stringWithFormat:@"%@说", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.qqData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qqData.url = [NSString stringWithFormat:@"%@/feed/detailInfo?id=%@", share_url, obj[@"feedId"]];
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
                    [YAnalysis trackEvent:@"分享至QQ空间_FEED详情_更多操作"
                                 withPara:[YAnalysis getDataFromShareInFeed:obj]];
                    [UMSocialData defaultData].extConfig.qzoneData.title = @"你的小伙伴在「校友」说";
                    if ([obj[@"content"] length] == 0) {
                        [UMSocialData defaultData].extConfig.qzoneData.shareText = @"字不重要，看图。";
                    } else {
                        [UMSocialData defaultData].extConfig.qzoneData.shareText = obj[@"content"];
                    }
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qzoneData.url = [NSString stringWithFormat:@"%@/feed/detailInfo?id=%@", share_url, obj[@"feedId"]];
                    break;
                case YCommonShareDetailTypePerson:
                    [YAnalysis trackEvent:@"分享至QQ空间_人的详情_更多操作"
                                 withPara:[YAnalysis getDataFromShareInProfile:obj]];
                    [UMSocialData defaultData].extConfig.qzoneData.title = @"同学，加个「校友」呗";
                    [UMSocialData defaultData].extConfig.qzoneData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qzoneData.url = [NSString stringWithFormat:@"%@/person/detailInfo?id=%@", share_url, obj[@"userId"]];
                    break;
                case YCommonShareDetailTypeAssociation:
                    [YAnalysis trackEvent:@"分享至QQ空间_社团详情_更多操作" withPara:@{@"社团":obj[@"name"],
                                                                          @"学校":obj[@"schoolCode"]}];
                    [UMSocialData defaultData].extConfig.qzoneData.title = @"小伙伴介绍给你一个社团，快去看看";
                    [UMSocialData defaultData].extConfig.qzoneData.shareText = obj[@"name"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qzoneData.url = [NSString stringWithFormat:@"%@/group/detailInfo?id=%@", share_url, obj[@"groupId"]];
                    break;
                case YCommonShareDetailTypeActivity:
                    [YAnalysis trackEvent:@"分享至QQ空间_活动详情_更多操作" withPara:@{@"活动":obj[@"name"]}];
                    [UMSocialData defaultData].extConfig.qzoneData.title = [NSString stringWithFormat:@"快来参加：%@", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.qzoneData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qzoneData.url = [NSString stringWithFormat:@"%@/activity/detailInfo?id=%@", share_url, obj[@"activityId"]];
                    break;
                case YCommonShareDetailTypeAssociationFeed:
                    [YAnalysis trackEvent:@"分享至QQ空间_FEED详情_更多操作"
                                 withPara:[YAnalysis getDataFromShareInFeed:obj]];
                    [UMSocialData defaultData].extConfig.qzoneData.title = [NSString stringWithFormat:@"%@说", obj[@"name"]];
                    [UMSocialData defaultData].extConfig.qzoneData.shareText = obj[@"content"];
                    urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", api_icon_base_url, obj[@"pic"]]];
                    [UMSocialData defaultData].extConfig.qzoneData.url = [NSString stringWithFormat:@"%@/feed/detailInfo?id=%@", share_url, obj[@"feedId"]];
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
