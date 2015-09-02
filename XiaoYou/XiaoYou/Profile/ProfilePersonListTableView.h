//
//  ProfilePersonListTableView.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"

typedef NS_ENUM(NSInteger, ProfilePersonListType) {
    /**
     *  @author 李思良, 15-09-01
     *
     *  @brief  个人敬酒人列表类型
     */
    ProfilePersonListTypeRespect = 0,
    /**
     *  @author 李思良, 15-09-01
     *
     *  @brief  个人点赞人列表类型
     */
    ProfilePersonListTypeCool,
    /**
     *  @author 李思良, 15-09-01
     *
     *  @brief  feed敬酒人列表类型
     */
    PersonPersonListTypeFeedRespect,
    /**
     *  @author 李思良, 15-09-01
     *
     *  @brief  找人类型
     */
    ProfilePersonListTypeFind,              //找人
    /**
     *  @author 李思良, 15-09-01
     *
     *  @brief  人脉的人类型
     */
    ProfilePersonListTypeFeedPerson,        //人脉里的人
};

@interface ProfilePersonListTableView : YTableView
- (id)initWIthType:(int)type;
/**
 *  @author 李思良, 15-09-01
 *
 *  @brief  个人类型使用
 */
- (void)loadData;
/**
 *  @author 李思良, 15-09-01
 *
 *  @brief  找人类型使用
 *
 */
- (void)loadDataWithFind:(NSDictionary *)condition;
/**
 *  @author 李思良, 15-09-01
 *
 *  @brief  人脉的人使用
 *
 */
- (void)loadDataWithQueryCode:(NSString *)queryCode;
/**
 *  @author 李思良, 15-09-01
 *
 *  @brief  feed敬酒人使用
 *
 */
- (void)loadDataWithFeedId:(NSString *)feedId;

@end
