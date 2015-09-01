//
//  ClassList.m
//
//  Created by   on 15/9/1
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ClassList.h"


NSString *const kClassListIcon = @"icon";
NSString *const kClassListThirdCode = @"thirdCode";
NSString *const kClassListSchoolCode = @"schoolCode";
NSString *const kClassListId = @"id";
NSString *const kClassListIsRemind = @"isRemind";
NSString *const kClassListLinkType = @"linkType";
NSString *const kClassListName = @"name";
NSString *const kClassListGid = @"gid";


@interface ClassList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ClassList

@synthesize icon = _icon;
@synthesize thirdCode = _thirdCode;
@synthesize schoolCode = _schoolCode;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize isRemind = _isRemind;
@synthesize linkType = _linkType;
@synthesize name = _name;
@synthesize gid = _gid;


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
            self.icon = [self objectOrNilForKey:kClassListIcon fromDictionary:dict];
            self.thirdCode = [self objectOrNilForKey:kClassListThirdCode fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kClassListSchoolCode fromDictionary:dict];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kClassListId fromDictionary:dict] doubleValue];
            self.isRemind = [self objectOrNilForKey:kClassListIsRemind fromDictionary:dict];
            self.linkType = [[self objectOrNilForKey:kClassListLinkType fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kClassListName fromDictionary:dict];
            self.gid = [self objectOrNilForKey:kClassListGid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.icon forKey:kClassListIcon];
    [mutableDict setValue:self.thirdCode forKey:kClassListThirdCode];
    [mutableDict setValue:self.schoolCode forKey:kClassListSchoolCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kClassListId];
    [mutableDict setValue:self.isRemind forKey:kClassListIsRemind];
    [mutableDict setValue:[NSNumber numberWithDouble:self.linkType] forKey:kClassListLinkType];
    [mutableDict setValue:self.name forKey:kClassListName];
    [mutableDict setValue:self.gid forKey:kClassListGid];

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

    self.icon = [aDecoder decodeObjectForKey:kClassListIcon];
    self.thirdCode = [aDecoder decodeObjectForKey:kClassListThirdCode];
    self.schoolCode = [aDecoder decodeObjectForKey:kClassListSchoolCode];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kClassListId];
    self.isRemind = [aDecoder decodeObjectForKey:kClassListIsRemind];
    self.linkType = [aDecoder decodeDoubleForKey:kClassListLinkType];
    self.name = [aDecoder decodeObjectForKey:kClassListName];
    self.gid = [aDecoder decodeObjectForKey:kClassListGid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_icon forKey:kClassListIcon];
    [aCoder encodeObject:_thirdCode forKey:kClassListThirdCode];
    [aCoder encodeObject:_schoolCode forKey:kClassListSchoolCode];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kClassListId];
    [aCoder encodeObject:_isRemind forKey:kClassListIsRemind];
    [aCoder encodeDouble:_linkType forKey:kClassListLinkType];
    [aCoder encodeObject:_name forKey:kClassListName];
    [aCoder encodeObject:_gid forKey:kClassListGid];
}

- (id)copyWithZone:(NSZone *)zone
{
    ClassList *copy = [[ClassList alloc] init];
    
    if (copy) {

        copy.icon = [self.icon copyWithZone:zone];
        copy.thirdCode = [self.thirdCode copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.isRemind = [self.isRemind copyWithZone:zone];
        copy.linkType = self.linkType;
        copy.name = [self.name copyWithZone:zone];
        copy.gid = [self.gid copyWithZone:zone];
    }
    
    return copy;
}


@end
