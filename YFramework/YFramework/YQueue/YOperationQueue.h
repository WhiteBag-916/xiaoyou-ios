//
//  YOperationQueue.h
//  YFramework
//
//  Created by abc on 15/4/14.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YOperationQueue : NSOperationQueue
/**
 *  @author Abc
 *
 *  操作的依赖关系
 *  请参考:https://github.com/azu/OperationPromise
 */
@property (readonly) YOperationQueue * (^then)(id operation);
@property (readonly) YOperationQueue * (^when)(NSArray *operations);
@property (readonly) void (^start)(void);
@end
