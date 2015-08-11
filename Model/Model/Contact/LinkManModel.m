//
//  LinkManModel.m
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LinkManModel.h"


NSString *const kLinkManModelId = @"id";
NSString *const kLinkManModelFaculty = @"faculty";
NSString *const kLinkManModelSchoolCode = @"schoolCode";
NSString *const kLinkManModelTime = @"time";
NSString *const kLinkManModelCollege = @"college";
NSString *const kLinkManModelTag = @"tag";
NSString *const kLinkManModelLinkStudentName = @"linkStudentName";
NSString *const kLinkManModelGrad = @"grad";
NSString *const kLinkManModelIcon = @"icon";
NSString *const kLinkManModelStudentClass = @"studentClass";
NSString *const kLinkManModelIsShield = @"isShield";
NSString *const kLinkManModelLinkStudentNo = @"linkStudentNo";
NSString *const kLinkManModelIsRemind = @"isRemind";
NSString *const kLinkManModelSchoolName = @"schoolName";
NSString *const kLinkManModelGender = @"gender";
NSString *const kLinkManModelMyStudentNo = @"myStudentNo";

NSString *const kLinkManModelProvince = @"province";
NSString *const kLinkManModelCountry = @"country";
NSString *const kLinkManModelProvinceCode = @"provinceCode";
NSString *const kLinkManModelCountryCode = @"countryCode";
NSString *const kLinkManModelStreet = @"street";
NSString *const kLinkManModelIdentityCard = @"identityCard";
NSString *const kLinkManModelCity = @"city";
NSString *const kLinkManModelVillage = @"village";
NSString *const kLinkManModelStreetCode = @"streetCode";
NSString *const kLinkManModelStudentNo = @"studentNo";
NSString *const kLinkManModelToken = @"token";
NSString *const kLinkManModelCityCode = @"cityCode";


@interface LinkManModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LinkManModel

@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize faculty = _faculty;
@synthesize schoolCode = _schoolCode;
@synthesize time = _time;
@synthesize college = _college;
@synthesize tag = _tag;
@synthesize linkStudentName = _linkStudentName;
@synthesize grad = _grad;
@synthesize icon = _icon;
@synthesize studentClass = _studentClass;
@synthesize isShield = _isShield;
@synthesize linkStudentNo = _linkStudentNo;
@synthesize isRemind = _isRemind;
@synthesize schoolName = _schoolName;
@synthesize gender = _gender;
@synthesize myStudentNo = _myStudentNo;

