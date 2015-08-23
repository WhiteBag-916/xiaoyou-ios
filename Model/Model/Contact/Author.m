//
//  Author.m
//
//  Created by   on 15/8/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Author.h"
#import "Tags.h"
#import "ClassCodes.h"
#import "GroupCodes.h"


NSString *const kAuthorUid = @"uid";
NSString *const kAuthorSchoolCode = @"schoolCode";
NSString *const kAuthorHeadPic = @"headPic";
NSString *const kAuthorStudentNo = @"studentNo";
NSString *const kAuthorTagCodes = @"tagCodes";
NSString *const kAuthorClassCodes = @"classCodes";
NSString *const kAuthorName = @"name";
NSString *const kAuthorGroupCodes = @"groupCodes";


@interface Author ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Author

@synthesize uid = _uid;
@synthesize schoolCode = _schoolCode;
@synthesize headPic = _headPic;
@synthesize studentNo = _studentNo;
@synthesize tagCodes = _tagCodes;
@synthesize classCodes = _classCodes;
@synthesize name = _name;
@synthesize groupCodes = _groupCodes;


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
            self.uid = [self objectOrNilForKey:kAuthorUid fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kAuthorSchoolCode fromDictionary:dict];
            self.headPic = [self objectOrNilForKey:kAuthorHeadPic fromDictionary:dict];
            self.studentNo = [self objectOrNilForKey:kAuthorStudentNo fromDictionary:dict];
            self.tagCodes = [Tags modelObjectWithDictionary:[dict objectForKey:kAuthorTagCodes]];
            self.classCodes = [ClassCodes modelObjectWithDictionary:[dict objectForKey:kAuthorClassCodes]];
            self.name = [self objectOrNilForKey:kAuthorName fromDictionary:dict];
            self.groupCodes = [GroupCodes modelObjectWithDictionary:[dict objectForKey:kAuthorGroupCodes]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.uid forKey:kAuthorUid];
    [mutableDict setValue:self.schoolCode forKey:kAuthorSchoolCode];
    [mutableDict setValue:self.headPic forKey:kAuthorHeadPic];
    [mutableDict setValue:self.studentNo forKey:kAuthorStudentNo];
    [mutableDict setValue:[self.tagCodes dictionaryRepresentation] forKey:kAuthorTagCodes];
    [mutableDict setValue:[self.classCodes dictionaryRepresentation] forKey:kAuthorClassCodes];
    [mutableDict setValue:self.name forKey:kAuthorName];
    [mutableDict setValue:[self.groupCodes dictionaryRepresentation] forKey:kAuthorGroupCodes];

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

    self.uid = [aDecoder decodeObjectForKey:kAuthorUid];
    self.schoolCode = [aDecoder decodeObjectForKey:kAuthorSchoolCode];
    self.headPic = [aDecoder decodeObjectForKey:kAuthorHeadPic];
    self.studentNo = [aDecoder decodeObjectForKey:kAuthorStudentNo];
    self.tagCodes = [aDecoder decodeObjectForKey:kAuthorTagCodes];
    self.classCodes = [aDecoder decodeObjectForKey:kAuthorClassCodes];
    self.name = [aDecoder decodeObjectForKey:kAuthorName];
    self.groupCodes = [aDecoder decodeObjectForKey:kAuthorGroupCodes];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_uid forKey:kAuthorUid];
    [aCoder encodeObject:_schoolCode forKey:kAuthorSchoolCode];
    [aCoder encodeObject:_headPic forKey:kAuthorHeadPic];
    [aCoder encodeObject:_studentNo forKey:kAuthorStudentNo];
    [aCoder encodeObject:_tagCodes forKey:kAuthorTagCodes];
    [aCoder encodeObject:_classCodes forKey:kAuthorClassCodes];
    [aCoder encodeObject:_name forKey:kAuthorName];
    [aCoder encodeObject:_groupCodes forKey:kAuthorGroupCodes];
}

- (id)copyWithZone:(NSZone *)zone
{
    Author *copy = [[Author alloc] init];
    
    if (copy) {

        copy.uid = [self.uid copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.headPic = [self.headPic copyWithZone:zone];
        copy.studentNo = [self.studentNo copyWithZone:zone];
        copy.tagCodes = [self.tagCodes copyWithZone:zone];
        copy.classCodes = [self.classCodes copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.groupCodes = [self.groupCodes copyWithZone:zone];
    }
    
    return copy;
}


@end
