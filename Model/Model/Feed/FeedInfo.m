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
#import "GroupModel.h"
#import "CommentListItems.h"

NSString *const kFeedInfoAuthor = @"author";
NSString *const kFeedInfoTags = @"tags";
NSString *const kFeedInfoFeed = @"feed";
NSString *const kFeedInfoGroupModels = @"groupModels";
NSString *const kFeedInfoPraisePeoples = @"praisePeoples";
NSString *const kFeedInfoCommentListItems = @"commentListItems";

@interface FeedInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FeedInfo

@synthesize author = _author;
@synthesize tags = _tags;
@synthesize feed = _feed;
@synthesize groupModels = _groupModels;
@synthesize commentListItems = _commentListItems;
@synthesize praisePeoples = _praisePeoples;

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
        NSObject *receivedGroupModel = [dict objectForKey:kFeedInfoGroupModels];
        NSMutableArray *parsedGroupModel = [NSMutableArray array];
        if ([receivedGroupModel isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedGroupModel) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedGroupModel addObject:[GroupModel modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedGroupModel isKindOfClass:[NSDictionary class]]) {
            [parsedGroupModel addObject:[GroupModel modelObjectWithDictionary:(NSDictionary *)receivedGroupModel]];
        }
        
        self.groupModels = [NSArray arrayWithArray:parsedGroupModel];
        
        NSObject *receivedPraisePeoples = [dict objectForKey:kFeedInfoPraisePeoples];
        NSMutableArray *parsedPraisePeoples = [NSMutableArray array];
        if ([receivedPraisePeoples isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedPraisePeoples) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedPraisePeoples addObject:[Author modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedPraisePeoples isKindOfClass:[NSDictionary class]]) {
            [parsedPraisePeoples addObject:[Author modelObjectWithDictionary:(NSDictionary *)receivedPraisePeoples]];
        }
        
        self.praisePeoples = [NSArray arrayWithArray:parsedPraisePeoples];
        
        NSObject *receivedCommentListItems = [dict objectForKey:kFeedInfoCommentListItems];
        NSMutableArray *parsedCommentListItems = [NSMutableArray array];
        if ([receivedCommentListItems isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedCommentListItems) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedCommentListItems addObject:[CommentListItems modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedCommentListItems isKindOfClass:[NSDictionary class]]) {
            [parsedCommentListItems addObject:[CommentListItems modelObjectWithDictionary:(NSDictionary *)receivedCommentListItems]];
        }
        
        self.commentListItems = [NSArray arrayWithArray:parsedCommentListItems];

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
    NSMutableArray *tempArrayForGroupModel = [NSMutableArray array];
    for (NSObject *subArrayObject in self.groupModels) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForGroupModel addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForGroupModel addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGroupModel] forKey:kFeedInfoGroupModels];
    
    NSMutableArray *tempArrayForCommentListItems = [NSMutableArray array];
    for (NSObject *subArrayObject in self.commentListItems) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCommentListItems addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCommentListItems addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCommentListItems] forKey:kFeedInfoCommentListItems];
    
    NSMutableArray *tempArrayForPraisePeoples = [NSMutableArray array];
    for (NSObject *subArrayObject in self.praisePeoples) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPraisePeoples addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPraisePeoples addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPraisePeoples] forKey:kFeedInfoPraisePeoples];
    
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
    self.groupModels = [aDecoder decodeObjectForKey:kFeedInfoGroupModels];
    self.commentListItems = [aDecoder decodeObjectForKey:kFeedInfoCommentListItems];
    self.praisePeoples = [aDecoder decodeObjectForKey:kFeedInfoPraisePeoples];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_groupModels forKey:kFeedInfoGroupModels];
    [aCoder encodeObject:_author forKey:kFeedInfoAuthor];
    [aCoder encodeObject:_tags forKey:kFeedInfoTags];
    [aCoder encodeObject:_feed forKey:kFeedInfoFeed];
    [aCoder encodeObject:_commentListItems forKey:kFeedInfoCommentListItems];
    [aCoder encodeObject:_praisePeoples forKey:kFeedInfoPraisePeoples];
}

- (id)copyWithZone:(NSZone *)zone
{
    FeedInfo *copy = [[FeedInfo alloc] init];
    
    if (copy) {
        copy.groupModels = [self.groupModels copyWithZone:zone];
        copy.author = [self.author copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
        copy.feed = [self.feed copyWithZone:zone];
        copy.commentListItems = [self.commentListItems copyWithZone:zone];
        copy.praisePeoples = [self.praisePeoples copyWithZone:zone];
    }
    
    return copy;
}


@end
