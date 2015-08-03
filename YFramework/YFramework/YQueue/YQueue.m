//
//  YQueue.m
//  YFramework
//
//  Created by abc on 15/4/13.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YQueue.h"

NSString* const kSyncQueueTypeDefault = @"kSyncQueueTypeDefault";
NSString* const kAsyncQueueTypeDefault = @"kAsyncQueueTypeDefault";

static NSMutableDictionary* SyncQueues;
static NSMutableDictionary* AsyncQueues;

static int const kAsyncQueueTypeDefaultMaxConcurrentOperationCount = 3;

typedef NS_ENUM(NSInteger, YQueueConcurrentType)
{
    YQueueConcurrentTypeSync,
    YQueueConcurrentTypeAsync,
};

@interface YQueue ()
{
}

@end

@implementation YQueue

+ (void)initialize
{
    if (self == [YQueue class])
    {
        [self registerSyncQueueWithType:kSyncQueueTypeDefault];
        [self registerAsyncQueueWithType:kAsyncQueueTypeDefault
             maxConcurrentOperationCount:kAsyncQueueTypeDefaultMaxConcurrentOperationCount];
    }
}

+ (NSMutableDictionary*)SyncQueues
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SyncQueues = [[NSMutableDictionary alloc] init];
    });
    return SyncQueues;
}

+ (NSMutableDictionary*)AsyncQueues
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AsyncQueues = [[NSMutableDictionary alloc] init];
    });
    return AsyncQueues;
}

+ (BOOL)registerQueueWithConcurrentType:(YQueueConcurrentType)cType queueType:(NSString*)qtype
{
    if (qtype.length == 0)
    {
        return NO;
    }

    if (YQueueConcurrentTypeSync == cType)
    {
        @synchronized([self SyncQueues])
        {
            if ([self SyncQueues][qtype])
            {
                //已经存在
                return NO;
            }
            else
            {
                YOperationQueue* queue = [[YOperationQueue alloc] init];
                queue.maxConcurrentOperationCount = 1;
                [self SyncQueues][qtype] = queue;
            }
        }
    }
    else if (YQueueConcurrentTypeAsync == cType)
    {
        @synchronized([self AsyncQueues])
        {
            if ([self AsyncQueues][qtype])
            {
                //已经存在
                return NO;
            }
            else
            {
                YOperationQueue* queue = [[YOperationQueue alloc] init];
                [self AsyncQueues][qtype] = queue;
            }
        }
    }
    else
    {
        return NO;
    }

    return YES;
}

+ (BOOL)registerSyncQueueWithType:(NSString*)type
{
    return [self registerQueueWithConcurrentType:YQueueConcurrentTypeSync queueType:type];
}

+ (BOOL)registerAsyncQueueWithType:(NSString*)type maxConcurrentOperationCount:(NSInteger)count
{
    if ([self registerQueueWithConcurrentType:YQueueConcurrentTypeAsync queueType:type])
    {
        @synchronized([self AsyncQueues])
        {
            ((YOperationQueue*) [self AsyncQueues][type]).maxConcurrentOperationCount = count;
        }
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (void)unregisterSyncQueueWithType:(NSString*)type
{
    @synchronized([self SyncQueues])
    {
        [[self SyncQueues][type] cancelAllOperations];
        [[self SyncQueues] removeObjectForKey:type];
    }
}

+ (void)unregisterAsyncQueueWithType:(NSString*)type
{
    @synchronized([self AsyncQueues])
    {
        [[self AsyncQueues][type] cancelAllOperations];
        [[self AsyncQueues] removeObjectForKey:type];
    }
}

+ (YOperationQueue *)syncQueueWithType:(NSString *)type
{
    @synchronized([self SyncQueues])
    {
        return [self SyncQueues][type];
    }
}

+ (YOperationQueue *)asyncQueueWithType:(NSString *)type
{
    @synchronized([self AsyncQueues])
    {
        return [self AsyncQueues][type];
    }
}

+ (void)clear
{
    @synchronized([self SyncQueues])
    {
        [[self SyncQueues] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
            [(YOperationQueue *)obj cancelAllOperations];
        }];

        [[self SyncQueues] removeAllObjects];
    }

    @synchronized([self AsyncQueues])
    {
        [[self AsyncQueues] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
            [(YOperationQueue *)obj cancelAllOperations];
        }];

        [[self AsyncQueues] removeAllObjects];
    }

    [[YOperationQueue mainQueue] cancelAllOperations];
}

