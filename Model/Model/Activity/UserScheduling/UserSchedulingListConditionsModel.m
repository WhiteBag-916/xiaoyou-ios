//
//  UserSchedulingListConditionsModel.m
//
//  Created by   on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserSchedulingListConditionsModel.h"


NSString *const kUserSchedulingListConditionsModelDatePeriod = @"datePeriod";
NSString *const kUserSchedulingListConditionsModelNotifyShowContent = @"notifyShowContent";


@interface UserSchedulingListConditionsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserSchedulingListConditionsModel

@synthesize datePeriod = _datePeriod;
@synthesize notifyShowContent = _notifyShowContent;


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
            self.datePeriod = [[self objectOrNilForKey:kUserSchedulingListConditionsModelDatePeriod fromDictionary:dict] doubleValue];
            self.notifyShowContent = [self objectOrNilForKey:kUserSchedulingListConditionsModelNotifyShowContent fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.datePeriod] forKey:kUserSchedulingListConditionsModelDatePeriod];
    [mutableDict setValue:self.notifyShowContent forKey:kUserSchedulingListConditionsModelNotifyShowContent];

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

    self.datePeriod = [aDecoder decodeDoubleForKey:kUserSchedulingListConditionsModelDatePeriod];
    self.notifyShowContent = [aDecoder decodeObjectForKey:kUserSchedulingListConditionsModelNotifyShowContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_datePeriod forKey:kUserSchedulingListConditionsModelDatePeriod];
    [aCoder encodeObject:_notifyShowContent forKey:kUserSchedulingListConditionsModelNotifyShowContent];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserSchedulingListConditionsModel *copy = [[UserSchedulingListConditionsModel alloc] init];
    
    if (copy) {

        copy.datePeriod = self.datePeriod;
        copy.notifyShowContent = [self.notifyShowContent copyWithZone:zone];
    }
    
    return copy;
}


@end
