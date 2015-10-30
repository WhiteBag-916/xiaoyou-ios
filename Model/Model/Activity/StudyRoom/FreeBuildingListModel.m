//
//  FreeBuildingListModel.m
//
//  Created by   on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FreeBuildingListModel.h"
#import "Result.h"


NSString *const kFreeBuildingListModelFilter = @"filter";
NSString *const kFreeBuildingListModelResult = @"result";


@interface FreeBuildingListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FreeBuildingListModel

@synthesize filter = _filter;
@synthesize result = _result;


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
            self.filter = [self objectOrNilForKey:kFreeBuildingListModelFilter fromDictionary:dict];
    NSObject *receivedResult = [dict objectForKey:kFreeBuildingListModelResult];
    NSMutableArray *parsedResult = [NSMutableArray array];
    if ([receivedResult isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedResult) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedResult addObject:[Result modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedResult isKindOfClass:[NSDictionary class]]) {
       [parsedResult addObject:[Result modelObjectWithDictionary:(NSDictionary *)receivedResult]];
    }

    self.result = [NSArray arrayWithArray:parsedResult];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForFilter = [NSMutableArray array];
    for (NSObject *subArrayObject in self.filter) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForFilter addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForFilter addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForFilter] forKey:kFreeBuildingListModelFilter];
    NSMutableArray *tempArrayForResult = [NSMutableArray array];
    for (NSObject *subArrayObject in self.result) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResult addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResult addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResult] forKey:kFreeBuildingListModelResult];

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

    self.filter = [aDecoder decodeObjectForKey:kFreeBuildingListModelFilter];
    self.result = [aDecoder decodeObjectForKey:kFreeBuildingListModelResult];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_filter forKey:kFreeBuildingListModelFilter];
    [aCoder encodeObject:_result forKey:kFreeBuildingListModelResult];
}

- (id)copyWithZone:(NSZone *)zone
{
    FreeBuildingListModel *copy = [[FreeBuildingListModel alloc] init];
    
    if (copy) {

        copy.filter = [self.filter copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
    }
    
    return copy;
}


@end
