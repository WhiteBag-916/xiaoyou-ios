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
NSString *const kProfileInfoCoolCount = @"coolCount";
NSString *const kProfileInfoTagsCommon = @"tagsCommon";
NSString *const kProfileInfoPropetiesCommon = @"propetiesCommon";
NSString *const kProfileInfoFeedCount = @"feedCount";
NSString *const kProfileInfoIsCool = @"isCool";

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
@synthesize tagsCommon = _tagsCommon;
@synthesize propetiesCommon = _propetiesCommon;
@synthesize feedCount = _feedCount;
@synthesize isCool = _isCool;

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
        self.coolCount = [[self objectOrNilForKey:kProfileInfoCoolCount fromDictionary:dict] doubleValue];

    }
    
    NSObject *receivedTagsCommon = [dict objectForKey:kProfileInfoTagsCommon];
    NSMutableArray *parsedTagsCommon = [NSMutableArray array];
    if ([receivedTagsCommon isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTagsCommon) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTagsCommon addObject:[Tags modelObjectWithDictionary:item]];
            }
        }
    } else if ([receivedTagsCommon isKindOfClass:[NSDictionary class]]) {
        [parsedTagsCommon addObject:[Tags modelObjectWithDictionary:(NSDictionary *)receivedTagsCommon]];
    }
    
    self.tagsCommon = [NSArray arrayWithArray:parsedTagsCommon];
    NSObject *receivedPropetiesCommon = [dict objectForKey:kProfileInfoPropetiesCommon];
    NSMutableArray *parsedPropetiesCommon = [NSMutableArray array];
    if ([receivedPropetiesCommon isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPropetiesCommon) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPropetiesCommon addObject:[Tags modelObjectWithDictionary:item]];
            }
        }
    } else if ([receivedPropetiesCommon isKindOfClass:[NSDictionary class]]) {
        [parsedPropetiesCommon addObject:[Tags modelObjectWithDictionary:(NSDictionary *)receivedPropetiesCommon]];
    }
    
    self.propetiesCommon = [NSArray arrayWithArray:parsedPropetiesCommon];
    self.feedCount = [[self objectOrNilForKey:kProfileInfoFeedCount fromDictionary:dict] doubleValue];
    self.isCool = [[self objectOrNilForKey:kProfileInfoIsCool fromDictionary:dict] boolValue];
    
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
    NSMutableArray *tempArrayForTagsCommon = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tagsCommon) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTagsCommon addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTagsCommon addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTagsCommon] forKey:kProfileInfoTagsCommon];
    NSMutableArray *tempArrayForPropetiesCommon = [NSMutableArray array];
    for (NSObject *subArrayObject in self.propetiesCommon) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPropetiesCommon addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPropetiesCommon addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPropetiesCommon] forKey:kProfileInfoPropetiesCommon];
    [mutableDict setValue:[NSNumber numberWithDouble:self.feedCount] forKey:kProfileInfoFeedCount];
    [mutableDict setValue:[NSNumber numberWithBool:self.isCool] forKey:kProfileInfoIsCool];

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
    self.tagsCommon = [aDecoder decodeObjectForKey:kProfileInfoTagsCommon];
    self.propetiesCommon = [aDecoder decodeObjectForKey:kProfileInfoPropetiesCommon];
    self.feedCount = [aDecoder decodeDoubleForKey:kProfileInfoFeedCount];
    self.isCool = [aDecoder decodeBoolForKey:kProfileInfoIsCool];
    
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
    [aCoder encodeObject:_tagsCommon forKey:kProfileInfoTagsCommon];
    [aCoder encodeObject:_propetiesCommon forKey:kProfileInfoPropetiesCommon];
    [aCoder encodeDouble:_feedCount forKey:kProfileInfoFeedCount];
    [aCoder encodeBool:_isCool forKey:kProfileInfoIsCool];
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
        copy.tagsCommon = [self.tagsCommon copyWithZone:zone];
        copy.propetiesCommon = [self.propetiesCommon copyWithZone:zone];
        copy.feedCount = self.feedCount;
        copy.isCool = self.isCool;
    }
    
    return copy;
}


@end
