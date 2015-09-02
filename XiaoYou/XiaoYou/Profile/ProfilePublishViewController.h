//
//  ProfilePublishViewController.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YViewController.h"

@interface ProfilePublishViewController : YViewController

- (id)initWithUserId:(NSString *)userId name:(NSString *)userName;
/**
 *  @author 李思良, 15-09-01
 *
 *  @brief  前往feed详情
 *
 */
- (void)goToDetail:(NSString *)feedId;
/**
 *  @author 李思良, 15-09-01
 *
 *  @brief  是否需要在willappear时刷新
 */
@property (nonatomic, assign) BOOL needRefresh;

@end
