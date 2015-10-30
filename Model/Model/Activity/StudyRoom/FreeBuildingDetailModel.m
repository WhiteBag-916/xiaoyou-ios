//
//  FreeBuildingDetailModel.m
//
//  Created by   on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FreeBuildingDetailModel.h"


NSString *const kFreeBuildingDetailModelRoomName = @"roomName";
NSString *const kFreeBuildingDetailModelRoomCode = @"roomCode";
NSString *const kFreeBuildingDetailModelCourseLists = @"courseLists";


@interface FreeBuildingDetailModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FreeBuildingDetailModel

@synthesize roomName = _roomName;
@synthesize roomCode = _roomCode;
@synthesize courseLists = _courseLists;


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
            self.roomName = [self objectOrNilForKey:kFreeBuildingDetailModelRoomName fromDictionary:dict];
            self.roomCode = [self objectOrNilForKey:kFreeBuildingDetailModelRoomCode fromDictionary:dict];
            self.courseLists = [self objectOrNilForKey:kFreeBuildingDetailModelCourseLists fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.roomName forKey:kFreeBuildingDetailModelRoomName];
    [mutableDict setValue:self.roomCode forKey:kFreeBuildingDetailModelRoomCode];
    NSMutableArray *tempArrayForCourseLists = [NSMutableArray array];
    for (NSObject *subArrayObject in self.courseLists) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCourseLists addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCourseLists addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCourseLists] forKey:kFreeBuildingDetailModelCourseLists];

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

    self.roomName = [aDecoder decodeObjectForKey:kFreeBuildingDetailModelRoomName];
    self.roomCode = [aDecoder decodeObjectForKey:kFreeBuildingDetailModelRoomCode];
    self.courseLists = [aDecoder decodeObjectForKey:kFreeBuildingDetailModelCourseLists];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_roomName forKey:kFreeBuildingDetailModelRoomName];
    [aCoder encodeObject:_roomCode forKey:kFreeBuildingDetailModelRoomCode];
    [aCoder encodeObject:_courseLists forKey:kFreeBuildingDetailModelCourseLists];
}

- (id)copyWithZone:(NSZone *)zone
{
    FreeBuildingDetailModel *copy = [[FreeBuildingDetailModel alloc] init];
    
    if (copy) {

        copy.roomName = [self.roomName copyWithZone:zone];
        copy.roomCode = [self.roomCode copyWithZone:zone];
        copy.courseLists = [self.courseLists copyWithZone:zone];
    }
    
    return copy;
}


@end
