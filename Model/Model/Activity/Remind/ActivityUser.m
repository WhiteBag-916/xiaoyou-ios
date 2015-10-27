//
//  ActivityUser.m
//
//  Created by sheng  on 15/10/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ActivityUser.h"
#import "TagCodes.h"
#import "GroupCodes.h"
#import "CityCode.h"
#import "PropetiesCommon.h"
#import "TagsCommon.h"
#import "ProvinceCode.h"
#import "ClassCodes.h"


NSString *const kActivityUserGender = @"gender";
NSString *const kActivityUserFaculty = @"faculty";
NSString *const kActivityUserSchoolCode = @"schoolCode";
NSString *const kActivityUserUid = @"uid";
NSString *const kActivityUserTagCodes = @"tagCodes";
NSString *const kActivityUserGroupCodes = @"groupCodes";
NSString *const kActivityUserStudentNo = @"studentNo";
NSString *const kActivityUserCityCode = @"cityCode";
NSString *const kActivityUserCollege = @"college";
NSString *const kActivityUserGrad = @"grad";
NSString *const kActivityUserPropetiesCommon = @"propetiesCommon";
NSString *const kActivityUserFriendStatus = @"friendStatus";
NSString *const kActivityUserTagsCommon = @"tagsCommon";
NSString *const kActivityUserProvinceCode = @"ProvinceCode";
NSString *const kActivityUserClassCodes = @"classCodes";
NSString *const kActivityUserName = @"name";
NSString *const kActivityUserHeadPic = @"headPic";


@interface ActivityUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ActivityUser

