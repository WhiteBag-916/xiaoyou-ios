//
//  LinkManList.m
//
//  Created by HuiYin  on 15/8/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LinkManList.h"


NSString *const kLinkManListId = @"id";
NSString *const kLinkManListFaculty = @"faculty";
NSString *const kLinkManListSchoolCode = @"schoolCode";
NSString *const kLinkManListThirdCode = @"thirdCode";
NSString *const kLinkManListStudentNo = @"studentNo";
NSString *const kLinkManListTags = @"tags";
NSString *const kLinkManListCollege = @"college";
NSString *const kLinkManListIcon = @"icon";
NSString *const kLinkManListIsShield = @"isShield";
NSString *const kLinkManListIsRemind = @"isRemind";
NSString *const kLinkManListLinkType = @"linkType";
NSString *const kLinkManListName = @"name";
NSString *const kLinkManListGender = @"gender";


@interface LinkManList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LinkManList

@synthesize linkManListIdentifier = _linkManListIdentifier;
@synthesize faculty = _faculty;
@synthesize schoolCode = _schoolCode;
@synthesize thirdCode = _thirdCode;
@synthesize studentNo = _studentNo;
@synthesize tags = _tags;
@synthesize college = _college;
@synthesize icon = _icon;
@synthesize isShield = _isShield;
@synthesize isRemind = _isRemind;
@synthesize linkType = _linkType;
@synthesize name = _name;
@synthesize gender = _gender;


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
            self.linkManListIdentifier = [[self objectOrNilForKey:kLinkManListId fromDictionary:dict] doubleValue];
            self.faculty = [self objectOrNilForKey:kLinkManListFaculty fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kLinkManListSchoolCode fromDictionary:dict];
            self.thirdCode = [self objectOrNilForKey:kLinkManListThirdCode fromDictionary:dict];
            self.studentNo = [self objectOrNilForKey:kLinkManListStudentNo fromDictionary:dict];
            self.tags = [self objectOrNilForKey:kLinkManListTags fromDictionary:dict];
            self.college = [self objectOrNilForKey:kLinkManListCollege fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kLinkManListIcon fromDictionary:dict];
            self.isShield = [self objectOrNilForKey:kLinkManListIsShield fromDictionary:dict];
            self.isRemind = [self objectOrNilForKey:kLinkManListIsRemind fromDictionary:dict];
            self.linkType = [[self objectOrNilForKey:kLinkManListLinkType fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kLinkManListName fromDictionary:dict];
            self.gender = [self objectOrNilForKey:kLinkManListGender fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.linkManListIdentifier] forKey:kLinkManListId];
    [mutableDict setValue:self.faculty forKey:kLinkManListFaculty];
    [mutableDict setValue:self.schoolCode forKey:kLinkManListSchoolCode];
    [mutableDict setValue:self.thirdCode forKey:kLinkManListThirdCode];
    [mutableDict setValue:self.studentNo forKey:kLinkManListStudentNo];
    [mutableDict setValue:self.tags forKey:kLinkManListTags];
    [mutableDict setValue:self.college forKey:kLinkManListCollege];
    [mutableDict setValue:self.icon forKey:kLinkManListIcon];
    [mutableDict setValue:self.isShield forKey:kLinkManListIsShield];
    [mutableDict setValue:self.isRemind forKey:kLinkManListIsRemind];
    [mutableDict setValue:[NSNumber numberWithDouble:self.linkType] forKey:kLinkManListLinkType];
    [mutableDict setValue:self.name forKey:kLinkManListName];
    [mutableDict setValue:self.gender forKey:kLinkManListGender];

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

    self.linkManListIdentifier = [aDecoder decodeDoubleForKey:kLinkManListId];
    self.faculty = [aDecoder decodeObjectForKey:kLinkManListFaculty];
    self.schoolCode = [aDecoder decodeObjectForKey:kLinkManListSchoolCode];
    self.thirdCode = [aDecoder decodeObjectForKey:kLinkManListThirdCode];
    self.studentNo = [aDecoder decodeObjectForKey:kLinkManListStudentNo];
    self.tags = [aDecoder decodeObjectForKey:kLinkManListTags];
    self.college = [aDecoder decodeObjectForKey:kLinkManListCollege];
    self.icon = [aDecoder decodeObjectForKey:kLinkManListIcon];
    self.isShield = [aDecoder decodeObjectForKey:kLinkManListIsShield];
    self.isRemind = [aDecoder decodeObjectForKey:kLinkManListIsRemind];
    self.linkType = [aDecoder decodeDoubleForKey:kLinkManListLinkType];
    self.name = [aDecoder decodeObjectForKey:kLinkManListName];
    self.gender = [aDecoder decodeObjectForKey:kLinkManListGender];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_linkManListIdentifier forKey:kLinkManListId];
    [aCoder encodeObject:_faculty forKey:kLinkManListFaculty];
    [aCoder encodeObject:_schoolCode forKey:kLinkManListSchoolCode];
    [aCoder encodeObject:_thirdCode forKey:kLinkManListThirdCode];
    [aCoder encodeObject:_studentNo forKey:kLinkManListStudentNo];
    [aCoder encodeObject:_tags forKey:kLinkManListTags];
    [aCoder encodeObject:_college forKey:kLinkManListCollege];
    [aCoder encodeObject:_icon forKey:kLinkManListIcon];
    [aCoder encodeObject:_isShield forKey:kLinkManListIsShield];
    [aCoder encodeObject:_isRemind forKey:kLinkManListIsRemind];
    [aCoder encodeDouble:_linkType forKey:kLinkManListLinkType];
    [aCoder encodeObject:_name forKey:kLinkManListName];
    [aCoder encodeObject:_gender forKey:kLinkManListGender];
}

- (id)copyWithZone:(NSZone *)zone
{
    LinkManList *copy = [[LinkManList alloc] init];
    
    if (copy) {

        copy.linkManListIdentifier = self.linkManListIdentifier;
        copy.faculty = [self.faculty copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.thirdCode = [self.thirdCode copyWithZone:zone];
        copy.studentNo = [self.studentNo copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
        copy.college = [self.college copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.isShield = [self.isShield copyWithZone:zone];
        copy.isRemind = [self.isRemind copyWithZone:zone];
        copy.linkType = self.linkType;
        copy.name = [self.name copyWithZone:zone];
        copy.gender = [self.gender copyWithZone:zone];
    }
    
    return copy;
}


@end
