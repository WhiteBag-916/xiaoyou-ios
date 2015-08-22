//
//  FeedInfo.m
//
//  Created by   on 15/8/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FeedInfo.h"
#import "Author.h"
#import "Tags.h"
#import "Feed.h"


NSString *const kFeedInfoAuthor = @"author";
NSString *const kFeedInfoTags = @"tags";
NSString *const kFeedInfoFeed = @"feed";


@interface FeedInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FeedInfo

@synthesize author = _author;
@synthesize tags = _tags;
@synthesize feed = _feed;


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
            self.author = [Author modelObjectWithDictionary:[dict objectForKey:kFeedInfoAuthor]];
    NSObject *receivedTags = [dict objectForKey:kFeedInfoTags];
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
            self.feed = [Feed modelObjectWithDictionary:[dict objectForKey:kFeedInfoFeed]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.author dictionaryRepresentation] forKey:kFeedInfoAuthor];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTags] forKey:kFeedInfoTags];
    [mutableDict setValue:[self.feed dictionaryRepresentation] forKey:kFeedInfoFeed];

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

    self.author = [aDecoder decodeObjectForKey:kFeedInfoAuthor];
    self.tags = [aDecoder decodeObjectForKey:kFeedInfoTags];
    self.feed = [aDecoder decodeObjectForKey:kFeedInfoFeed];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_author forKey:kFeedInfoAuthor];
    [aCoder encodeObject:_tags forKey:kFeedInfoTags];
    [aCoder encodeObject:_feed forKey:kFeedInfoFeed];
}

- (id)copyWithZone:(NSZone *)zone
{
    FeedInfo *copy = [[FeedInfo alloc] init];
    
    if (copy) {

        copy.author = [self.author copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
        copy.feed = [self.feed copyWithZone:zone];
    }
    
    return copy;
}


@end
