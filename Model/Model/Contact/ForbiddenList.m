//
//  ForbiddenList.m
//
//  Created by   on 15/8/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ForbiddenList.h"


NSString *const kForbiddenListForbiddenList = @"forbiddenList";


@interface ForbiddenList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ForbiddenList

@synthesize forbiddenList = _forbiddenList;


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
            self.forbiddenList = [self objectOrNilForKey:kForbiddenListForbiddenList fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForForbiddenList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.forbiddenList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForForbiddenList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForForbiddenList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForForbiddenList] forKey:kForbiddenListForbiddenList];

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

    self.forbiddenList = [aDecoder decodeObjectForKey:kForbiddenListForbiddenList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_forbiddenList forKey:kForbiddenListForbiddenList];
}

- (id)copyWithZone:(NSZone *)zone
{
    ForbiddenList *copy = [[ForbiddenList alloc] init];
    
    if (copy) {

        copy.forbiddenList = [self.forbiddenList copyWithZone:zone];
    }
    
    return copy;
}


@end
