//
//  YBaseService.h
//
//  Created by desheng on 15/11/2.
//  Copyright © 2015年 desheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"
@interface YBaseService : NSObject

@property (nonatomic,strong) YModel *model;


//- (BOOL)isCreateTableSuccessWithModel:(YModel*)model;


/**
 *  插入一个模型
 *
 *  @return 查看是否成功
 */
-(BOOL)insertModel:(YModel*)model;


/**
 *  查询其模型
 *
 *  @return 其模型表中总模型
 */
-(NSArray*)queryModel:(NSString*)className;


/**
 *  根据某个字段删除某个模型
 *
 *  @param idstr 字段
 *
 *  @return 是否删除成功
 */
-(BOOL)deleteModel:(NSString *)className andIdstr:(NSString *)idstr;

/**
 *  根据某个字段更新某个模型
 *
 *  @param idstr 字段
 *
 *  @return 是否更新成功
 */
-(BOOL)updateModel:(YModel *)baseModel andIdstr:(NSString *)idstr andNeedUpdataString:(NSString *)needUpdataStr andUpdataString:(NSString *)updataStr;


@end
