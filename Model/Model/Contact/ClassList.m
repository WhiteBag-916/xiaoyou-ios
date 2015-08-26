//
//  ClassList.m
//
//  Created by HuiYin  on 15/8/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ClassList.h"


NSString *const kClassListId = @"id";
NSString *const kClassListIcon = @"icon";
NSString *const kClassListSchoolCode = @"schoolCode";
NSString *const kClassListName = @"name";
NSString *const kClassListThirdCode = @"thirdCode";
NSString *const kClassListLinkType = @"linkType";
NSString *const kClassListGid = @"gid";

@interface ClassList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ClassList

@synthesize classListIdentifier = _classListIdentifier;
@synthesize icon = _icon;
@synthesize schoolCode = _schoolCode;
@synthesize name = _name;
@synthesize thirdCode = _thirdCode;
@synthesize linkType = _linkType;
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
            self.classListIdentifier = [[self objectOrNilForKey:kClassListId fromDictionary:dict] doubleValue];
            self.icon = [self objectOrNilForKey:kClassListIcon fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kClassListSchoolCode fromDictionary:dict];
            self.name = [self objectOrNilForKey:kClassListName fromDictionary:dict];
            self.thirdCode = [self objectOrNilForKey:kClassListThirdCode fromDictionary:dict];
            self.linkType = [[self objectOrNilForKey:kClassListLinkType fromDictionary:dict] doubleValue];
        self.gid = [self objectOrNilForKey:kClassListGid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.classListIdentifier] forKey:kClassListId];
    [mutableDict setValue:self.icon forKey:kClassListIcon];
    [mutableDict setValue:self.schoolCode forKey:kClassListSchoolCode];
    [mutableDict setValue:self.name forKey:kClassListName];
    [mutableDict setValue:self.thirdCode forKey:kClassListThirdCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.linkType] forKey:kClassListLinkType];
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

    self.classListIdentifier = [aDecoder decodeDoubleForKey:kClassListId];
    self.icon = [aDecoder decodeObjectForKey:kClassListIcon];
    self.schoolCode = [aDecoder decodeObjectForKey:kClassListSchoolCode];
    self.name = [aDecoder decodeObjectForKey:kClassListName];
    self.thirdCode = [aDecoder decodeObjectForKey:kClassListThirdCode];
    self.linkType = [aDecoder decodeDoubleForKey:kClassListLinkType];
    self.gid = [aDecoder decodeObjectForKey:kClassListGid];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_classListIdentifier forKey:kClassListId];
    [aCoder encodeObject:_icon forKey:kClassListIcon];
    [aCoder encodeObject:_schoolCode forKey:kClassListSchoolCode];
    [aCoder encodeObject:_name forKey:kClassListName];
    [aCoder encodeObject:_thirdCode forKey:kClassListThirdCode];
    [aCoder encodeDouble:_linkType forKey:kClassListLinkType];
    [aCoder encodeObject:_gid forKey:kClassListGid];
}

- (id)copyWithZone:(NSZone *)zone
{
    ClassList *copy = [[ClassList alloc] init];
    
    if (copy) {

        copy.classListIdentifier = self.classListIdentifier;
        copy.icon = [self.icon copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.thirdCode = [self.thirdCode copyWithZone:zone];
        copy.linkType = self.linkType;
        copy.gid = [self.gid copyWithZone:zone];
    }
    
    return copy;
}


@end