@synthesize studentName = _studentName;
@synthesize province = _province;
@synthesize country = _country;
@synthesize provinceCode = _provinceCode;
@synthesize countryCode = _countryCode;
@synthesize street = _street;
@synthesize identityCard = _identityCard;
@synthesize city = _city;
@synthesize village = _village;
@synthesize streetCode = _streetCode;
@synthesize studentNo = _studentNo;
@synthesize token = _token;


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
            self.internalBaseClassIdentifier = [self objectOrNilForKey:kLinkManModelId fromDictionary:dict];
            self.faculty = [self objectOrNilForKey:kLinkManModelFaculty fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kLinkManModelSchoolCode fromDictionary:dict];
            self.time = [self objectOrNilForKey:kLinkManModelTime fromDictionary:dict];
            self.college = [self objectOrNilForKey:kLinkManModelCollege fromDictionary:dict];
            self.tag = [self objectOrNilForKey:kLinkManModelTag fromDictionary:dict];
            self.linkStudentName = [self objectOrNilForKey:kLinkManModelLinkStudentName fromDictionary:dict];
            self.grad = [self objectOrNilForKey:kLinkManModelGrad fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kLinkManModelIcon fromDictionary:dict];
            self.studentClass = [self objectOrNilForKey:kLinkManModelStudentClass fromDictionary:dict];
            self.isShield = [self objectOrNilForKey:kLinkManModelIsShield fromDictionary:dict];
            self.linkStudentNo = [self objectOrNilForKey:kLinkManModelLinkStudentNo fromDictionary:dict];
            self.isRemind = [self objectOrNilForKey:kLinkManModelIsRemind fromDictionary:dict];
            self.schoolName = [self objectOrNilForKey:kLinkManModelSchoolName fromDictionary:dict];
            self.gender = [self objectOrNilForKey:kLinkManModelGender fromDictionary:dict];
            self.myStudentNo = [self objectOrNilForKey:kLinkManModelMyStudentNo fromDictionary:dict];
        
    
        self.province = [self objectOrNilForKey:kLinkManModelProvince fromDictionary:dict];
        self.country = [self objectOrNilForKey:kLinkManModelCountry fromDictionary:dict];
        self.provinceCode = [self objectOrNilForKey:kLinkManModelProvinceCode fromDictionary:dict];
        self.countryCode = [self objectOrNilForKey:kLinkManModelCountryCode fromDictionary:dict];
        self.street = [self objectOrNilForKey:kLinkManModelStreet fromDictionary:dict];
        self.identityCard = [self objectOrNilForKey:kLinkManModelIdentityCard fromDictionary:dict];
        self.city = [self objectOrNilForKey:kLinkManModelCity fromDictionary:dict];
        self.village = [self objectOrNilForKey:kLinkManModelVillage fromDictionary:dict];
        self.streetCode = [self objectOrNilForKey:kLinkManModelStreetCode fromDictionary:dict];
        self.studentNo = [self objectOrNilForKey:kLinkManModelStudentNo fromDictionary:dict];
        self.token = [self objectOrNilForKey:kLinkManModelToken fromDictionary:dict];
        self.cityCode = [self objectOrNilForKey:kLinkManModelCityCode fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:kLinkManModelId];
    [mutableDict setValue:self.faculty forKey:kLinkManModelFaculty];
    [mutableDict setValue:self.schoolCode forKey:kLinkManModelSchoolCode];
    [mutableDict setValue:self.time forKey:kLinkManModelTime];
    [mutableDict setValue:self.college forKey:kLinkManModelCollege];
    [mutableDict setValue:self.tag forKey:kLinkManModelTag];
    [mutableDict setValue:self.linkStudentName forKey:kLinkManModelLinkStudentName];
    [mutableDict setValue:self.grad forKey:kLinkManModelGrad];
    [mutableDict setValue:self.icon forKey:kLinkManModelIcon];
    [mutableDict setValue:self.studentClass forKey:kLinkManModelStudentClass];
    [mutableDict setValue:self.isShield forKey:kLinkManModelIsShield];
    [mutableDict setValue:self.linkStudentNo forKey:kLinkManModelLinkStudentNo];
    [mutableDict setValue:self.isRemind forKey:kLinkManModelIsRemind];
    [mutableDict setValue:self.schoolName forKey:kLinkManModelSchoolName];
    [mutableDict setValue:self.gender forKey:kLinkManModelGender];
    [mutableDict setValue:self.myStudentNo forKey:kLinkManModelMyStudentNo];

    
    [mutableDict setValue:self.province forKey:kLinkManModelProvince];
    [mutableDict setValue:self.country forKey:kLinkManModelCountry];
    [mutableDict setValue:self.provinceCode forKey:kLinkManModelProvinceCode];
    [mutableDict setValue:self.countryCode forKey:kLinkManModelCountryCode];
    [mutableDict setValue:self.street forKey:kLinkManModelStreet];
    [mutableDict setValue:self.identityCard forKey:kLinkManModelIdentityCard];
    [mutableDict setValue:self.city forKey:kLinkManModelCity];
    [mutableDict setValue:self.village forKey:kLinkManModelVillage];
    [mutableDict setValue:self.streetCode forKey:kLinkManModelStreetCode];
    [mutableDict setValue:self.studentNo forKey:kLinkManModelStudentNo];
    [mutableDict setValue:self.token forKey:kLinkManModelToken];
    [mutableDict setValue:self.cityCode forKey:kLinkManModelCityCode];
    
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

    self.internalBaseClassIdentifier = [aDecoder decodeObjectForKey:kLinkManModelId];
    self.faculty = [aDecoder decodeObjectForKey:kLinkManModelFaculty];
    self.schoolCode = [aDecoder decodeObjectForKey:kLinkManModelSchoolCode];
    self.time = [aDecoder decodeObjectForKey:kLinkManModelTime];
    self.college = [aDecoder decodeObjectForKey:kLinkManModelCollege];
    self.tag = [aDecoder decodeObjectForKey:kLinkManModelTag];
    self.linkStudentName = [aDecoder decodeObjectForKey:kLinkManModelLinkStudentName];
    self.grad = [aDecoder decodeObjectForKey:kLinkManModelGrad];
    self.icon = [aDecoder decodeObjectForKey:kLinkManModelIcon];
    self.studentClass = [aDecoder decodeObjectForKey:kLinkManModelStudentClass];
    self.isShield = [aDecoder decodeObjectForKey:kLinkManModelIsShield];
    self.linkStudentNo = [aDecoder decodeObjectForKey:kLinkManModelLinkStudentNo];
    self.isRemind = [aDecoder decodeObjectForKey:kLinkManModelIsRemind];
    self.schoolName = [aDecoder decodeObjectForKey:kLinkManModelSchoolName];
    self.gender = [aDecoder decodeObjectForKey:kLinkManModelGender];
    self.myStudentNo = [aDecoder decodeObjectForKey:kLinkManModelMyStudentNo];
    

    self.province = [aDecoder decodeObjectForKey:kLinkManModelProvince];
    self.country = [aDecoder decodeObjectForKey:kLinkManModelCountry];
    self.provinceCode = [aDecoder decodeObjectForKey:kLinkManModelProvinceCode];
    self.countryCode = [aDecoder decodeObjectForKey:kLinkManModelCountryCode];
    self.street = [aDecoder decodeObjectForKey:kLinkManModelStreet];
    self.identityCard = [aDecoder decodeObjectForKey:kLinkManModelIdentityCard];
    self.city = [aDecoder decodeObjectForKey:kLinkManModelCity];
    self.village = [aDecoder decodeObjectForKey:kLinkManModelVillage];
    self.streetCode = [aDecoder decodeObjectForKey:kLinkManModelStreetCode];
    self.studentNo = [aDecoder decodeObjectForKey:kLinkManModelStudentNo];
    self.token = [aDecoder decodeObjectForKey:kLinkManModelToken];
    self.cityCode = [aDecoder decodeObjectForKey:kLinkManModelCityCode];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_internalBaseClassIdentifier forKey:kLinkManModelId];
    [aCoder encodeObject:_faculty forKey:kLinkManModelFaculty];
    [aCoder encodeObject:_schoolCode forKey:kLinkManModelSchoolCode];
    [aCoder encodeObject:_time forKey:kLinkManModelTime];
    [aCoder encodeObject:_college forKey:kLinkManModelCollege];
    [aCoder encodeObject:_tag forKey:kLinkManModelTag];
    [aCoder encodeObject:_linkStudentName forKey:kLinkManModelLinkStudentName];
    [aCoder encodeObject:_grad forKey:kLinkManModelGrad];
    [aCoder encodeObject:_icon forKey:kLinkManModelIcon];
    [aCoder encodeObject:_studentClass forKey:kLinkManModelStudentClass];
    [aCoder encodeObject:_isShield forKey:kLinkManModelIsShield];
    [aCoder encodeObject:_linkStudentNo forKey:kLinkManModelLinkStudentNo];
    [aCoder encodeObject:_isRemind forKey:kLinkManModelIsRemind];
    [aCoder encodeObject:_schoolName forKey:kLinkManModelSchoolName];
    [aCoder encodeObject:_gender forKey:kLinkManModelGender];
    [aCoder encodeObject:_myStudentNo forKey:kLinkManModelMyStudentNo];
    
    
    
    [aCoder encodeObject:_province forKey:kLinkManModelProvince];
    [aCoder encodeObject:_country forKey:kLinkManModelCountry];
    [aCoder encodeObject:_provinceCode forKey:kLinkManModelProvinceCode];
    [aCoder encodeObject:_countryCode forKey:kLinkManModelCountryCode];
    [aCoder encodeObject:_street forKey:kLinkManModelStreet];
    [aCoder encodeObject:_identityCard forKey:kLinkManModelIdentityCard];
    [aCoder encodeObject:_city forKey:kLinkManModelCity];
    [aCoder encodeObject:_village forKey:kLinkManModelVillage];
    [aCoder encodeObject:_streetCode forKey:kLinkManModelStreetCode];
    [aCoder encodeObject:_studentNo forKey:kLinkManModelStudentNo];
    [aCoder encodeObject:_token forKey:kLinkManModelToken];
    [aCoder encodeObject:_cityCode forKey:kLinkManModelCityCode];
    
}

