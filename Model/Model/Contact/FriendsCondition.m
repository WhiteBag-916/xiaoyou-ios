//
//  FriendsCondition.m
//
//  Created by   on 15/8/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FriendsCondition.h"


NSString *const kFriendsConditionLabel = @"label";
NSString *const kFriendsConditionValue = @"value";
NSString *const kFriendsConditionPramsName = @"pramsName";


@interface FriendsCondition ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FriendsCondition

@synthesize label = _label;
@synthesize value = _value;
@synthesize pramsName = _pramsName;


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
            self.label = [self objectOrNilForKey:kFriendsConditionLabel fromDictionary:dict];
            self.value = [self objectOrNilForKey:kFriendsConditionValue fromDictionary:dict];
            self.pramsName = [self objectOrNilForKey:kFriendsConditionPramsName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.label forKey:kFriendsConditionLabel];
    [mutableDict setValue:self.value forKey:kFriendsConditionValue];
    [mutableDict setValue:self.pramsName forKey:kFriendsConditionPramsName];

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

    self.label = [aDecoder decodeObjectForKey:kFriendsConditionLabel];
    self.value = [aDecoder decodeObjectForKey:kFriendsConditionValue];
    self.pramsName = [aDecoder decodeObjectForKey:kFriendsConditionPramsName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_label forKey:kFriendsConditionLabel];
    [aCoder encodeObject:_value forKey:kFriendsConditionValue];
    [aCoder encodeObject:_pramsName forKey:kFriendsConditionPramsName];
}

- (id)copyWithZone:(NSZone *)zone
{
    FriendsCondition *copy = [[FriendsCondition alloc] init];
    
    if (copy) {

        copy.label = [self.label copyWithZone:zone];
        copy.value = [self.value copyWithZone:zone];
        copy.pramsName = [self.pramsName copyWithZone:zone];
    }
    
    return copy;
}


@end
