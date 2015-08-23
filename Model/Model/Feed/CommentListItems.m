//
//  CommentListItems.m
//
//  Created by   on 15/8/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CommentListItems.h"
#import "Comment.h"
#import "Author.h"


NSString *const kCommentListItemsComment = @"comment";
NSString *const kCommentListItemsAuthor = @"author";
NSString *const kCommentListItemsReplyUser = @"replyUser";


@interface CommentListItems ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommentListItems

@synthesize comment = _comment;
@synthesize author = _author;
@synthesize replyUser = _replyUser;


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
            self.comment = [Comment modelObjectWithDictionary:[dict objectForKey:kCommentListItemsComment]];
            self.author = [Author modelObjectWithDictionary:[dict objectForKey:kCommentListItemsAuthor]];
            self.replyUser = [Author modelObjectWithDictionary:[dict objectForKey:kCommentListItemsReplyUser]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.comment dictionaryRepresentation] forKey:kCommentListItemsComment];
    [mutableDict setValue:[self.author dictionaryRepresentation] forKey:kCommentListItemsAuthor];
    [mutableDict setValue:[self.replyUser dictionaryRepresentation] forKey:kCommentListItemsReplyUser];

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

    self.comment = [aDecoder decodeObjectForKey:kCommentListItemsComment];
    self.author = [aDecoder decodeObjectForKey:kCommentListItemsAuthor];
    self.replyUser = [aDecoder decodeObjectForKey:kCommentListItemsReplyUser];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_comment forKey:kCommentListItemsComment];
    [aCoder encodeObject:_author forKey:kCommentListItemsAuthor];
    [aCoder encodeObject:_replyUser forKey:kCommentListItemsReplyUser];
}

- (id)copyWithZone:(NSZone *)zone
{
    CommentListItems *copy = [[CommentListItems alloc] init];
    
    if (copy) {

        copy.comment = [self.comment copyWithZone:zone];
        copy.author = [self.author copyWithZone:zone];
        copy.replyUser = [self.replyUser copyWithZone:zone];
    }
    
    return copy;
}


@end
