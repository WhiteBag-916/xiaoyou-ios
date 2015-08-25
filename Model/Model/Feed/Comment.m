//
//  Comment.m
//
//  Created by   on 15/8/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Comment.h"


NSString *const kCommentReplyCount = @"replyCount";
NSString *const kCommentContent = @"content";
NSString *const kCommentUserId = @"userId";
NSString *const kCommentId = @"id";
NSString *const kCommentFeedId = @"feedId";
NSString *const kCommentPraiseCount = @"praiseCount";
NSString *const kCommentToUserId = @"toUserId";
NSString *const kCommentCreateTime = @"createTime";
NSString *const kCommentIsRespect = @"isRespect";


@interface Comment ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Comment

@synthesize replyCount = _replyCount;
@synthesize content = _content;
@synthesize userId = _userId;
@synthesize commentIdentifier = _commentIdentifier;
@synthesize feedId = _feedId;
@synthesize praiseCount = _praiseCount;
@synthesize toUserId = _toUserId;
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
            self.replyCount = [[self objectOrNilForKey:kCommentReplyCount fromDictionary:dict] doubleValue];
            self.content = [self objectOrNilForKey:kCommentContent fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kCommentUserId fromDictionary:dict];
            self.commentIdentifier = [[self objectOrNilForKey:kCommentId fromDictionary:dict] doubleValue];
            self.feedId = [[self objectOrNilForKey:kCommentFeedId fromDictionary:dict] doubleValue];
            self.praiseCount = [[self objectOrNilForKey:kCommentPraiseCount fromDictionary:dict] doubleValue];
            self.toUserId = [self objectOrNilForKey:kCommentToUserId fromDictionary:dict];
            self.createTime = [[self objectOrNilForKey:kCommentCreateTime fromDictionary:dict] doubleValue];
        self.isRespect = [[self objectOrNilForKey:kCommentIsRespect fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.replyCount] forKey:kCommentReplyCount];
    [mutableDict setValue:self.content forKey:kCommentContent];
    [mutableDict setValue:self.userId forKey:kCommentUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.commentIdentifier] forKey:kCommentId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.feedId] forKey:kCommentFeedId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.praiseCount] forKey:kCommentPraiseCount];
    [mutableDict setValue:self.toUserId forKey:kCommentToUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kCommentCreateTime];
    [mutableDict setValue:[NSNumber numberWithBool:self.isRespect] forKey:kCommentIsRespect];

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

    self.replyCount = [aDecoder decodeDoubleForKey:kCommentReplyCount];
    self.content = [aDecoder decodeObjectForKey:kCommentContent];
    self.userId = [aDecoder decodeObjectForKey:kCommentUserId];
    self.commentIdentifier = [aDecoder decodeDoubleForKey:kCommentId];
    self.feedId = [aDecoder decodeDoubleForKey:kCommentFeedId];
    self.praiseCount = [aDecoder decodeDoubleForKey:kCommentPraiseCount];
    self.toUserId = [aDecoder decodeObjectForKey:kCommentToUserId];
    self.createTime = [aDecoder decodeDoubleForKey:kCommentCreateTime];
    self.isRespect = [aDecoder decodeBoolForKey:kCommentIsRespect];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_replyCount forKey:kCommentReplyCount];
    [aCoder encodeObject:_content forKey:kCommentContent];
    [aCoder encodeObject:_userId forKey:kCommentUserId];
    [aCoder encodeDouble:_commentIdentifier forKey:kCommentId];
    [aCoder encodeDouble:_feedId forKey:kCommentFeedId];
    [aCoder encodeDouble:_praiseCount forKey:kCommentPraiseCount];
    [aCoder encodeObject:_toUserId forKey:kCommentToUserId];
    [aCoder encodeDouble:_createTime forKey:kCommentCreateTime];
    [aCoder encodeBool:_isRespect forKey:kCommentIsRespect];
}

- (id)copyWithZone:(NSZone *)zone
{
    Comment *copy = [[Comment alloc] init];
    
    if (copy) {

        copy.replyCount = self.replyCount;
        copy.content = [self.content copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.commentIdentifier = self.commentIdentifier;
        copy.feedId = self.feedId;
        copy.praiseCount = self.praiseCount;
        copy.toUserId = [self.toUserId copyWithZone:zone];
        copy.createTime = self.createTime;
        copy.isRespect = self.isRespect;
    }
    
    return copy;
}


@end
