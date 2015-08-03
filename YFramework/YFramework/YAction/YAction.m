//
//  YAction.m
//  YFramework
//
//  Created by abc on 15/4/17.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YAction.h"
#import "YQueue.h"

@implementation YAction

- (instancetype) init
{
    if (self = [super init])
    {
        self.type = [NSString stringWithFormat:@"(%@)",[YUtils createUUID]];
    }
    return self;
}

- (instancetype)initWithType:(NSString *)type
{
    if (self = [super init])
    {
        if (type.length > 0){
            self.type = [type stringByAppendingFormat:@"(%@)",[YUtils createUUID]];
        } else {
            self.type = [NSString stringWithFormat:@"(%@)",[YUtils createUUID]];
        }
    }
    return self;
}

- (instancetype)initWithType:(NSString *)type priority:(NSOperationQueuePriority)priority
{
    if (self = [super init])
    {
        if (type.length > 0){
            self.type = [type stringByAppendingFormat:@"(%@)",[YUtils createUUID]];
        } else {
            self.type = [NSString stringWithFormat:@"(%@)",[YUtils createUUID]];
        }
        self.priority = priority;
    }
    return self;
}

- (void)execute
{
    self.completionBlock(nil);
}

- (void)start
{
    @synchronized([YAction Actions]){
        [[YAction Actions] addObject:self];
    }
}

- (void)completed
{
    @synchronized([YAction Actions]){
        [[YAction Actions] removeObject:self];
    }
}

- (void)cancel
{
    [self completed];
    self.completionBlock = nil;
    return;
}

+ (void)startAction:(YAction *)action completionBlock:(ActionCompleteBlock)block
{
    action.completionBlock = block;
    [action start];
}

+ (NSMutableArray *)Actions
{
    static dispatch_once_t onceToken;
    static NSMutableArray *Actions;
    dispatch_once(&onceToken, ^{
        Actions = [[NSMutableArray alloc] init];
    });
    return Actions;
}

-(void)dealloc
{
    YLogE(@"dealloc -- %@",self.type);
    return;
}
@end
