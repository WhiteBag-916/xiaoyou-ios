//
//  BaseClass.m
//
//  Created by sheng  on 15/10/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FilterConditionModels.h"
#import "FilterCondition.h"

NSString *const kBaseClassParam = @"param";
NSString *const kBaseClassValue = @"value";
NSString *const kBaseClassName = @"name";
NSString *const kBaseClassType = @"type";


@interface FilterConditionModels ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FilterConditionModels

@synthesize param = _param;
@synthesize value = _value;
@synthesize name = _name;
@synthesize type = _type;


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
            self.param = [self objectOrNilForKey:kBaseClassParam fromDictionary:dict];
    NSObject *receivedValue = [dict objectForKey:kBaseClassValue];
    NSMutableArray *parsedValue = [NSMutableArray array];
    if ([receivedValue isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedValue) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedValue addObject:[FilterCondition modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedValue isKindOfClass:[NSDictionary class]]) {
       [parsedValue addObject:[FilterCondition modelObjectWithDictionary:(NSDictionary *)receivedValue]];
    }

    self.value = [NSArray arrayWithArray:parsedValue];
            self.name = [self objectOrNilForKey:kBaseClassName fromDictionary:dict];
            self.type = [self objectOrNilForKey:kBaseClassType fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.param forKey:kBaseClassParam];
    NSMutableArray *tempArrayForValue = [NSMutableArray array];
    for (NSObject *subArrayObject in self.value) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForValue addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForValue addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForValue] forKey:kBaseClassValue];
    [mutableDict setValue:self.name forKey:kBaseClassName];
    [mutableDict setValue:self.type forKey:kBaseClassType];

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

    self.param = [aDecoder decodeObjectForKey:kBaseClassParam];
    self.value = [aDecoder decodeObjectForKey:kBaseClassValue];
    self.name = [aDecoder decodeObjectForKey:kBaseClassName];
    self.type = [aDecoder decodeObjectForKey:kBaseClassType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_param forKey:kBaseClassParam];
    [aCoder encodeObject:_value forKey:kBaseClassValue];
    [aCoder encodeObject:_name forKey:kBaseClassName];
    [aCoder encodeObject:_type forKey:kBaseClassType];
}

- (id)copyWithZone:(NSZone *)zone
{
    FilterConditionModels *copy = [[FilterConditionModels alloc] init];
    
    if (copy) {

        copy.param = [self.param copyWithZone:zone];
        copy.value = [self.value copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
    }
    
    return copy;
}


@end
