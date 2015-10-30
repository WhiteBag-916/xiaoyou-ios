//
//  Result.m
//
//  Created by   on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Result.h"


NSString *const kResultRoomCount = @"roomCount";
NSString *const kResultSchoolArea = @"schoolArea";
NSString *const kResultBuildName = @"buildName";


@interface Result ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Result

@synthesize roomCount = _roomCount;
@synthesize schoolArea = _schoolArea;
@synthesize buildName = _buildName;


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
            self.roomCount = [[self objectOrNilForKey:kResultRoomCount fromDictionary:dict] doubleValue];
            self.schoolArea = [self objectOrNilForKey:kResultSchoolArea fromDictionary:dict];
            self.buildName = [self objectOrNilForKey:kResultBuildName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.roomCount] forKey:kResultRoomCount];
    [mutableDict setValue:self.schoolArea forKey:kResultSchoolArea];
    [mutableDict setValue:self.buildName forKey:kResultBuildName];

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

    self.roomCount = [aDecoder decodeDoubleForKey:kResultRoomCount];
    self.schoolArea = [aDecoder decodeObjectForKey:kResultSchoolArea];
    self.buildName = [aDecoder decodeObjectForKey:kResultBuildName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_roomCount forKey:kResultRoomCount];
    [aCoder encodeObject:_schoolArea forKey:kResultSchoolArea];
    [aCoder encodeObject:_buildName forKey:kResultBuildName];
}

- (id)copyWithZone:(NSZone *)zone
{
    Result *copy = [[Result alloc] init];
    
    if (copy) {

        copy.roomCount = self.roomCount;
        copy.schoolArea = [self.schoolArea copyWithZone:zone];
        copy.buildName = [self.buildName copyWithZone:zone];
    }
    
    return copy;
}


@end
