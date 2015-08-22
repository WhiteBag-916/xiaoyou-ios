//
//  UnionList.m
//
//  Created by HuiYin  on 15/8/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UnionList.h"


NSString *const kUnionListId = @"id";
NSString *const kUnionListIcon = @"icon";
NSString *const kUnionListSchoolCode = @"schoolCode";
NSString *const kUnionListName = @"name";
NSString *const kUnionListThirdCode = @"thirdCode";
NSString *const kUnionListLinkType = @"linkType";


@interface UnionList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UnionList

@synthesize unionListIdentifier = _unionListIdentifier;
@synthesize icon = _icon;
@synthesize schoolCode = _schoolCode;
@synthesize name = _name;
@synthesize thirdCode = _thirdCode;
@synthesize linkType = _linkType;


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
            self.unionListIdentifier = [[self objectOrNilForKey:kUnionListId fromDictionary:dict] doubleValue];
            self.icon = [self objectOrNilForKey:kUnionListIcon fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kUnionListSchoolCode fromDictionary:dict];
            self.name = [self objectOrNilForKey:kUnionListName fromDictionary:dict];
            self.thirdCode = [self objectOrNilForKey:kUnionListThirdCode fromDictionary:dict];
            self.linkType = [[self objectOrNilForKey:kUnionListLinkType fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.unionListIdentifier] forKey:kUnionListId];
    [mutableDict setValue:self.icon forKey:kUnionListIcon];
    [mutableDict setValue:self.schoolCode forKey:kUnionListSchoolCode];
    [mutableDict setValue:self.name forKey:kUnionListName];
    [mutableDict setValue:self.thirdCode forKey:kUnionListThirdCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.linkType] forKey:kUnionListLinkType];

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

    self.unionListIdentifier = [aDecoder decodeDoubleForKey:kUnionListId];
    self.icon = [aDecoder decodeObjectForKey:kUnionListIcon];
    self.schoolCode = [aDecoder decodeObjectForKey:kUnionListSchoolCode];
    self.name = [aDecoder decodeObjectForKey:kUnionListName];
    self.thirdCode = [aDecoder decodeObjectForKey:kUnionListThirdCode];
    self.linkType = [aDecoder decodeDoubleForKey:kUnionListLinkType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_unionListIdentifier forKey:kUnionListId];
    [aCoder encodeObject:_icon forKey:kUnionListIcon];
    [aCoder encodeObject:_schoolCode forKey:kUnionListSchoolCode];
    [aCoder encodeObject:_name forKey:kUnionListName];
    [aCoder encodeObject:_thirdCode forKey:kUnionListThirdCode];
    [aCoder encodeDouble:_linkType forKey:kUnionListLinkType];
}

- (id)copyWithZone:(NSZone *)zone
{
    UnionList *copy = [[UnionList alloc] init];
    
    if (copy) {

        copy.unionListIdentifier = self.unionListIdentifier;
        copy.icon = [self.icon copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.thirdCode = [self.thirdCode copyWithZone:zone];
        copy.linkType = self.linkType;
    }
    
    return copy;
}


@end
