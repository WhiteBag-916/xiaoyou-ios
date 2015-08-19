
//
//  YCommonShare.m
//  YCPai
//
//  Created by ycpai on 15/7/7.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "YCommonShare.h"
#import "YCommonActionSheet.h"
#import "YCPDefine.h"
#import "MobClick.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialSinaHandler.h"
#import "Feed.h"
#import "Project.h"
#import "Persion.h"

#define UMENG_APPKEY @"5235b00c56240bb3810a299f"

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
     *  Sina
     */
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:kSinaSDKDirectURL];
    [UMSocialSinaHandler openSSOWithRedirectURL:kSinaSDKDirectURL];
    /**
     *  QQ
     */
    [UMSocialQQHandler setQQWithAppId:kQQSDKAppKey
                               appKey:kQQSDKSecret
                                  url:nil];
    /**
     *  WeChat
     */
    [UMSocialWechatHandler setWXAppId:kWeChatSDKAppID
                            appSecret:kWeChatSDKSecret
                                  url:nil];
    
    //使用友盟统计
    [MobClick startWithAppkey:UMENG_APPKEY];

}

- (void)showShareForViewController:(UIViewController *)viewController dataModel:(NSObject *)obj type:(YCommonShareDetailType)type
{
    NSString *url;
    switch (type) {
        case YCommonShareDetailTypeFeed:{
            Feed *feed = [obj copy];
            url = [NSString stringWithFormat:@"http://m.ycpai.com/h5/home/v4_feed_1/%@/%@",feed.dataIdentifier,[YShareData defaultData][kShareData_YCP_LoginCode]];
            NSString *imagePath;
            if (feed.pictures.count >= 1) {
                imagePath = feed.pictures[0];
            }
            
            /**
             *  QQ
             */
            [UMSocialQQHandler setQQWithAppId:kQQSDKAppKey
                                       appKey:kQQSDKSecret
                                          url:url];
            /**
             *  WeChat
             */
            [UMSocialWechatHandler setWXAppId:kWeChatSDKAppID
                                    appSecret:kWeChatSDKSecret
                                          url:url];
            
            [self buildShareItmesForPresentedController:viewController shareImageURL:imagePath shareContent:feed.content];
        }
            break;
            
        case YCommonShareDetailTypeProject:{
            Project *project = [obj copy];

            url = [NSString stringWithFormat:@"http://m.ycpai.com/h5/home/pro_msg/p_%@",project.dataIdentifier];
            
            NSString *imagePath;
            if (project.pic.count >= 1) {
                imagePath = project.pic[0];
            }
            /**
             *  QQ
             */
            [UMSocialQQHandler setQQWithAppId:kQQSDKAppKey
                                       appKey:kQQSDKSecret
                                          url:url];
            /**
             *  WeChat
             */
            [UMSocialWechatHandler setWXAppId:kWeChatSDKAppID
                                    appSecret:kWeChatSDKSecret
                                          url:url];
            
            [self buildShareItmesForPresentedController:viewController shareImageURL:imagePath shareContent:project.dataDescription];
        }

            break;
        
        case YCommonShareDetailTypePerson:{
            Persion *persion = [obj copy];
            
            url = [NSString stringWithFormat:@"http://m.ycpai.com/h5/home/user_info/u_%@",persion.dataIdentifier];
            
            NSString *imagePath = persion.imagepath;

            /**
             *  QQ
             */
            [UMSocialQQHandler setQQWithAppId:kQQSDKAppKey
                                       appKey:kQQSDKSecret
                                          url:url];
            /**
             *  WeChat
             */
            [UMSocialWechatHandler setWXAppId:kWeChatSDKAppID
                                    appSecret:kWeChatSDKSecret
                                          url:url];
            
            [self buildShareItmesForPresentedController:viewController shareImageURL:imagePath shareContent:persion.preAchieve];
        }

            break;
            
        default:
            break;
    }
    

}

- (void)buildShareItmesForPresentedController:(UIViewController *)viewController shareImageURL:(NSString *)imagePath shareContent:(NSString *)content{
    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"微信" image:[UIImage imageNamed:@"share_icon_wecha"] block:^{
        [UMSocialData defaultData].extConfig.wechatSessionData.shareText = content;
        UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:imagePath];
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:nil image:nil location:nil urlResource:urlResource presentedController:viewController completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
    }];
    
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"朋友圈" image:[UIImage imageNamed:@"share_icon_friend"] block:^{
        [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = content;
        UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:imagePath];
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:nil image:nil location:nil urlResource:urlResource presentedController:viewController completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
    }];
    
    YActionSheetItem *item3 = [YActionSheetItem itemWithTitle:@"QQ" image:[UIImage imageNamed:@"share_icon_qq"] block:^{
        [UMSocialData defaultData].extConfig.qqData.shareText = content;
        UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:imagePath];
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:nil image:nil location:nil urlResource:urlResource presentedController:viewController completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
    }];
    
    YActionSheetItem *item4 = [YActionSheetItem itemWithTitle:@"新浪微博" image:[UIImage imageNamed:@"share_icon_weibo"] block:^{
        [UMSocialData defaultData].extConfig.sinaData.shareText = content;
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:imagePath];
        
        [[UMSocialControllerService defaultControllerService] setShareText:nil shareImage:nil socialUIDelegate:self];
        
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES);
        
    }];
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:YCommonActionSheetTypeShare items:@[item1,item2,item3,item4] title:@"分享到"];
    [sheet show];

}

- (void)loginShareForViewController:(UIViewController *)viewController LoginType:(YCommonShareLoginType)LoginType handler:(void(^)(UMSocialAccountEntity *snsAccount, UMSocialResponseEntity *response, BOOL success))handler
{
    _handler = [handler copy];

    switch (LoginType) {
        case YCommonShareLoginTypeQQ:{
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
            snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){

                if (response.responseCode == UMSResponseCodeSuccess) {
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
                    
                    _handler(snsAccount, response, YES);

                }else{
                    _handler(nil, response, NO);
                }
                
            });

        }
            
            break;
            
        case YCommonShareLoginTypeSina:{
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
            snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                    
                    _handler(snsAccount, response, YES);

                }else{
                    _handler(nil, response, NO);
                }
                
            });
        }
            
            break;
            
        case YCommonShareLoginTypeWeixin:{
            NSString *platformName = [UMSocialSnsPlatformManager getSnsPlatformString:UMSocialSnsTypeWechatSession];
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
            snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];

                    _handler(snsAccount, response, YES);
                    
                }else{
                    _handler(nil, response, NO);
                }
                
            });

        }
            
            break;
            
        default:
            break;
    }
    

}

@end