@synthesize gender = _gender;
@synthesize faculty = _faculty;
@synthesize schoolCode = _schoolCode;
@synthesize uid = _uid;
@synthesize tagCodes = _tagCodes;
@synthesize groupCodes = _groupCodes;
@synthesize studentNo = _studentNo;
@synthesize cityCode = _cityCode;
@synthesize college = _college;
@synthesize grad = _grad;
@synthesize propetiesCommon = _propetiesCommon;
@synthesize friendStatus = _friendStatus;
@synthesize tagsCommon = _tagsCommon;
@synthesize provinceCode = _provinceCode;
@synthesize classCodes = _classCodes;
@synthesize name = _name;
@synthesize headPic = _headPic;


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
            self.gender = [self objectOrNilForKey:kActivityUserGender fromDictionary:dict];
            self.faculty = [self objectOrNilForKey:kActivityUserFaculty fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kActivityUserSchoolCode fromDictionary:dict];
            self.uid = [self objectOrNilForKey:kActivityUserUid fromDictionary:dict];
    NSObject *receivedTagCodes = [dict objectForKey:kActivityUserTagCodes];
    NSMutableArray *parsedTagCodes = [NSMutableArray array];
    if ([receivedTagCodes isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTagCodes) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTagCodes addObject:[TagCodes modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTagCodes isKindOfClass:[NSDictionary class]]) {
       [parsedTagCodes addObject:[TagCodes modelObjectWithDictionary:(NSDictionary *)receivedTagCodes]];
    }

    self.tagCodes = [NSArray arrayWithArray:parsedTagCodes];
    NSObject *receivedGroupCodes = [dict objectForKey:kActivityUserGroupCodes];
    NSMutableArray *parsedGroupCodes = [NSMutableArray array];
    if ([receivedGroupCodes isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedGroupCodes) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedGroupCodes addObject:[GroupCodes modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedGroupCodes isKindOfClass:[NSDictionary class]]) {
       [parsedGroupCodes addObject:[GroupCodes modelObjectWithDictionary:(NSDictionary *)receivedGroupCodes]];
    }

    self.groupCodes = [NSArray arrayWithArray:parsedGroupCodes];
            self.studentNo = [self objectOrNilForKey:kActivityUserStudentNo fromDictionary:dict];
            self.cityCode = [CityCode modelObjectWithDictionary:[dict objectForKey:kActivityUserCityCode]];
            self.college = [self objectOrNilForKey:kActivityUserCollege fromDictionary:dict];
            self.grad = [self objectOrNilForKey:kActivityUserGrad fromDictionary:dict];
    NSObject *receivedPropetiesCommon = [dict objectForKey:kActivityUserPropetiesCommon];
    NSMutableArray *parsedPropetiesCommon = [NSMutableArray array];
    if ([receivedPropetiesCommon isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPropetiesCommon) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPropetiesCommon addObject:[PropetiesCommon modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPropetiesCommon isKindOfClass:[NSDictionary class]]) {
       [parsedPropetiesCommon addObject:[PropetiesCommon modelObjectWithDictionary:(NSDictionary *)receivedPropetiesCommon]];
    }

    self.propetiesCommon = [NSArray arrayWithArray:parsedPropetiesCommon];
            self.friendStatus = [self objectOrNilForKey:kActivityUserFriendStatus fromDictionary:dict];
    NSObject *receivedTagsCommon = [dict objectForKey:kActivityUserTagsCommon];
    NSMutableArray *parsedTagsCommon = [NSMutableArray array];
    if ([receivedTagsCommon isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTagsCommon) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTagsCommon addObject:[TagsCommon modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTagsCommon isKindOfClass:[NSDictionary class]]) {
       [parsedTagsCommon addObject:[TagsCommon modelObjectWithDictionary:(NSDictionary *)receivedTagsCommon]];
    }

    self.tagsCommon = [NSArray arrayWithArray:parsedTagsCommon];
            self.provinceCode = [ProvinceCode modelObjectWithDictionary:[dict objectForKey:kActivityUserProvinceCode]];
    NSObject *receivedClassCodes = [dict objectForKey:kActivityUserClassCodes];
    NSMutableArray *parsedClassCodes = [NSMutableArray array];
    if ([receivedClassCodes isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedClassCodes) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedClassCodes addObject:[ClassCodes modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedClassCodes isKindOfClass:[NSDictionary class]]) {
       [parsedClassCodes addObject:[ClassCodes modelObjectWithDictionary:(NSDictionary *)receivedClassCodes]];
    }

    self.classCodes = [NSArray arrayWithArray:parsedClassCodes];
            self.name = [self objectOrNilForKey:kActivityUserName fromDictionary:dict];
            self.headPic = [self objectOrNilForKey:kActivityUserHeadPic fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.gender forKey:kActivityUserGender];
    [mutableDict setValue:self.faculty forKey:kActivityUserFaculty];
    [mutableDict setValue:self.schoolCode forKey:kActivityUserSchoolCode];
    [mutableDict setValue:self.uid forKey:kActivityUserUid];
    NSMutableArray *tempArrayForTagCodes = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tagCodes) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTagCodes addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTagCodes addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTagCodes] forKey:kActivityUserTagCodes];
    NSMutableArray *tempArrayForGroupCodes = [NSMutableArray array];
    for (NSObject *subArrayObject in self.groupCodes) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForGroupCodes addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForGroupCodes addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGroupCodes] forKey:kActivityUserGroupCodes];
    [mutableDict setValue:self.studentNo forKey:kActivityUserStudentNo];
    [mutableDict setValue:[self.cityCode dictionaryRepresentation] forKey:kActivityUserCityCode];
    [mutableDict setValue:self.college forKey:kActivityUserCollege];
    [mutableDict setValue:self.grad forKey:kActivityUserGrad];
    NSMutableArray *tempArrayForPropetiesCommon = [NSMutableArray array];
    for (NSObject *subArrayObject in self.propetiesCommon) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPropetiesCommon addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPropetiesCommon addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPropetiesCommon] forKey:kActivityUserPropetiesCommon];
    [mutableDict setValue:self.friendStatus forKey:kActivityUserFriendStatus];
    NSMutableArray *tempArrayForTagsCommon = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tagsCommon) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTagsCommon addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTagsCommon addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTagsCommon] forKey:kActivityUserTagsCommon];
    [mutableDict setValue:[self.provinceCode dictionaryRepresentation] forKey:kActivityUserProvinceCode];
    NSMutableArray *tempArrayForClassCodes = [NSMutableArray array];
    for (NSObject *subArrayObject in self.classCodes) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForClassCodes addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForClassCodes addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForClassCodes] forKey:kActivityUserClassCodes];
    [mutableDict setValue:self.name forKey:kActivityUserName];
    [mutableDict setValue:self.headPic forKey:kActivityUserHeadPic];

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

    self.gender = [aDecoder decodeObjectForKey:kActivityUserGender];
    self.faculty = [aDecoder decodeObjectForKey:kActivityUserFaculty];
    self.schoolCode = [aDecoder decodeObjectForKey:kActivityUserSchoolCode];
    self.uid = [aDecoder decodeObjectForKey:kActivityUserUid];
    self.tagCodes = [aDecoder decodeObjectForKey:kActivityUserTagCodes];
    self.groupCodes = [aDecoder decodeObjectForKey:kActivityUserGroupCodes];
    self.studentNo = [aDecoder decodeObjectForKey:kActivityUserStudentNo];
    self.cityCode = [aDecoder decodeObjectForKey:kActivityUserCityCode];
    self.college = [aDecoder decodeObjectForKey:kActivityUserCollege];
    self.grad = [aDecoder decodeObjectForKey:kActivityUserGrad];
    self.propetiesCommon = [aDecoder decodeObjectForKey:kActivityUserPropetiesCommon];
    self.friendStatus = [aDecoder decodeObjectForKey:kActivityUserFriendStatus];
    self.tagsCommon = [aDecoder decodeObjectForKey:kActivityUserTagsCommon];
    self.provinceCode = [aDecoder decodeObjectForKey:kActivityUserProvinceCode];
    self.classCodes = [aDecoder decodeObjectForKey:kActivityUserClassCodes];
    self.name = [aDecoder decodeObjectForKey:kActivityUserName];
    self.headPic = [aDecoder decodeObjectForKey:kActivityUserHeadPic];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_gender forKey:kActivityUserGender];
    [aCoder encodeObject:_faculty forKey:kActivityUserFaculty];
    [aCoder encodeObject:_schoolCode forKey:kActivityUserSchoolCode];
    [aCoder encodeObject:_uid forKey:kActivityUserUid];
    [aCoder encodeObject:_tagCodes forKey:kActivityUserTagCodes];
    [aCoder encodeObject:_groupCodes forKey:kActivityUserGroupCodes];
    [aCoder encodeObject:_studentNo forKey:kActivityUserStudentNo];
    [aCoder encodeObject:_cityCode forKey:kActivityUserCityCode];
    [aCoder encodeObject:_college forKey:kActivityUserCollege];
    [aCoder encodeObject:_grad forKey:kActivityUserGrad];
    [aCoder encodeObject:_propetiesCommon forKey:kActivityUserPropetiesCommon];
    [aCoder encodeObject:_friendStatus forKey:kActivityUserFriendStatus];
    [aCoder encodeObject:_tagsCommon forKey:kActivityUserTagsCommon];
    [aCoder encodeObject:_provinceCode forKey:kActivityUserProvinceCode];
    [aCoder encodeObject:_classCodes forKey:kActivityUserClassCodes];
    [aCoder encodeObject:_name forKey:kActivityUserName];
    [aCoder encodeObject:_headPic forKey:kActivityUserHeadPic];
}

- (id)copyWithZone:(NSZone *)zone
{
    ActivityUser *copy = [[ActivityUser alloc] init];
    
    if (copy) {

        copy.gender = [self.gender copyWithZone:zone];
        copy.faculty = [self.faculty copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.tagCodes = [self.tagCodes copyWithZone:zone];
        copy.groupCodes = [self.groupCodes copyWithZone:zone];
        copy.studentNo = [self.studentNo copyWithZone:zone];
        copy.cityCode = [self.cityCode copyWithZone:zone];
        copy.college = [self.college copyWithZone:zone];
        copy.grad = [self.grad copyWithZone:zone];
        copy.propetiesCommon = [self.propetiesCommon copyWithZone:zone];
        copy.friendStatus = [self.friendStatus copyWithZone:zone];
        copy.tagsCommon = [self.tagsCommon copyWithZone:zone];
        copy.provinceCode = [self.provinceCode copyWithZone:zone];
        copy.classCodes = [self.classCodes copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.headPic = [self.headPic copyWithZone:zone];
    }
    
    return copy;
}


@end
