//
//  Author.m
//
//  Created by   on 15/8/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Author.h"
#import "ProvinceCode.h"
#import "Tags.h"
#import "ClassCodes.h"


NSString *const kAuthorProvinceCode = @"provinceCode";
NSString *const kAuthorUid = @"uid";
NSString *const kAuthorSchoolCode = @"schoolCode";
NSString *const kAuthorTagsCommon = @"tagsCommon";
NSString *const kAuthorHeadPic = @"headPic";
NSString *const kAuthorTagCodes = @"tagCodes";
NSString *const kAuthorStudentNo = @"studentNo";
NSString *const kAuthorPropetiesCommon = @"propetiesCommon";
NSString *const kAuthorClassCodes = @"classCodes";
NSString *const kAuthorName = @"name";
NSString *const kAuthorGroupCodes = @"groupCodes";


@interface Author ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Author

@synthesize provinceCode = _provinceCode;
@synthesize uid = _uid;
@synthesize schoolCode = _schoolCode;
@synthesize tagsCommon = _tagsCommon;
@synthesize headPic = _headPic;
@synthesize tagCodes = _tagCodes;
@synthesize studentNo = _studentNo;
@synthesize propetiesCommon = _propetiesCommon;
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
            self.provinceCode = [ProvinceCode modelObjectWithDictionary:[dict objectForKey:kAuthorProvinceCode]];
            self.uid = [self objectOrNilForKey:kAuthorUid fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kAuthorSchoolCode fromDictionary:dict];
    NSObject *receivedTagsCommon = [dict objectForKey:kAuthorTagsCommon];
    NSMutableArray *parsedTagsCommon = [NSMutableArray array];
    if ([receivedTagsCommon isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTagsCommon) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTagsCommon addObject:[Tags modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTagsCommon isKindOfClass:[NSDictionary class]]) {
       [parsedTagsCommon addObject:[Tags modelObjectWithDictionary:(NSDictionary *)receivedTagsCommon]];
    }

    self.tagsCommon = [NSArray arrayWithArray:parsedTagsCommon];
            self.headPic = [self objectOrNilForKey:kAuthorHeadPic fromDictionary:dict];
            self.tagCodes = [self objectOrNilForKey:kAuthorTagCodes fromDictionary:dict];
            self.studentNo = [self objectOrNilForKey:kAuthorStudentNo fromDictionary:dict];
    NSObject *receivedPropetiesCommon = [dict objectForKey:kAuthorPropetiesCommon];
    NSMutableArray *parsedPropetiesCommon = [NSMutableArray array];
    if ([receivedPropetiesCommon isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPropetiesCommon) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPropetiesCommon addObject:[Tags modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPropetiesCommon isKindOfClass:[NSDictionary class]]) {
       [parsedPropetiesCommon addObject:[Tags modelObjectWithDictionary:(NSDictionary *)receivedPropetiesCommon]];
    }

    self.propetiesCommon = [NSArray arrayWithArray:parsedPropetiesCommon];
    NSObject *receivedClassCodes = [dict objectForKey:kAuthorClassCodes];
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
            self.name = [self objectOrNilForKey:kAuthorName fromDictionary:dict];
            self.groupCodes = [self objectOrNilForKey:kAuthorGroupCodes fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.provinceCode dictionaryRepresentation] forKey:kAuthorProvinceCode];
    [mutableDict setValue:self.uid forKey:kAuthorUid];
    [mutableDict setValue:self.schoolCode forKey:kAuthorSchoolCode];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTagsCommon] forKey:kAuthorTagsCommon];
    [mutableDict setValue:self.headPic forKey:kAuthorHeadPic];
    [mutableDict setValue:self.tagCodes forKey:kAuthorTagCodes];
    [mutableDict setValue:self.studentNo forKey:kAuthorStudentNo];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPropetiesCommon] forKey:kAuthorPropetiesCommon];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForClassCodes] forKey:kAuthorClassCodes];
    [mutableDict setValue:self.name forKey:kAuthorName];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGroupCodes] forKey:kAuthorGroupCodes];

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

    self.provinceCode = [aDecoder decodeObjectForKey:kAuthorProvinceCode];
    self.uid = [aDecoder decodeObjectForKey:kAuthorUid];
    self.schoolCode = [aDecoder decodeObjectForKey:kAuthorSchoolCode];
    self.tagsCommon = [aDecoder decodeObjectForKey:kAuthorTagsCommon];
    self.headPic = [aDecoder decodeObjectForKey:kAuthorHeadPic];
    self.tagCodes = [aDecoder decodeObjectForKey:kAuthorTagCodes];
    self.studentNo = [aDecoder decodeObjectForKey:kAuthorStudentNo];
    self.propetiesCommon = [aDecoder decodeObjectForKey:kAuthorPropetiesCommon];
    self.classCodes = [aDecoder decodeObjectForKey:kAuthorClassCodes];
    self.name = [aDecoder decodeObjectForKey:kAuthorName];
    self.groupCodes = [aDecoder decodeObjectForKey:kAuthorGroupCodes];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_provinceCode forKey:kAuthorProvinceCode];
    [aCoder encodeObject:_uid forKey:kAuthorUid];
    [aCoder encodeObject:_schoolCode forKey:kAuthorSchoolCode];
    [aCoder encodeObject:_tagsCommon forKey:kAuthorTagsCommon];
    [aCoder encodeObject:_headPic forKey:kAuthorHeadPic];
    [aCoder encodeObject:_tagCodes forKey:kAuthorTagCodes];
    [aCoder encodeObject:_studentNo forKey:kAuthorStudentNo];
    [aCoder encodeObject:_propetiesCommon forKey:kAuthorPropetiesCommon];
    [aCoder encodeObject:_classCodes forKey:kAuthorClassCodes];
    [aCoder encodeObject:_name forKey:kAuthorName];
    [aCoder encodeObject:_groupCodes forKey:kAuthorGroupCodes];
}

- (id)copyWithZone:(NSZone *)zone
{
    Author *copy = [[Author alloc] init];
    
    if (copy) {

        copy.provinceCode = [self.provinceCode copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.tagsCommon = [self.tagsCommon copyWithZone:zone];
        copy.headPic = [self.headPic copyWithZone:zone];
        copy.tagCodes = [self.tagCodes copyWithZone:zone];
        copy.studentNo = [self.studentNo copyWithZone:zone];
        copy.propetiesCommon = [self.propetiesCommon copyWithZone:zone];
        copy.classCodes = [self.classCodes copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.groupCodes = [self.groupCodes copyWithZone:zone];
    }
    
    return copy;
}


@end
