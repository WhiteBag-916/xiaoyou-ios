//
//  InterestModel.m
//
//  Created by   on 15/11/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "InterestModel.h"
#import "NewsList.h"


NSString *const kInterestModelDay = @"day";
NSString *const kInterestModelNewsList = @"newsList";


@interface InterestModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation InterestModel

@synthesize day = _day;
@synthesize newsList = _newsList;


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
            self.day = [[self objectOrNilForKey:kInterestModelDay fromDictionary:dict] doubleValue];
    NSObject *receivedNewsList = [dict objectForKey:kInterestModelNewsList];
    NSMutableArray *parsedNewsList = [NSMutableArray array];
    if ([receivedNewsList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNewsList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNewsList addObject:[NewsList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNewsList isKindOfClass:[NSDictionary class]]) {
       [parsedNewsList addObject:[NewsList modelObjectWithDictionary:(NSDictionary *)receivedNewsList]];
    }

    self.newsList = [NSArray arrayWithArray:parsedNewsList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.day] forKey:kInterestModelDay];
    NSMutableArray *tempArrayForNewsList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.newsList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForNewsList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForNewsList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNewsList] forKey:kInterestModelNewsList];

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

    self.day = [aDecoder decodeDoubleForKey:kInterestModelDay];
    self.newsList = [aDecoder decodeObjectForKey:kInterestModelNewsList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_day forKey:kInterestModelDay];
    [aCoder encodeObject:_newsList forKey:kInterestModelNewsList];
}

- (id)copyWithZone:(NSZone *)zone
{
    InterestModel *copy = [[InterestModel alloc] init];
    
    if (copy) {

        copy.day = self.day;
        copy.newsList = [self.newsList copyWithZone:zone];
    }
    
    return copy;
}


@end
