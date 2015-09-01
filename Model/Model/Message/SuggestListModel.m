//
//  SuggestListModel.m
//
//  Created by HuiYin  on 15/9/1
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SuggestListModel.h"


NSString *const kSuggestListModelSuggest = @"suggest";


@interface SuggestListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SuggestListModel

@synthesize suggest = _suggest;


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
            self.suggest = [self objectOrNilForKey:kSuggestListModelSuggest fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForSuggest = [NSMutableArray array];
    for (NSObject *subArrayObject in self.suggest) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSuggest addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSuggest addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSuggest] forKey:kSuggestListModelSuggest];

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

    self.suggest = [aDecoder decodeObjectForKey:kSuggestListModelSuggest];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_suggest forKey:kSuggestListModelSuggest];
}

- (id)copyWithZone:(NSZone *)zone
{
    SuggestListModel *copy = [[SuggestListModel alloc] init];
    
    if (copy) {

        copy.suggest = [self.suggest copyWithZone:zone];
    }
    
    return copy;
}


@end