+ (void)cancelOpertionsWithQueueType:(NSString*)type
{
    [self cancelOpertionsWithSyncQueueType:type];
    [self cancelOpertionsWithAsyncQueueType:type];
}

+ (void)cancelOpertionsWithSyncQueueType:(NSString*)type
{
    @synchronized([self SyncQueues])
    {
        [(YOperationQueue*) [self SyncQueues][type] cancelAllOperations];
    }
}

+ (void)cancelOpertionsWithAsyncQueueType:(NSString*)type
{
    @synchronized([self AsyncQueues])
    {
        [(YOperationQueue*) [self AsyncQueues][type] cancelAllOperations];
    }
}

+ (void)cancelOpertionsWithName:(NSString*)operationName
{
    @synchronized([self SyncQueues])
    {
        [[self SyncQueues] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
            [((YOperationQueue *)obj).operations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if(((YOperation *)obj).operationName.length > 0 &&
                   [((YOperation *)obj).operationName isEqualToString:operationName]) {
                    [((YOperation *)obj) cancel];
                }
            }];
        }];
    }

    @synchronized([self AsyncQueues])
    {
        [[self AsyncQueues] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
            [((YOperationQueue *)obj).operations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if(((YOperation *)obj).operationName.length > 0 &&
                   [((YOperation *)obj).name isEqualToString:operationName]) {
                    [((YOperation *)obj) cancel];
                }
            }];
        }];
    }
}

+ (void)cancelAllOperations
{
    @synchronized([self SyncQueues])
    {
        [[self SyncQueues] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
            [(YOperationQueue *)obj cancelAllOperations];
        }];
    }

    @synchronized([self AsyncQueues])
    {
        [[self AsyncQueues] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
            [(YOperationQueue *)obj cancelAllOperations];
        }];
    }

    [[YOperationQueue mainQueue] cancelAllOperations];
}

+ (void)resetAsyncQueueWithType:(NSString*)type maxConcurrentOperationCount:(NSInteger)count
{
    @synchronized([self AsyncQueues])
    {
        [(YOperationQueue*) [self AsyncQueues][type] setMaxConcurrentOperationCount:count];
    }
}

+ (void)waitUntilAllOperationsAreFinished
{
    @synchronized([self SyncQueues])
    {
        [[self SyncQueues] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
            [(YOperationQueue *)obj waitUntilAllOperationsAreFinished];
        }];
    }

    @synchronized([self AsyncQueues])
    {
        [[self AsyncQueues] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
            [(YOperationQueue *)obj waitUntilAllOperationsAreFinished];
        }];
    }
}

+ (void)waitUntilAllOperationsAreFinishedWithSyncQueueType:(NSString*)type
{
    @synchronized([self SyncQueues])
    {
        [(YOperationQueue*) [self SyncQueues][type] waitUntilAllOperationsAreFinished];
    }
}

+ (void)waitUntilAllOperationsAreFinishedWithAsyncQueueType:(NSString*)type
{
    @synchronized([self AsyncQueues])
    {
        [(YOperationQueue*) [self AsyncQueues][type] waitUntilAllOperationsAreFinished];
    }
}

+ (void)dispatchInSyncQueueWithBlock:(YQueueBlock)block
{
    [self dispatchInSyncQueueWithQueueType:kSyncQueueTypeDefault block:block];
}

+ (void)dispatchInSyncQueueWithBlock:(YQueueBlock)block completionBlock:(YQueueBlock)cblock
{
    [self dispatchInSyncQueueWithQueueType:kSyncQueueTypeDefault block:block completionBlock:cblock];
}

+ (void)dispatchInSyncQueueWithQueueType:(NSString*)type block:(YQueueBlock)block
{
    [self dispatchInSyncQueueWithQueueType:type block:block completionBlock:nil];
}

