//
//  Feed.m
//
//  Created by   on 15/8/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Feed.h"


NSString *const kFeedId = @"id";
NSString *const kFeedPraiseCount = @"praiseCount";
NSString *const kFeedSortOrder2 = @"sortOrder2";
NSString *const kFeedAllCount = @"allCount";
NSString *const kFeedSendGroupId = @"sendGroupId";
NSString *const kFeedImg = @"img";
NSString *const kFeedType = @"type";
NSString *const kFeedCreateTime = @"createTime";
NSString *const kFeedSortOrder1 = @"sortOrder1";
NSString *const kFeedCommentCount = @"commentCount";
NSString *const kFeedCreateTimeMiles = @"createTimeMiles";
NSString *const kFeedSendId = @"sendId";
NSString *const kFeedContent = @"content";
NSString *const kFeedIsPraise = @"isPraise";

@interface Feed ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Feed

@synthesize feedIdentifier = _feedIdentifier;
@synthesize praiseCount = _praiseCount;
@synthesize sortOrder2 = _sortOrder2;
@synthesize allCount = _allCount;
@synthesize sendGroupId = _sendGroupId;
@synthesize img = _img;
@synthesize type = _type;
@synthesize createTime = _createTime;
@synthesize sortOrder1 = _sortOrder1;
@synthesize commentCount = _commentCount;
@synthesize createTimeMiles = _createTimeMiles;
@synthesize sendId = _sendId;
@synthesize content = _content;
@synthesize isPraise = _isPraise;

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
            self.feedIdentifier = [[self objectOrNilForKey:kFeedId fromDictionary:dict] doubleValue];
            self.praiseCount = [[self objectOrNilForKey:kFeedPraiseCount fromDictionary:dict] doubleValue];
            self.sortOrder2 = [self objectOrNilForKey:kFeedSortOrder2 fromDictionary:dict];
            self.allCount = [[self objectOrNilForKey:kFeedAllCount fromDictionary:dict] doubleValue];
            self.sendGroupId = [self objectOrNilForKey:kFeedSendGroupId fromDictionary:dict];
            self.img = [self objectOrNilForKey:kFeedImg fromDictionary:dict];
            self.type = [self objectOrNilForKey:kFeedType fromDictionary:dict];
            self.createTime = [[self objectOrNilForKey:kFeedCreateTime fromDictionary:dict] doubleValue];
            self.sortOrder1 = [self objectOrNilForKey:kFeedSortOrder1 fromDictionary:dict];
            self.commentCount = [[self objectOrNilForKey:kFeedCommentCount fromDictionary:dict] doubleValue];
            self.createTimeMiles = [[self objectOrNilForKey:kFeedCreateTimeMiles fromDictionary:dict] doubleValue];
            self.sendId = [self objectOrNilForKey:kFeedSendId fromDictionary:dict];
            self.content = [self objectOrNilForKey:kFeedContent fromDictionary:dict];
        self.isPraise = [[self objectOrNilForKey:kFeedIsPraise fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.feedIdentifier] forKey:kFeedId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.praiseCount] forKey:kFeedPraiseCount];
    [mutableDict setValue:self.sortOrder2 forKey:kFeedSortOrder2];
    [mutableDict setValue:[NSNumber numberWithDouble:self.allCount] forKey:kFeedAllCount];
    [mutableDict setValue:self.sendGroupId forKey:kFeedSendGroupId];
    [mutableDict setValue:self.img forKey:kFeedImg];
    [mutableDict setValue:self.type forKey:kFeedType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kFeedCreateTime];
    [mutableDict setValue:self.sortOrder1 forKey:kFeedSortOrder1];
    [mutableDict setValue:[NSNumber numberWithDouble:self.commentCount] forKey:kFeedCommentCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTimeMiles] forKey:kFeedCreateTimeMiles];
    [mutableDict setValue:self.sendId forKey:kFeedSendId];
    [mutableDict setValue:self.content forKey:kFeedContent];
    [mutableDict setValue:[NSNumber numberWithBool:self.isPraise] forKey:kFeedIsPraise];

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

    self.feedIdentifier = [aDecoder decodeDoubleForKey:kFeedId];
    self.praiseCount = [aDecoder decodeDoubleForKey:kFeedPraiseCount];
    self.sortOrder2 = [aDecoder decodeObjectForKey:kFeedSortOrder2];
    self.allCount = [aDecoder decodeDoubleForKey:kFeedAllCount];
    self.sendGroupId = [aDecoder decodeObjectForKey:kFeedSendGroupId];
    self.img = [aDecoder decodeObjectForKey:kFeedImg];
    self.type = [aDecoder decodeObjectForKey:kFeedType];
    self.createTime = [aDecoder decodeDoubleForKey:kFeedCreateTime];
    self.sortOrder1 = [aDecoder decodeObjectForKey:kFeedSortOrder1];
    self.commentCount = [aDecoder decodeDoubleForKey:kFeedCommentCount];
    self.createTimeMiles = [aDecoder decodeDoubleForKey:kFeedCreateTimeMiles];
    self.sendId = [aDecoder decodeObjectForKey:kFeedSendId];
    self.content = [aDecoder decodeObjectForKey:kFeedContent];
    self.isPraise = [aDecoder decodeBoolForKey:kFeedIsPraise];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_feedIdentifier forKey:kFeedId];
    [aCoder encodeDouble:_praiseCount forKey:kFeedPraiseCount];
    [aCoder encodeObject:_sortOrder2 forKey:kFeedSortOrder2];
    [aCoder encodeDouble:_allCount forKey:kFeedAllCount];
    [aCoder encodeObject:_sendGroupId forKey:kFeedSendGroupId];
    [aCoder encodeObject:_img forKey:kFeedImg];
    [aCoder encodeObject:_type forKey:kFeedType];
    [aCoder encodeDouble:_createTime forKey:kFeedCreateTime];
    [aCoder encodeObject:_sortOrder1 forKey:kFeedSortOrder1];
    [aCoder encodeDouble:_commentCount forKey:kFeedCommentCount];
    [aCoder encodeDouble:_createTimeMiles forKey:kFeedCreateTimeMiles];
    [aCoder encodeObject:_sendId forKey:kFeedSendId];
    [aCoder encodeObject:_content forKey:kFeedContent];
    [aCoder encodeBool:_isPraise forKey:kFeedIsPraise];
    
}

- (id)copyWithZone:(NSZone *)zone
{
    Feed *copy = [[Feed alloc] init];
    
    if (copy) {

        copy.feedIdentifier = self.feedIdentifier;
        copy.praiseCount = self.praiseCount;
        copy.sortOrder2 = [self.sortOrder2 copyWithZone:zone];
        copy.allCount = self.allCount;
        copy.sendGroupId = [self.sendGroupId copyWithZone:zone];
        copy.img = [self.img copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.createTime = self.createTime;
        copy.sortOrder1 = [self.sortOrder1 copyWithZone:zone];
        copy.commentCount = self.commentCount;
        copy.createTimeMiles = self.createTimeMiles;
        copy.sendId = [self.sendId copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.isPraise = self.isPraise;
        
    }
    
    return copy;
}


@end
