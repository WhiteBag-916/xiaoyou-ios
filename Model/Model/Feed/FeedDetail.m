//
//  FeedDetail.m
//
//  Created by   on 15/8/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FeedDetail.h"
#import "CommentListItems.h"
#import "Tags.h"
#import "Feed.h"
#import "Author.h"
#import "GroupModel.h"

NSString *const kFeedDetailCommentListItems = @"commentListItems";
NSString *const kFeedDetailTags = @"tags";
NSString *const kFeedDetailFeed = @"feed";
NSString *const kFeedDetailAuthor = @"author";
NSString *const kFeedDetailPraisePeoples = @"praisePeoples";
NSString *const kFeedDetailGroupModels = @"groupModels";

@interface FeedDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FeedDetail

@synthesize commentListItems = _commentListItems;
@synthesize tags = _tags;
@synthesize feed = _feed;
@synthesize author = _author;
@synthesize groupModels = _groupModels;

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
    NSObject *receivedCommentListItems = [dict objectForKey:kFeedDetailCommentListItems];
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
    NSObject *receivedTags = [dict objectForKey:kFeedDetailTags];
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
            self.feed = [Feed modelObjectWithDictionary:[dict objectForKey:kFeedDetailFeed]];
    NSObject *receivedAuthor = [dict objectForKey:kFeedDetailAuthor];
    NSMutableArray *parsedAuthor = [NSMutableArray array];
    if ([receivedAuthor isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedAuthor) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedAuthor addObject:[Author modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedAuthor isKindOfClass:[NSDictionary class]]) {
       [parsedAuthor addObject:[Author modelObjectWithDictionary:(NSDictionary *)receivedAuthor]];
    }

        self.author = [Author modelObjectWithDictionary:[dict objectForKey:kFeedDetailAuthor]];
        NSObject *receivedPraisePeoples = [dict objectForKey:kFeedDetailPraisePeoples];
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
        NSObject *receivedGroupModel = [dict objectForKey:kFeedDetailGroupModels];
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
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCommentListItems] forKey:kFeedDetailCommentListItems];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTags] forKey:kFeedDetailTags];
    [mutableDict setValue:[self.feed dictionaryRepresentation] forKey:kFeedDetailFeed];
    [mutableDict setValue:[self.author dictionaryRepresentation] forKey:kFeedDetailAuthor];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPraisePeoples] forKey:kFeedDetailPraisePeoples];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGroupModel] forKey:kFeedDetailGroupModels];

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

    self.commentListItems = [aDecoder decodeObjectForKey:kFeedDetailCommentListItems];
    self.tags = [aDecoder decodeObjectForKey:kFeedDetailTags];
    self.feed = [aDecoder decodeObjectForKey:kFeedDetailFeed];
    self.author = [aDecoder decodeObjectForKey:kFeedDetailAuthor];
    self.praisePeoples = [aDecoder decodeObjectForKey:kFeedDetailPraisePeoples];
    self.groupModels = [aDecoder decodeObjectForKey:kFeedDetailGroupModels];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_groupModels forKey:kFeedDetailGroupModels];
    [aCoder encodeObject:_commentListItems forKey:kFeedDetailCommentListItems];
    [aCoder encodeObject:_tags forKey:kFeedDetailTags];
    [aCoder encodeObject:_feed forKey:kFeedDetailFeed];
    [aCoder encodeObject:_author forKey:kFeedDetailAuthor];
    [aCoder encodeObject:_praisePeoples forKey:kFeedDetailPraisePeoples];
}

- (id)copyWithZone:(NSZone *)zone
{
    FeedDetail *copy = [[FeedDetail alloc] init];
    
    if (copy) {
        copy.groupModels = [self.groupModels copyWithZone:zone];
        copy.commentListItems = [self.commentListItems copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
        copy.feed = [self.feed copyWithZone:zone];
        copy.author = [self.author copyWithZone:zone];
        copy.praisePeoples = [self.praisePeoples copyWithZone:zone];
    }
    
    return copy;
}


@end
