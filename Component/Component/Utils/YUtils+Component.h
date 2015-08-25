//
//  Utils+Component.h
//  Component
//
//  Created by abc on 15/4/17.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YUtils.h"
#import "YDefine.h"
#import "YFoundation.h"
#import "YModel+ActionMessage.h"

@interface YUtils(Component)
+ getUrl:(NSString *)bussinessPath;
+ getUrl:(NSString *)bussinessPath needUserToken:(BOOL)needUserToken;
+ getParameter;
+ getParameter:(NSDictionary *)parameters;
+ getParameter:(NSDictionary *)parameters needUserToken:(BOOL)needUserToken;

/**
 *  @author xiongchen
 *
 *  根据时间计算距今多久
 *
 *  @return time 
 */
+ (NSString *)distanceTimeToday:(NSDate *)date;

/*********************************************************************
 函数名称 : dictionaryToJson
 函数描述 : dic转json
 参数 : 你懂的
 返回值 : json
 作者 : XiongChen
 *********************************************************************/
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

//根据1970时间值,返回中文年月
+ (NSString *)dateStringWithTimeIntervalString:(NSString *)timeIntervalString;

/*********************************************************************
 函数名称 : initImageProcessingUrl
 函数描述 : 根据需求进行图片裁剪的url
 参数 : http://developer.qiniu.com/docs/v6/api/reference/fop/image/imageview2.html
 返回值 : 处理后的url
 作者 : XiongChen
 *********************************************************************/
+ (NSString*)initImageProcessingUrl:(NSString *)type width:(int)imageWidth height:(int)imageHeight;


@end
