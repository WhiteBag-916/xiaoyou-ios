//
//  NewsList.m
//
//  Created by   on 15/11/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NewsList.h"


NSString *const kNewsListAuthor = @"author";
NSString *const kNewsListSource = @"source";
NSString *const kNewsListPublishTime = @"publishTime";
NSString *const kNewsListUpdateTime = @"updateTime";
NSString *const kNewsListId = @"id";
NSString *const kNewsListCoverImg = @"coverImg";
NSString *const kNewsListTitle = @"title";
NSString *const kNewsListLink = @"link";
NSString *const kNewsListPublishDay = @"publishDay";
NSString *const kNewsListContent = @"content";
NSString *const kNewsListCreateTime = @"createTime";


@interface NewsList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NewsList

@synthesize author = _author;
@synthesize source = _source;
@synthesize publishTime = _publishTime;
@synthesize updateTime = _updateTime;
@synthesize newsListIdentifier = _newsListIdentifier;
@synthesize coverImg = _coverImg;
@synthesize title = _title;
@synthesize link = _link;
@synthesize publishDay = _publishDay;
@synthesize content = _content;
@synthesize createTime = _createTime;


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
            self.author = [self objectOrNilForKey:kNewsListAuthor fromDictionary:dict];
            self.source = [self objectOrNilForKey:kNewsListSource fromDictionary:dict];
            self.publishTime = [[self objectOrNilForKey:kNewsListPublishTime fromDictionary:dict] doubleValue];
            self.updateTime = [[self objectOrNilForKey:kNewsListUpdateTime fromDictionary:dict] doubleValue];
            self.newsListIdentifier = [[self objectOrNilForKey:kNewsListId fromDictionary:dict] doubleValue];
            self.coverImg = [self objectOrNilForKey:kNewsListCoverImg fromDictionary:dict];
            self.title = [self objectOrNilForKey:kNewsListTitle fromDictionary:dict];
            self.link = [self objectOrNilForKey:kNewsListLink fromDictionary:dict];
            self.publishDay = [[self objectOrNilForKey:kNewsListPublishDay fromDictionary:dict] doubleValue];
            self.content = [self objectOrNilForKey:kNewsListContent fromDictionary:dict];
            self.createTime = [[self objectOrNilForKey:kNewsListCreateTime fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.author forKey:kNewsListAuthor];
    [mutableDict setValue:self.source forKey:kNewsListSource];
    [mutableDict setValue:[NSNumber numberWithDouble:self.publishTime] forKey:kNewsListPublishTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateTime] forKey:kNewsListUpdateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.newsListIdentifier] forKey:kNewsListId];
    [mutableDict setValue:self.coverImg forKey:kNewsListCoverImg];
    [mutableDict setValue:self.title forKey:kNewsListTitle];
    [mutableDict setValue:self.link forKey:kNewsListLink];
    [mutableDict setValue:[NSNumber numberWithDouble:self.publishDay] forKey:kNewsListPublishDay];
    [mutableDict setValue:self.content forKey:kNewsListContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kNewsListCreateTime];

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

    self.author = [aDecoder decodeObjectForKey:kNewsListAuthor];
    self.source = [aDecoder decodeObjectForKey:kNewsListSource];
    self.publishTime = [aDecoder decodeDoubleForKey:kNewsListPublishTime];
    self.updateTime = [aDecoder decodeDoubleForKey:kNewsListUpdateTime];
    self.newsListIdentifier = [aDecoder decodeDoubleForKey:kNewsListId];
    self.coverImg = [aDecoder decodeObjectForKey:kNewsListCoverImg];
    self.title = [aDecoder decodeObjectForKey:kNewsListTitle];
    self.link = [aDecoder decodeObjectForKey:kNewsListLink];
    self.publishDay = [aDecoder decodeDoubleForKey:kNewsListPublishDay];
    self.content = [aDecoder decodeObjectForKey:kNewsListContent];
    self.createTime = [aDecoder decodeDoubleForKey:kNewsListCreateTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_author forKey:kNewsListAuthor];
    [aCoder encodeObject:_source forKey:kNewsListSource];
    [aCoder encodeDouble:_publishTime forKey:kNewsListPublishTime];
    [aCoder encodeDouble:_updateTime forKey:kNewsListUpdateTime];
    [aCoder encodeDouble:_newsListIdentifier forKey:kNewsListId];
    [aCoder encodeObject:_coverImg forKey:kNewsListCoverImg];
    [aCoder encodeObject:_title forKey:kNewsListTitle];
    [aCoder encodeObject:_link forKey:kNewsListLink];
    [aCoder encodeDouble:_publishDay forKey:kNewsListPublishDay];
    [aCoder encodeObject:_content forKey:kNewsListContent];
    [aCoder encodeDouble:_createTime forKey:kNewsListCreateTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    NewsList *copy = [[NewsList alloc] init];
    
    if (copy) {

        copy.author = [self.author copyWithZone:zone];
        copy.source = [self.source copyWithZone:zone];
        copy.publishTime = self.publishTime;
        copy.updateTime = self.updateTime;
        copy.newsListIdentifier = self.newsListIdentifier;
        copy.coverImg = [self.coverImg copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.link = [self.link copyWithZone:zone];
        copy.publishDay = self.publishDay;
        copy.content = [self.content copyWithZone:zone];
        copy.createTime = self.createTime;
    }
    
    return copy;
}


@end
