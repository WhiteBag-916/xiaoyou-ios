//
//  ProfileInfo.m
//
//  Created by   on 15/8/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ProfileInfo.h"
#import "Tags.h"
#import "FeedInfo.h"


NSString *const kProfileInfoTagModels = @"tagModels";
NSString *const kProfileInfoUid = @"uid";
NSString *const kProfileInfoUserName = @"userName";
NSString *const kProfileInfoSelfIntro = @"selfIntro";
NSString *const kProfileInfoPraiseCount = @"praiseCount";
NSString *const kProfileInfoFeedInfo = @"lastFeeds";
NSString *const kProfileInfoCommentCount = @"commentCount";


@interface ProfileInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProfileInfo

@synthesize tagModels = _tagModels;
@synthesize uid = _uid;
@synthesize userName = _userName;
@synthesize selfIntro = _selfIntro;
@synthesize praiseCount = _praiseCount;
@synthesize feedInfo = _feedInfo;
@synthesize commentCount = _commentCount;


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
    NSObject *receivedTagModels = [dict objectForKey:kProfileInfoTagModels];
    NSMutableArray *parsedTagModels = [NSMutableArray array];
    if ([receivedTagModels isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTagModels) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTagModels addObject:[Tags modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTagModels isKindOfClass:[NSDictionary class]]) {
       [parsedTagModels addObject:[Tags modelObjectWithDictionary:(NSDictionary *)receivedTagModels]];
    }

    self.tagModels = [NSArray arrayWithArray:parsedTagModels];
            self.uid = [self objectOrNilForKey:kProfileInfoUid fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kProfileInfoUserName fromDictionary:dict];
            self.selfIntro = [self objectOrNilForKey:kProfileInfoSelfIntro fromDictionary:dict];
            self.praiseCount = [[self objectOrNilForKey:kProfileInfoPraiseCount fromDictionary:dict] doubleValue];
    NSObject *receivedFeedInfo = [dict objectForKey:kProfileInfoFeedInfo];
    NSMutableArray *parsedFeedInfo = [NSMutableArray array];
    if ([receivedFeedInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFeedInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFeedInfo addObject:[FeedInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFeedInfo isKindOfClass:[NSDictionary class]]) {
       [parsedFeedInfo addObject:[FeedInfo modelObjectWithDictionary:(NSDictionary *)receivedFeedInfo]];
    }

    self.feedInfo = [NSArray arrayWithArray:parsedFeedInfo];
            self.commentCount = [[self objectOrNilForKey:kProfileInfoCommentCount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForTagModels = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tagModels) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTagModels addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTagModels addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTagModels] forKey:kProfileInfoTagModels];
    [mutableDict setValue:self.uid forKey:kProfileInfoUid];
    [mutableDict setValue:self.userName forKey:kProfileInfoUserName];
    [mutableDict setValue:self.selfIntro forKey:kProfileInfoSelfIntro];
    [mutableDict setValue:[NSNumber numberWithDouble:self.praiseCount] forKey:kProfileInfoPraiseCount];
    NSMutableArray *tempArrayForFeedInfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.feedInfo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForFeedInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForFeedInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForFeedInfo] forKey:kProfileInfoFeedInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.commentCount] forKey:kProfileInfoCommentCount];

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

    self.tagModels = [aDecoder decodeObjectForKey:kProfileInfoTagModels];
    self.uid = [aDecoder decodeObjectForKey:kProfileInfoUid];
    self.userName = [aDecoder decodeObjectForKey:kProfileInfoUserName];
    self.selfIntro = [aDecoder decodeObjectForKey:kProfileInfoSelfIntro];
    self.praiseCount = [aDecoder decodeDoubleForKey:kProfileInfoPraiseCount];
    self.feedInfo = [aDecoder decodeObjectForKey:kProfileInfoFeedInfo];
    self.commentCount = [aDecoder decodeDoubleForKey:kProfileInfoCommentCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_tagModels forKey:kProfileInfoTagModels];
    [aCoder encodeObject:_uid forKey:kProfileInfoUid];
    [aCoder encodeObject:_userName forKey:kProfileInfoUserName];
    [aCoder encodeObject:_selfIntro forKey:kProfileInfoSelfIntro];
    [aCoder encodeDouble:_praiseCount forKey:kProfileInfoPraiseCount];
    [aCoder encodeObject:_feedInfo forKey:kProfileInfoFeedInfo];
    [aCoder encodeDouble:_commentCount forKey:kProfileInfoCommentCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    ProfileInfo *copy = [[ProfileInfo alloc] init];
    
    if (copy) {

        copy.tagModels = [self.tagModels copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.selfIntro = [self.selfIntro copyWithZone:zone];
        copy.praiseCount = self.praiseCount;
        copy.feedInfo = [self.feedInfo copyWithZone:zone];
        copy.commentCount = self.commentCount;
    }
    
    return copy;
}


@end
