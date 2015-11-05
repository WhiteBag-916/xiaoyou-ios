//
//  Scheduling.m
//
//  Created by sheng  on 15/11/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Scheduling.h"


NSString *const kSchedulingStartTime = @"startTime";
NSString *const kSchedulingId = @"id";
NSString *const kSchedulingContent = @"content";
NSString *const kSchedulingUid = @"uid";
NSString *const kSchedulingEndTime = @"endTime";
NSString *const kSchedulingType = @"type";


@interface Scheduling ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Scheduling

@synthesize startTime = _startTime;
@synthesize schedulingIdentifier = _schedulingIdentifier;
@synthesize content = _content;
@synthesize uid = _uid;
@synthesize endTime = _endTime;
@synthesize type = _type;


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
            self.startTime = [[self objectOrNilForKey:kSchedulingStartTime fromDictionary:dict] doubleValue];
            self.schedulingIdentifier = [[self objectOrNilForKey:kSchedulingId fromDictionary:dict] doubleValue];
            self.content = [self objectOrNilForKey:kSchedulingContent fromDictionary:dict];
            self.uid = [self objectOrNilForKey:kSchedulingUid fromDictionary:dict];
            self.endTime = [[self objectOrNilForKey:kSchedulingEndTime fromDictionary:dict] doubleValue];
            self.type = [self objectOrNilForKey:kSchedulingType fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startTime] forKey:kSchedulingStartTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.schedulingIdentifier] forKey:kSchedulingId];
    [mutableDict setValue:self.content forKey:kSchedulingContent];
    [mutableDict setValue:self.uid forKey:kSchedulingUid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endTime] forKey:kSchedulingEndTime];
    [mutableDict setValue:self.type forKey:kSchedulingType];

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

    self.startTime = [aDecoder decodeDoubleForKey:kSchedulingStartTime];
    self.schedulingIdentifier = [aDecoder decodeDoubleForKey:kSchedulingId];
    self.content = [aDecoder decodeObjectForKey:kSchedulingContent];
    self.uid = [aDecoder decodeObjectForKey:kSchedulingUid];
    self.endTime = [aDecoder decodeDoubleForKey:kSchedulingEndTime];
    self.type = [aDecoder decodeObjectForKey:kSchedulingType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_startTime forKey:kSchedulingStartTime];
    [aCoder encodeDouble:_schedulingIdentifier forKey:kSchedulingId];
    [aCoder encodeObject:_content forKey:kSchedulingContent];
    [aCoder encodeObject:_uid forKey:kSchedulingUid];
    [aCoder encodeDouble:_endTime forKey:kSchedulingEndTime];
    [aCoder encodeObject:_type forKey:kSchedulingType];
}

- (id)copyWithZone:(NSZone *)zone
{
    Scheduling *copy = [[Scheduling alloc] init];
    
    if (copy) {

        copy.startTime = self.startTime;
        copy.schedulingIdentifier = self.schedulingIdentifier;
        copy.content = [self.content copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.endTime = self.endTime;
        copy.type = [self.type copyWithZone:zone];
    }
    
    return copy;
}


@end