- (id)copyWithZone:(NSZone *)zone
{
    LinkManModel *copy = [[LinkManModel alloc] init];
    
    if (copy) {

        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.faculty = [self.faculty copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
        copy.college = [self.college copyWithZone:zone];
        copy.tag = [self.tag copyWithZone:zone];
        copy.linkStudentName = [self.linkStudentName copyWithZone:zone];
        copy.grad = [self.grad copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.studentClass = [self.studentClass copyWithZone:zone];
        copy.isShield = [self.isShield copyWithZone:zone];
        copy.linkStudentNo = [self.linkStudentNo copyWithZone:zone];
        copy.isRemind = [self.isRemind copyWithZone:zone];
        copy.schoolName = [self.schoolName copyWithZone:zone];
        copy.gender = [self.gender copyWithZone:zone];
        copy.myStudentNo = [self.myStudentNo copyWithZone:zone];
        
        
        
        copy.province = [self.province copyWithZone:zone];
        copy.country = [self.country copyWithZone:zone];
        copy.provinceCode = [self.provinceCode copyWithZone:zone];
        copy.countryCode = [self.countryCode copyWithZone:zone];
        copy.street = [self.street copyWithZone:zone];
        copy.identityCard = [self.identityCard copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.village = [self.village copyWithZone:zone];
        copy.streetCode = [self.streetCode copyWithZone:zone];
        copy.studentNo = [self.studentNo copyWithZone:zone];
        copy.cityCode = [self.cityCode copyWithZone:zone];
        copy.studentClass = [self.studentClass copyWithZone:zone];
        
    }
    
    return copy;
}


@end
