//
//  ActivityImageTextModels.m
//
//  Created by   on 15/10/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ActivityImageTextModels.h"


NSString *const kActivityImageTextModelsOpUser = @"opUser";
NSString *const kActivityImageTextModelsContent = @"content";
NSString *const kActivityImageTextModelsActivityId = @"activityId";
NSString *const kActivityImageTextModelsId = @"id";
NSString *const kActivityImageTextModelsUpdateTime = @"updateTime";
NSString *const kActivityImageTextModelsDisplayOrder = @"displayOrder";
NSString *const kActivityImageTextModelsType = @"type";
NSString *const kActivityImageTextModelsCreateTime = @"createTime";


@interface ActivityImageTextModels ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ActivityImageTextModels

@synthesize opUser = _opUser;
@synthesize content = _content;
@synthesize activityId = _activityId;
@synthesize activityImageTextModelsIdentifier = _activityImageTextModelsIdentifier;
@synthesize updateTime = _updateTime;
@synthesize displayOrder = _displayOrder;
@synthesize type = _type;
@synthesize createTime = _createTime;


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
            self.opUser = [self objectOrNilForKey:kActivityImageTextModelsOpUser fromDictionary:dict];
            self.content = [self objectOrNilForKey:kActivityImageTextModelsContent fromDictionary:dict];
            self.activityId = [[self objectOrNilForKey:kActivityImageTextModelsActivityId fromDictionary:dict] doubleValue];
            self.activityImageTextModelsIdentifier = [[self objectOrNilForKey:kActivityImageTextModelsId fromDictionary:dict] doubleValue];
            self.updateTime = [[self objectOrNilForKey:kActivityImageTextModelsUpdateTime fromDictionary:dict] doubleValue];
            self.displayOrder = [[self objectOrNilForKey:kActivityImageTextModelsDisplayOrder fromDictionary:dict] doubleValue];
            self.type = [self objectOrNilForKey:kActivityImageTextModelsType fromDictionary:dict];
            self.createTime = [[self objectOrNilForKey:kActivityImageTextModelsCreateTime fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.opUser forKey:kActivityImageTextModelsOpUser];
    [mutableDict setValue:self.content forKey:kActivityImageTextModelsContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.activityId] forKey:kActivityImageTextModelsActivityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.activityImageTextModelsIdentifier] forKey:kActivityImageTextModelsId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateTime] forKey:kActivityImageTextModelsUpdateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.displayOrder] forKey:kActivityImageTextModelsDisplayOrder];
    [mutableDict setValue:self.type forKey:kActivityImageTextModelsType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kActivityImageTextModelsCreateTime];

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

    self.opUser = [aDecoder decodeObjectForKey:kActivityImageTextModelsOpUser];
    self.content = [aDecoder decodeObjectForKey:kActivityImageTextModelsContent];
    self.activityId = [aDecoder decodeDoubleForKey:kActivityImageTextModelsActivityId];
    self.activityImageTextModelsIdentifier = [aDecoder decodeDoubleForKey:kActivityImageTextModelsId];
    self.updateTime = [aDecoder decodeDoubleForKey:kActivityImageTextModelsUpdateTime];
    self.displayOrder = [aDecoder decodeDoubleForKey:kActivityImageTextModelsDisplayOrder];
    self.type = [aDecoder decodeObjectForKey:kActivityImageTextModelsType];
    self.createTime = [aDecoder decodeDoubleForKey:kActivityImageTextModelsCreateTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_opUser forKey:kActivityImageTextModelsOpUser];
    [aCoder encodeObject:_content forKey:kActivityImageTextModelsContent];
    [aCoder encodeDouble:_activityId forKey:kActivityImageTextModelsActivityId];
    [aCoder encodeDouble:_activityImageTextModelsIdentifier forKey:kActivityImageTextModelsId];
    [aCoder encodeDouble:_updateTime forKey:kActivityImageTextModelsUpdateTime];
    [aCoder encodeDouble:_displayOrder forKey:kActivityImageTextModelsDisplayOrder];
    [aCoder encodeObject:_type forKey:kActivityImageTextModelsType];
    [aCoder encodeDouble:_createTime forKey:kActivityImageTextModelsCreateTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ActivityImageTextModels *copy = [[ActivityImageTextModels alloc] init];
    
    if (copy) {

        copy.opUser = [self.opUser copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.activityId = self.activityId;
        copy.activityImageTextModelsIdentifier = self.activityImageTextModelsIdentifier;
        copy.updateTime = self.updateTime;
        copy.displayOrder = self.displayOrder;
        copy.type = [self.type copyWithZone:zone];
        copy.createTime = self.createTime;
    }
    
    return copy;
}


@end
