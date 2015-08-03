//
//  YOperation.m
//  YFramework
//
//  Created by abc on 15/4/13.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YOperation.h"

@interface YOperation ()

@end

@implementation YOperation

- (instancetype)init
{
    if (self = [super init])
    {
        self.businessType = eYOperationBusinessTypeDefault;
        self.operationType = eYOperationOperationTypeDefault;
    }
    return self;
}

+ (instancetype)operationWithBlock:(void (^)(void))block
                   completionBlock:(void (^)(void))completionBlock
{
    return [self operationWithName:nil
                      businessType:eYOperationBusinessTypeDefault
                     operationType:eYOperationOperationTypeDefault
                          priority:NSOperationQueuePriorityNormal
                             block:block
                   completionBlock:completionBlock];
}

+ (instancetype)operationWithName:(NSString *)name
                         priority:(NSOperationQueuePriority)priorty
                            block:(void (^)(void))block
                  completionBlock:(void (^)(void))completionBlock
{
    return [self operationWithName:name
                      businessType:eYOperationBusinessTypeDefault
                     operationType:eYOperationOperationTypeDefault
                          priority:priorty
                             block:block
                   completionBlock:completionBlock];
}

+ (instancetype)operationWithName:(NSString *)name
                     businessType:(YOperationBusinessType)bType
                    operationType:(YOperationOperationType)oType
                         priority:(NSOperationQueuePriority)priorty
                            block:(void (^)(void))block
                  completionBlock:(void (^)(void))completionBlock
{
    YOperation *operation = [[YOperation alloc] init];
    [operation addExecutionBlock:block];
    operation.operationName = name;
    operation.completionBlock = completionBlock;
    operation.businessType = bType;
    operation.operationType = oType;
    return operation;
}

//- (void)main
//{
//    NSLog(@"main exit");
//    for (void (^block)(void)  in self.executionBlocks)
//    {
//        block();
//    }
//}
@end
