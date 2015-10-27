//
//  ActivityOrganizer.m
//
//  Created by   on 15/10/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ActivityOrganizer.h"


NSString *const kActivityOrganizerHeadPic = @"headPic";
NSString *const kActivityOrganizerUid = @"uid";
NSString *const kActivityOrganizerName = @"name";
NSString *const kActivityOrganizerUserType = @"userType";


@interface ActivityOrganizer ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ActivityOrganizer

@synthesize headPic = _headPic;
@synthesize uid = _uid;
@synthesize name = _name;
@synthesize userType = _userType;


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
            self.headPic = [self objectOrNilForKey:kActivityOrganizerHeadPic fromDictionary:dict];
            self.uid = [self objectOrNilForKey:kActivityOrganizerUid fromDictionary:dict];
            self.name = [self objectOrNilForKey:kActivityOrganizerName fromDictionary:dict];
            self.userType = [self objectOrNilForKey:kActivityOrganizerUserType fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.headPic forKey:kActivityOrganizerHeadPic];
    [mutableDict setValue:self.uid forKey:kActivityOrganizerUid];
    [mutableDict setValue:self.name forKey:kActivityOrganizerName];
    [mutableDict setValue:self.userType forKey:kActivityOrganizerUserType];

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

    self.headPic = [aDecoder decodeObjectForKey:kActivityOrganizerHeadPic];
    self.uid = [aDecoder decodeObjectForKey:kActivityOrganizerUid];
    self.name = [aDecoder decodeObjectForKey:kActivityOrganizerName];
    self.userType = [aDecoder decodeObjectForKey:kActivityOrganizerUserType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_headPic forKey:kActivityOrganizerHeadPic];
    [aCoder encodeObject:_uid forKey:kActivityOrganizerUid];
    [aCoder encodeObject:_name forKey:kActivityOrganizerName];
    [aCoder encodeObject:_userType forKey:kActivityOrganizerUserType];
}

- (id)copyWithZone:(NSZone *)zone
{
    ActivityOrganizer *copy = [[ActivityOrganizer alloc] init];
    
    if (copy) {

        copy.headPic = [self.headPic copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.userType = [self.userType copyWithZone:zone];
    }
    
    return copy;
}


@end
