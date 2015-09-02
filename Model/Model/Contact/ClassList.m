//
//  ClassList.m
//
//  Created by   on 15/9/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ClassList.h"


NSString *const kClassListGid = @"gid";
NSString *const kClassListThirdCode = @"thirdCode";
NSString *const kClassListSchoolCode = @"schoolCode";
NSString *const kClassListId = @"id";
NSString *const kClassListIsRemind = @"isRemind";
NSString *const kClassListLinkType = @"linkType";
NSString *const kClassListIcon = @"icon";
NSString *const kClassListName = @"name";


@interface ClassList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ClassList

@synthesize gid = _gid;
@synthesize thirdCode = _thirdCode;
@synthesize schoolCode = _schoolCode;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize isRemind = _isRemind;
@synthesize linkType = _linkType;
@synthesize icon = _icon;
@synthesize name = _name;


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
            self.gid = [[self objectOrNilForKey:kClassListGid fromDictionary:dict] doubleValue];
            self.thirdCode = [self objectOrNilForKey:kClassListThirdCode fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kClassListSchoolCode fromDictionary:dict];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kClassListId fromDictionary:dict] doubleValue];
            self.isRemind = [self objectOrNilForKey:kClassListIsRemind fromDictionary:dict];
            self.linkType = [[self objectOrNilForKey:kClassListLinkType fromDictionary:dict] doubleValue];
            self.icon = [self objectOrNilForKey:kClassListIcon fromDictionary:dict];
            self.name = [self objectOrNilForKey:kClassListName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.gid] forKey:kClassListGid];
    [mutableDict setValue:self.thirdCode forKey:kClassListThirdCode];
    [mutableDict setValue:self.schoolCode forKey:kClassListSchoolCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kClassListId];
    [mutableDict setValue:self.isRemind forKey:kClassListIsRemind];
    [mutableDict setValue:[NSNumber numberWithDouble:self.linkType] forKey:kClassListLinkType];
    [mutableDict setValue:self.icon forKey:kClassListIcon];
    [mutableDict setValue:self.name forKey:kClassListName];

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

    self.gid = [aDecoder decodeDoubleForKey:kClassListGid];
    self.thirdCode = [aDecoder decodeObjectForKey:kClassListThirdCode];
    self.schoolCode = [aDecoder decodeObjectForKey:kClassListSchoolCode];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kClassListId];
    self.isRemind = [aDecoder decodeObjectForKey:kClassListIsRemind];
    self.linkType = [aDecoder decodeDoubleForKey:kClassListLinkType];
    self.icon = [aDecoder decodeObjectForKey:kClassListIcon];
    self.name = [aDecoder decodeObjectForKey:kClassListName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_gid forKey:kClassListGid];
    [aCoder encodeObject:_thirdCode forKey:kClassListThirdCode];
    [aCoder encodeObject:_schoolCode forKey:kClassListSchoolCode];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kClassListId];
    [aCoder encodeObject:_isRemind forKey:kClassListIsRemind];
    [aCoder encodeDouble:_linkType forKey:kClassListLinkType];
    [aCoder encodeObject:_icon forKey:kClassListIcon];
    [aCoder encodeObject:_name forKey:kClassListName];
}

- (id)copyWithZone:(NSZone *)zone
{
    ClassList *copy = [[ClassList alloc] init];
    
    if (copy) {

        copy.gid = self.gid;
        copy.thirdCode = [self.thirdCode copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.isRemind = [self.isRemind copyWithZone:zone];
        copy.linkType = self.linkType;
        copy.icon = [self.icon copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
