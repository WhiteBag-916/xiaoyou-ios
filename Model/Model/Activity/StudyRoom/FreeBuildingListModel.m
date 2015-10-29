//
//  FreeBuildingListModel.m
//
//  Created by   on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FreeBuildingListModel.h"


NSString *const kFreeBuildingListModelRoomCount = @"roomCount";
NSString *const kFreeBuildingListModelBuildName = @"buildName";


@interface FreeBuildingListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FreeBuildingListModel

@synthesize roomCount = _roomCount;
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
            self.roomCount = [[self objectOrNilForKey:kFreeBuildingListModelRoomCount fromDictionary:dict] doubleValue];
            self.buildName = [self objectOrNilForKey:kFreeBuildingListModelBuildName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.roomCount] forKey:kFreeBuildingListModelRoomCount];
    [mutableDict setValue:self.buildName forKey:kFreeBuildingListModelBuildName];

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

    self.roomCount = [aDecoder decodeDoubleForKey:kFreeBuildingListModelRoomCount];
    self.buildName = [aDecoder decodeObjectForKey:kFreeBuildingListModelBuildName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_roomCount forKey:kFreeBuildingListModelRoomCount];
    [aCoder encodeObject:_buildName forKey:kFreeBuildingListModelBuildName];
}

- (id)copyWithZone:(NSZone *)zone
{
    FreeBuildingListModel *copy = [[FreeBuildingListModel alloc] init];
    
    if (copy) {

        copy.roomCount = self.roomCount;
        copy.buildName = [self.buildName copyWithZone:zone];
    }
    
    return copy;
}


@end
