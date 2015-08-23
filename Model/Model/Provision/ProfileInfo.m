//
//  ProfileInfo.m
//
//  Created by   on 15/8/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ProfileInfo.h"
#import "Tags.h"
#import "FeedInfo.h"


NSString *const kProfileInfoTagModels = @"tagModels";
NSString *const kProfileInfoUid = @"uid";
NSString *const kProfileInfoSchoolCode = @"schoolCode";
NSString *const kProfileInfoHeadPic = @"headPic";
NSString *const kProfileInfoSelfIntro = @"selfIntro";
NSString *const kProfileInfoUserName = @"userName";
NSString *const kProfileInfoStudentNo = @"studentNo";
NSString *const kProfileInfoPraiseCount = @"praiseCount";
NSString *const kProfileInfoLastFeeds = @"lastFeeds";
NSString *const kProfileInfoTags = @"tags";
NSString *const kProfileInfoCommentCount = @"commentCount";


@interface ProfileInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProfileInfo

@synthesize tagModels = _tagModels;
@synthesize uid = _uid;
@synthesize schoolCode = _schoolCode;
@synthesize headPic = _headPic;
@synthesize selfIntro = _selfIntro;
@synthesize userName = _userName;
@synthesize studentNo = _studentNo;
@synthesize praiseCount = _praiseCount;
@synthesize lastFeeds = _lastFeeds;
@synthesize tags = _tags;
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
            self.schoolCode = [self objectOrNilForKey:kProfileInfoSchoolCode fromDictionary:dict];
            self.headPic = [self objectOrNilForKey:kProfileInfoHeadPic fromDictionary:dict];
            self.selfIntro = [self objectOrNilForKey:kProfileInfoSelfIntro fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kProfileInfoUserName fromDictionary:dict];
            self.studentNo = [self objectOrNilForKey:kProfileInfoStudentNo fromDictionary:dict];
            self.praiseCount = [[self objectOrNilForKey:kProfileInfoPraiseCount fromDictionary:dict] doubleValue];
    NSObject *receivedLastFeeds = [dict objectForKey:kProfileInfoLastFeeds];
    NSMutableArray *parsedLastFeeds = [NSMutableArray array];
    if ([receivedLastFeeds isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLastFeeds) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLastFeeds addObject:[FeedInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLastFeeds isKindOfClass:[NSDictionary class]]) {
       [parsedLastFeeds addObject:[FeedInfo modelObjectWithDictionary:(NSDictionary *)receivedLastFeeds]];
    }

    self.lastFeeds = [NSArray arrayWithArray:parsedLastFeeds];
            self.tags = [self objectOrNilForKey:kProfileInfoTags fromDictionary:dict];
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
    [mutableDict setValue:self.schoolCode forKey:kProfileInfoSchoolCode];
    [mutableDict setValue:self.headPic forKey:kProfileInfoHeadPic];
    [mutableDict setValue:self.selfIntro forKey:kProfileInfoSelfIntro];
    [mutableDict setValue:self.userName forKey:kProfileInfoUserName];
    [mutableDict setValue:self.studentNo forKey:kProfileInfoStudentNo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.praiseCount] forKey:kProfileInfoPraiseCount];
    NSMutableArray *tempArrayForLastFeeds = [NSMutableArray array];
    for (NSObject *subArrayObject in self.lastFeeds) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForLastFeeds addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForLastFeeds addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForLastFeeds] forKey:kProfileInfoLastFeeds];
    [mutableDict setValue:self.tags forKey:kProfileInfoTags];
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
    self.schoolCode = [aDecoder decodeObjectForKey:kProfileInfoSchoolCode];
    self.headPic = [aDecoder decodeObjectForKey:kProfileInfoHeadPic];
    self.selfIntro = [aDecoder decodeObjectForKey:kProfileInfoSelfIntro];
    self.userName = [aDecoder decodeObjectForKey:kProfileInfoUserName];
    self.studentNo = [aDecoder decodeObjectForKey:kProfileInfoStudentNo];
    self.praiseCount = [aDecoder decodeDoubleForKey:kProfileInfoPraiseCount];
    self.lastFeeds = [aDecoder decodeObjectForKey:kProfileInfoLastFeeds];
    self.tags = [aDecoder decodeObjectForKey:kProfileInfoTags];
    self.commentCount = [aDecoder decodeDoubleForKey:kProfileInfoCommentCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_tagModels forKey:kProfileInfoTagModels];
    [aCoder encodeObject:_uid forKey:kProfileInfoUid];
    [aCoder encodeObject:_schoolCode forKey:kProfileInfoSchoolCode];
    [aCoder encodeObject:_headPic forKey:kProfileInfoHeadPic];
    [aCoder encodeObject:_selfIntro forKey:kProfileInfoSelfIntro];
    [aCoder encodeObject:_userName forKey:kProfileInfoUserName];
    [aCoder encodeObject:_studentNo forKey:kProfileInfoStudentNo];
    [aCoder encodeDouble:_praiseCount forKey:kProfileInfoPraiseCount];
    [aCoder encodeObject:_lastFeeds forKey:kProfileInfoLastFeeds];
    [aCoder encodeObject:_tags forKey:kProfileInfoTags];
    [aCoder encodeDouble:_commentCount forKey:kProfileInfoCommentCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    ProfileInfo *copy = [[ProfileInfo alloc] init];
    
    if (copy) {

        copy.tagModels = [self.tagModels copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.headPic = [self.headPic copyWithZone:zone];
        copy.selfIntro = [self.selfIntro copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.studentNo = [self.studentNo copyWithZone:zone];
        copy.praiseCount = self.praiseCount;
        copy.lastFeeds = [self.lastFeeds copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
        copy.commentCount = self.commentCount;
    }
    
    return copy;
}


@end
