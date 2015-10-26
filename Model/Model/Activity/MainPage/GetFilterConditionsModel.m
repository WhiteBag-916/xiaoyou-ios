//
//  GetFilterConditionsModel.m
//
//  Created by   on 15/10/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GetFilterConditionsModel.h"
#import "Tags.h"


NSString *const kGetFilterConditionsModelParam = @"param";
NSString *const kGetFilterConditionsModelName = @"name";
NSString *const kGetFilterConditionsModelType = @"type";
NSString *const kGetFilterConditionsModelTags = @"value";


@interface GetFilterConditionsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetFilterConditionsModel

@synthesize param = _param;
@synthesize name = _name;
@synthesize type = _type;
@synthesize tags = _tags;


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
            self.param = [self objectOrNilForKey:kGetFilterConditionsModelParam fromDictionary:dict];
            self.name = [self objectOrNilForKey:kGetFilterConditionsModelName fromDictionary:dict];
            self.type = [self objectOrNilForKey:kGetFilterConditionsModelType fromDictionary:dict];
    NSObject *receivedTags = [dict objectForKey:kGetFilterConditionsModelTags];
    NSMutableArray *parsedTags = [NSMutableArray array];
    if ([receivedTags isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTags) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTags addObject:[Tags modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTags isKindOfClass:[NSDictionary class]]) {
       [parsedTags addObject:[Tags modelObjectWithDictionary:(NSDictionary *)receivedTags]];
    }

    self.tags = [NSArray arrayWithArray:parsedTags];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.param forKey:kGetFilterConditionsModelParam];
    [mutableDict setValue:self.name forKey:kGetFilterConditionsModelName];
    [mutableDict setValue:self.type forKey:kGetFilterConditionsModelType];
    NSMutableArray *tempArrayForTags = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tags) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTags addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTags addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTags] forKey:kGetFilterConditionsModelTags];

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

    self.param = [aDecoder decodeObjectForKey:kGetFilterConditionsModelParam];
    self.name = [aDecoder decodeObjectForKey:kGetFilterConditionsModelName];
    self.type = [aDecoder decodeObjectForKey:kGetFilterConditionsModelType];
    self.tags = [aDecoder decodeObjectForKey:kGetFilterConditionsModelTags];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_param forKey:kGetFilterConditionsModelParam];
    [aCoder encodeObject:_name forKey:kGetFilterConditionsModelName];
    [aCoder encodeObject:_type forKey:kGetFilterConditionsModelType];
    [aCoder encodeObject:_tags forKey:kGetFilterConditionsModelTags];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetFilterConditionsModel *copy = [[GetFilterConditionsModel alloc] init];
    
    if (copy) {

        copy.param = [self.param copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
    }
    
    return copy;
}


@end
