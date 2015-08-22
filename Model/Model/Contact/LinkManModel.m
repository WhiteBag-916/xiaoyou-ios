//
//  LinkManModel.m
//
//  Created by HuiYin  on 15/8/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LinkManModel.h"
#import "ClassList.h"
#import "LinkManList.h"
#import "UnionList.h"


NSString *const kLinkManModelClassList = @"classList";
NSString *const kLinkManModelLinkManList = @"linkManList";
NSString *const kLinkManModelUnionList = @"unionList";


@interface LinkManModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LinkManModel

@synthesize classList = _classList;
@synthesize linkManList = _linkManList;
@synthesize unionList = _unionList;


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
    NSObject *receivedClassList = [dict objectForKey:kLinkManModelClassList];
    NSMutableArray *parsedClassList = [NSMutableArray array];
    if ([receivedClassList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedClassList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedClassList addObject:[ClassList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedClassList isKindOfClass:[NSDictionary class]]) {
       [parsedClassList addObject:[ClassList modelObjectWithDictionary:(NSDictionary *)receivedClassList]];
    }

    self.classList = [NSArray arrayWithArray:parsedClassList];
    NSObject *receivedLinkManList = [dict objectForKey:kLinkManModelLinkManList];
    NSMutableArray *parsedLinkManList = [NSMutableArray array];
    if ([receivedLinkManList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLinkManList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLinkManList addObject:[LinkManList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLinkManList isKindOfClass:[NSDictionary class]]) {
       [parsedLinkManList addObject:[LinkManList modelObjectWithDictionary:(NSDictionary *)receivedLinkManList]];
    }

    self.linkManList = [NSArray arrayWithArray:parsedLinkManList];
    NSObject *receivedUnionList = [dict objectForKey:kLinkManModelUnionList];
    NSMutableArray *parsedUnionList = [NSMutableArray array];
    if ([receivedUnionList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedUnionList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedUnionList addObject:[UnionList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedUnionList isKindOfClass:[NSDictionary class]]) {
       [parsedUnionList addObject:[UnionList modelObjectWithDictionary:(NSDictionary *)receivedUnionList]];
    }

    self.unionList = [NSArray arrayWithArray:parsedUnionList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForClassList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.classList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForClassList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForClassList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForClassList] forKey:kLinkManModelClassList];
    NSMutableArray *tempArrayForLinkManList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.linkManList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForLinkManList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForLinkManList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForLinkManList] forKey:kLinkManModelLinkManList];
    NSMutableArray *tempArrayForUnionList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.unionList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForUnionList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForUnionList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForUnionList] forKey:kLinkManModelUnionList];

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

    self.classList = [aDecoder decodeObjectForKey:kLinkManModelClassList];
    self.linkManList = [aDecoder decodeObjectForKey:kLinkManModelLinkManList];
    self.unionList = [aDecoder decodeObjectForKey:kLinkManModelUnionList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_classList forKey:kLinkManModelClassList];
    [aCoder encodeObject:_linkManList forKey:kLinkManModelLinkManList];
    [aCoder encodeObject:_unionList forKey:kLinkManModelUnionList];
}

- (id)copyWithZone:(NSZone *)zone
{
    LinkManModel *copy = [[LinkManModel alloc] init];
    
    if (copy) {

        copy.classList = [self.classList copyWithZone:zone];
        copy.linkManList = [self.linkManList copyWithZone:zone];
        copy.unionList = [self.unionList copyWithZone:zone];
    }
    
    return copy;
}


@end
