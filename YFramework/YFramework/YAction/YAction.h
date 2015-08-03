//
//  YAction.h
//  YFramework
//
//  Created by abc on 15/4/17.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YObject.h"
#import "YQueue.h"
#import "YActionMessage.h"

typedef void (^ActionCompleteBlock)(YActionMessage * message);

@protocol YAction <NSObject>
@required
/**
 *  @author Abc
 *
 *  Action 具体的执行函数,由start函数调用主要操作都在次函数完成,所有Action必须实现.
 */
- (void)execute;
@optional

/**
 *  @author Abc
 *
 *  执行触发函数,次函数触发execute函数,子类实现后可以进行运行时线程等信息的设置.
 */
- (void)start;
- (void)completed;
@end
/**
 *  @author Abc
 *
 *  所有Action的基类
 */
@interface YAction : YObject <YAction>

@property (nonatomic, strong) NSString *type;          //请求类型
@property (nonatomic, assign) NSOperationQueuePriority priority; //请求优先级
@property (nonatomic, assign) NSTimeInterval timeOutSeconds;; //超时时间,此时间不考虑计算队列中排队的时间
@property (nonatomic, strong) YActionMessage *message; //响应消息
@property (copy) ActionCompleteBlock completionBlock;  //请求完成后执行block

- (instancetype)initWithType:(NSString *)type;
- (instancetype)initWithType:(NSString *)type priority:(NSOperationQueuePriority)priority;
/**
 *  @author Abc
 *
 *  取消此次操作.
 */
- (void)cancel;

/**
 *  @author Abc
 *
 *  启动一个Action,执行此函数后,会触发子类Action的start函数
 *
 *  @param action Action子类
 *  @param block 求完成后执行block
 */
+ (void)startAction:(YAction *)action completionBlock:(ActionCompleteBlock)block;

@end