+ (void)dispatchInSyncQueueWithQueueType:(NSString*)type block:(YQueueBlock)block completionBlock:(YQueueBlock)cblock
{
    [self executWithConcurrentType:YQueueConcurrentTypeSync
                         queueType:type
                     operationName:nil
                          priority:NSOperationQueuePriorityNormal
                             block:block
                   completionBlock:cblock];
}

+ (void)dispatchInSyncQueueWithQueueType:(NSString*)type
                           operationName:(NSString*)operationName
                                priority:(NSOperationQueuePriority)priorty
                                   block:(void (^)(void))block
                         completionBlock:(void (^)(void))completionBlock
{
    [self executWithConcurrentType:YQueueConcurrentTypeSync
                         queueType:type
                     operationName:operationName
                          priority:priorty
                             block:block
                   completionBlock:completionBlock];
}

+ (void)dispatchInAsyncQueueWithBlock:(YQueueBlock)block
{
    [self dispatchInAsyncQueueWithQueueType:kAsyncQueueTypeDefault block:block];
}

+ (void)dispatchInAsyncQueueWithBlock:(YQueueBlock)block completionBlock:(YQueueBlock)cblock
{
    [self dispatchInAsyncQueueWithQueueType:kAsyncQueueTypeDefault block:block completionBlock:cblock];
}

+ (void)dispatchInAsyncQueueWithQueueType:(NSString*)type block:(YQueueBlock)block
{
    [self dispatchInAsyncQueueWithQueueType:type block:block completionBlock:nil];
}

+ (void)dispatchInAsyncQueueWithQueueType:(NSString*)type block:(YQueueBlock)block completionBlock:(YQueueBlock)cblock
{
    [self executWithConcurrentType:YQueueConcurrentTypeAsync
                         queueType:type
                     operationName:nil
                          priority:NSOperationQueuePriorityNormal
                             block:block
                   completionBlock:cblock];
}

+ (void)dispatchInAsyncQueueWithQueueType:(NSString*)type
                            operationName:(NSString*)operationName
                                 priority:(NSOperationQueuePriority)priorty
                                    block:(void (^)(void))block
                          completionBlock:(void (^)(void))completionBlock
{
    [self executWithConcurrentType:YQueueConcurrentTypeAsync
                         queueType:type
                     operationName:operationName
                          priority:priorty
                             block:block
                   completionBlock:completionBlock];
}

+ (void)executWithConcurrentType:(YQueueConcurrentType)cType
                       queueType:(NSString*)qtype
                   operationName:(NSString*)operationName
                        priority:(NSOperationQueuePriority)priorty
                           block:(void (^)(void))block
                 completionBlock:(void (^)(void))completionBlock
{
    YOperation* operation = [YOperation operationWithName:operationName
                                                 priority:priorty
                                                    block:block
                                          completionBlock:completionBlock];

    if (YQueueConcurrentTypeSync == cType)
    {
        @synchronized([self SyncQueues])
        {
            [(YOperationQueue*) [self SyncQueues][qtype] addOperation:operation];
        }
    }
    else
    {
        @synchronized([self AsyncQueues])
        {
            [(YOperationQueue*) [self AsyncQueues][qtype] addOperation:operation];
        }
    }
}

+ (void)dispatchInMainQueueWithBlock:(YQueueBlock)block
{
    [self dispatchInMainQueueWithBlock:block completionBlock:nil];
}

+ (void)dispatchInMainQueueWithBlock:(YQueueBlock)block completionBlock:(YQueueBlock)cblock
{
    [self dispatchInMainQueueWithOperationName:nil
                                      priority:NSOperationQueuePriorityNormal
                                         block:block
                               completionBlock:cblock];
}

+ (void)dispatchInMainQueueWithOperationName:(NSString*)operationName
                                    priority:(NSOperationQueuePriority)priorty
                                       block:(void (^)(void))block
                             completionBlock:(void (^)(void))completionBlock
{
    YOperation* operation = [YOperation operationWithName:operationName
                                                 priority:priorty
                                                    block:block
                                          completionBlock:completionBlock];
    [[YOperationQueue mainQueue] addOperation:operation];
}

@end
