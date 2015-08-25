//
//  ApplicantList.m
//
//  Created by   on 15/8/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ApplicantList.h"
#import "Author.h"


NSString *const kApplicantListGroupId = @"groupId";
NSString *const kApplicantListApplyId = @"applyId";
NSString *const kApplicantListStatus = @"status";
NSString *const kApplicantListAuthor = @"author";


@interface ApplicantList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ApplicantList

@synthesize groupId = _groupId;
@synthesize applyId = _applyId;
@synthesize status = _status;
@synthesize author = _author;


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
            self.groupId = [[self objectOrNilForKey:kApplicantListGroupId fromDictionary:dict] doubleValue];
            self.applyId = [[self objectOrNilForKey:kApplicantListApplyId fromDictionary:dict] doubleValue];
            self.status = [[self objectOrNilForKey:kApplicantListStatus fromDictionary:dict] doubleValue];
            self.author = [Author modelObjectWithDictionary:[dict objectForKey:kApplicantListAuthor]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.groupId] forKey:kApplicantListGroupId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.applyId] forKey:kApplicantListApplyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kApplicantListStatus];
    [mutableDict setValue:[self.author dictionaryRepresentation] forKey:kApplicantListAuthor];

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

    self.groupId = [aDecoder decodeDoubleForKey:kApplicantListGroupId];
    self.applyId = [aDecoder decodeDoubleForKey:kApplicantListApplyId];
    self.status = [aDecoder decodeDoubleForKey:kApplicantListStatus];
    self.author = [aDecoder decodeObjectForKey:kApplicantListAuthor];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_groupId forKey:kApplicantListGroupId];
    [aCoder encodeDouble:_applyId forKey:kApplicantListApplyId];
    [aCoder encodeDouble:_status forKey:kApplicantListStatus];
    [aCoder encodeObject:_author forKey:kApplicantListAuthor];
}

- (id)copyWithZone:(NSZone *)zone
{
    ApplicantList *copy = [[ApplicantList alloc] init];
    
    if (copy) {

        copy.groupId = self.groupId;
        copy.applyId = self.applyId;
        copy.status = self.status;
        copy.author = [self.author copyWithZone:zone];
    }
    
    return copy;
}


@end
