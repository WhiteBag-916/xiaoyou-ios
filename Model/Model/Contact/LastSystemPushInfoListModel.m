//
//  LastSystemPushInfoListModel.m
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LastSystemPushInfoListModel.h"
#import "PushInfo.h"


NSString *const kLastSystemPushInfoListModelPushInfo = @"pushInfo";
NSString *const kLastSystemPushInfoListModelCount = @"count";


@interface LastSystemPushInfoListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LastSystemPushInfoListModel

@synthesize pushInfo = _pushInfo;
@synthesize count = _count;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.pushInfo = [PushInfo modelObjectWithDictionary:[dict objectForKey:kLastSystemPushInfoListModelPushInfo]];
            self.count = [[self objectOrNilForKey:kLastSystemPushInfoListModelCount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.pushInfo dictionaryRepresentation]
                   forKey:kLastSystemPushInfoListModelPushInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count]
                   forKey:kLastSystemPushInfoListModelCount];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.pushInfo = [aDecoder decodeObjectForKey:kLastSystemPushInfoListModelPushInfo];
    self.count = [aDecoder decodeDoubleForKey:kLastSystemPushInfoListModelCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_pushInfo forKey:kLastSystemPushInfoListModelPushInfo];
    [aCoder encodeDouble:_count forKey:kLastSystemPushInfoListModelCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    LastSystemPushInfoListModel *copy = [[LastSystemPushInfoListModel alloc] init];
    
    if (copy) {

        copy.pushInfo = [self.pushInfo copyWithZone:zone];
        copy.count = self.count;
    }
    
    return copy;
}


@end
