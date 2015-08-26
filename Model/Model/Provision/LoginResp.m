//
//  LoginResp.m
//
//  Created by   on 15/7/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginResp.h"

NSString *const kLoginRespStudentName = @"studentName";
NSString *const kLoginRespProvince = @"province";
NSString *const kLoginRespCollege = @"college";
NSString *const kLoginRespGrad = @"grad";
NSString *const kLoginRespCountry = @"country";
NSString *const kLoginRespAdmissionNo = @"admissionNo";
NSString *const kLoginRespProvinceCode = @"provinceCode";
NSString *const kLoginRespCountryCode = @"countryCode";
NSString *const kLoginRespStreet = @"street";
NSString *const kLoginRespSchoolCode = @"schoolCode";
NSString *const kLoginRespIdentityCard = @"identityCard";
NSString *const kLoginRespSchoolName = @"schoolName";
NSString *const kLoginRespCity = @"city";
NSString *const kLoginRespIcon = @"icon";
NSString *const kLoginRespVillage = @"village";
NSString *const kLoginRespStudentNo = @"studentNo";
NSString *const kLoginRespStreetCode = @"streetCode";
NSString *const kLoginRespScore = @"score";
NSString *const kLoginRespId = @"id";
NSString *const kLoginRespGender = @"gender";
NSString *const kLoginRespToken = @"token";
NSString *const kLoginRespCityCode = @"cityCode";
NSString *const kLoginRespStudentClass = @"studentClass";
NSString *const kLoginRespFaculty = @"faculty";
NSString *const kLoginRespMobilePhone = @"mobilePhone";
NSString *const kLoginRespFirstLogin = @"firstLogin";
NSString *const kLoginRespSchoolLogoPath = @"schoolLogoPath";


@interface LoginResp ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginResp

@synthesize studentName = _studentName;
@synthesize province = _province;
@synthesize college = _college;
@synthesize grad = _grad;
@synthesize country = _country;
@synthesize admissionNo = _admissionNo;
@synthesize provinceCode = _provinceCode;
@synthesize countryCode = _countryCode;
@synthesize street = _street;
@synthesize schoolCode = _schoolCode;
@synthesize identityCard = _identityCard;
@synthesize schoolName = _schoolName;
@synthesize city = _city;
@synthesize icon = _icon;
@synthesize village = _village;
@synthesize studentNo = _studentNo;
@synthesize streetCode = _streetCode;
@synthesize score = _score;
@synthesize provisionInfoIdentifier = _provisionInfoIdentifier;
@synthesize gender = _gender;
@synthesize token = _token;
@synthesize cityCode = _cityCode;
@synthesize studentClass = _studentClass;
@synthesize faculty = _faculty;
@synthesize mobilePhone = _mobilePhone;
@synthesize schoolLogoPath = _schoolLogoPath;

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
        self.studentName = [self objectOrNilForKey:kLoginRespStudentName fromDictionary:dict];
        self.province = [self objectOrNilForKey:kLoginRespProvince fromDictionary:dict];
        self.college = [self objectOrNilForKey:kLoginRespCollege fromDictionary:dict];
        self.grad = [self objectOrNilForKey:kLoginRespGrad fromDictionary:dict];
        self.country = [self objectOrNilForKey:kLoginRespCountry fromDictionary:dict];
        self.admissionNo = [self objectOrNilForKey:kLoginRespAdmissionNo fromDictionary:dict];
        self.provinceCode = [self objectOrNilForKey:kLoginRespProvinceCode fromDictionary:dict];
        self.countryCode = [self objectOrNilForKey:kLoginRespCountryCode fromDictionary:dict];
        self.street = [self objectOrNilForKey:kLoginRespStreet fromDictionary:dict];
        self.schoolCode = [self objectOrNilForKey:kLoginRespSchoolCode fromDictionary:dict];
        self.identityCard = [self objectOrNilForKey:kLoginRespIdentityCard fromDictionary:dict];
        self.schoolName = [self objectOrNilForKey:kLoginRespSchoolName fromDictionary:dict];
        self.city = [self objectOrNilForKey:kLoginRespCity fromDictionary:dict];
        self.icon = [self objectOrNilForKey:kLoginRespIcon fromDictionary:dict];
        self.village = [self objectOrNilForKey:kLoginRespVillage fromDictionary:dict];
        self.studentNo = [self objectOrNilForKey:kLoginRespStudentNo fromDictionary:dict];
        self.streetCode = [self objectOrNilForKey:kLoginRespStreetCode fromDictionary:dict];
        self.score = [self objectOrNilForKey:kLoginRespScore fromDictionary:dict];
        self.provisionInfoIdentifier = [[self objectOrNilForKey:kLoginRespId fromDictionary:dict] doubleValue];
        self.gender = [self objectOrNilForKey:kLoginRespGender fromDictionary:dict];
        self.token = [self objectOrNilForKey:kLoginRespToken fromDictionary:dict];
        self.cityCode = [self objectOrNilForKey:kLoginRespCityCode fromDictionary:dict];
        self.studentClass = [self objectOrNilForKey:kLoginRespStudentClass fromDictionary:dict];
        self.faculty = [self objectOrNilForKey:kLoginRespFaculty fromDictionary:dict];
        self.mobilePhone = [self objectOrNilForKey:kLoginRespMobilePhone fromDictionary:dict];
        self.firstLogin = [[self objectOrNilForKey:kLoginRespFirstLogin fromDictionary:dict] doubleValue];
        self.schoolLogoPath = [self objectOrNilForKey:kLoginRespSchoolLogoPath fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.studentName forKey:kLoginRespStudentName];
    [mutableDict setValue:self.province forKey:kLoginRespProvince];
    [mutableDict setValue:self.college forKey:kLoginRespCollege];
    [mutableDict setValue:self.grad forKey:kLoginRespGrad];
    [mutableDict setValue:self.country forKey:kLoginRespCountry];
    [mutableDict setValue:self.admissionNo forKey:kLoginRespAdmissionNo];
    [mutableDict setValue:self.provinceCode forKey:kLoginRespProvinceCode];
    [mutableDict setValue:self.countryCode forKey:kLoginRespCountryCode];
    [mutableDict setValue:self.street forKey:kLoginRespStreet];
    [mutableDict setValue:self.schoolCode forKey:kLoginRespSchoolCode];
    [mutableDict setValue:self.identityCard forKey:kLoginRespIdentityCard];
    [mutableDict setValue:self.schoolName forKey:kLoginRespSchoolName];
    [mutableDict setValue:self.city forKey:kLoginRespCity];
    [mutableDict setValue:self.icon forKey:kLoginRespIcon];
    [mutableDict setValue:self.village forKey:kLoginRespVillage];
    [mutableDict setValue:self.studentNo forKey:kLoginRespStudentNo];
    [mutableDict setValue:self.streetCode forKey:kLoginRespStreetCode];
    [mutableDict setValue:self.score forKey:kLoginRespScore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provisionInfoIdentifier] forKey:kLoginRespId];
    [mutableDict setValue:self.gender forKey:kLoginRespGender];
    [mutableDict setValue:self.token forKey:kLoginRespToken];
    [mutableDict setValue:self.cityCode forKey:kLoginRespCityCode];
    [mutableDict setValue:self.studentClass forKey:kLoginRespStudentClass];
    [mutableDict setValue:self.faculty forKey:kLoginRespFaculty];
    [mutableDict setValue:self.mobilePhone forKey:kLoginRespMobilePhone];
    [mutableDict setValue:self.schoolLogoPath forKey:kLoginRespSchoolLogoPath];
    
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
    
    self.studentName = [aDecoder decodeObjectForKey:kLoginRespStudentName];
    self.province = [aDecoder decodeObjectForKey:kLoginRespProvince];
    self.college = [aDecoder decodeObjectForKey:kLoginRespCollege];
    self.grad = [aDecoder decodeObjectForKey:kLoginRespGrad];
    self.country = [aDecoder decodeObjectForKey:kLoginRespCountry];
    self.admissionNo = [aDecoder decodeObjectForKey:kLoginRespAdmissionNo];
    self.provinceCode = [aDecoder decodeObjectForKey:kLoginRespProvinceCode];
    self.countryCode = [aDecoder decodeObjectForKey:kLoginRespCountryCode];
    self.street = [aDecoder decodeObjectForKey:kLoginRespStreet];
    self.schoolCode = [aDecoder decodeObjectForKey:kLoginRespSchoolCode];
    self.identityCard = [aDecoder decodeObjectForKey:kLoginRespIdentityCard];
    self.schoolName = [aDecoder decodeObjectForKey:kLoginRespSchoolName];
    self.city = [aDecoder decodeObjectForKey:kLoginRespCity];
    self.icon = [aDecoder decodeObjectForKey:kLoginRespIcon];
    self.village = [aDecoder decodeObjectForKey:kLoginRespVillage];
    self.studentNo = [aDecoder decodeObjectForKey:kLoginRespStudentNo];
    self.streetCode = [aDecoder decodeObjectForKey:kLoginRespStreetCode];
    self.score = [aDecoder decodeObjectForKey:kLoginRespScore];
    self.provisionInfoIdentifier = [aDecoder decodeDoubleForKey:kLoginRespId];
    self.gender = [aDecoder decodeObjectForKey:kLoginRespGender];
    self.token = [aDecoder decodeObjectForKey:kLoginRespToken];
    self.cityCode = [aDecoder decodeObjectForKey:kLoginRespCityCode];
    self.studentClass = [aDecoder decodeObjectForKey:kLoginRespStudentClass];
    self.faculty = [aDecoder decodeObjectForKey:kLoginRespFaculty];
    self.mobilePhone = [aDecoder decodeObjectForKey:kLoginRespMobilePhone];
    self.schoolLogoPath = [aDecoder decodeObjectForKey:kLoginRespSchoolLogoPath];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_studentName forKey:kLoginRespStudentName];
    [aCoder encodeObject:_province forKey:kLoginRespProvince];
    [aCoder encodeObject:_college forKey:kLoginRespCollege];
    [aCoder encodeObject:_grad forKey:kLoginRespGrad];
    [aCoder encodeObject:_country forKey:kLoginRespCountry];
    [aCoder encodeObject:_admissionNo forKey:kLoginRespAdmissionNo];
    [aCoder encodeObject:_provinceCode forKey:kLoginRespProvinceCode];
    [aCoder encodeObject:_countryCode forKey:kLoginRespCountryCode];
    [aCoder encodeObject:_street forKey:kLoginRespStreet];
    [aCoder encodeObject:_schoolCode forKey:kLoginRespSchoolCode];
    [aCoder encodeObject:_identityCard forKey:kLoginRespIdentityCard];
    [aCoder encodeObject:_schoolName forKey:kLoginRespSchoolName];
    [aCoder encodeObject:_city forKey:kLoginRespCity];
    [aCoder encodeObject:_icon forKey:kLoginRespIcon];
    [aCoder encodeObject:_village forKey:kLoginRespVillage];
    [aCoder encodeObject:_studentNo forKey:kLoginRespStudentNo];
    [aCoder encodeObject:_streetCode forKey:kLoginRespStreetCode];
    [aCoder encodeObject:_score forKey:kLoginRespScore];
    [aCoder encodeDouble:_provisionInfoIdentifier forKey:kLoginRespId];
    [aCoder encodeObject:_gender forKey:kLoginRespGender];
    [aCoder encodeObject:_token forKey:kLoginRespToken];
    [aCoder encodeObject:_cityCode forKey:kLoginRespCityCode];
    [aCoder encodeObject:_studentClass forKey:kLoginRespStudentClass];
    [aCoder encodeObject:_faculty forKey:kLoginRespFaculty];
    [aCoder encodeObject:_mobilePhone forKey:kLoginRespMobilePhone];
    [aCoder encodeObject:_schoolLogoPath forKey:kLoginRespSchoolLogoPath];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginResp *copy = [[LoginResp alloc] init];
    
    if (copy) {
        
        copy.studentName = [self.studentName copyWithZone:zone];
        copy.province = [self.province copyWithZone:zone];
        copy.college = [self.college copyWithZone:zone];
        copy.grad = [self.grad copyWithZone:zone];
        copy.country = [self.country copyWithZone:zone];
        copy.admissionNo = [self.admissionNo copyWithZone:zone];
        copy.provinceCode = [self.provinceCode copyWithZone:zone];
        copy.countryCode = [self.countryCode copyWithZone:zone];
        copy.street = [self.street copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.identityCard = [self.identityCard copyWithZone:zone];
        copy.schoolName = [self.schoolName copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.village = [self.village copyWithZone:zone];
        copy.studentNo = [self.studentNo copyWithZone:zone];
        copy.streetCode = [self.streetCode copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.provisionInfoIdentifier = self.provisionInfoIdentifier;
        copy.gender = [self.gender copyWithZone:zone];
        copy.token = [self.token copyWithZone:zone];
        copy.cityCode = [self.cityCode copyWithZone:zone];
        copy.studentClass = [self.studentClass copyWithZone:zone];
        copy.faculty = [self.faculty copyWithZone:zone];
        copy.mobilePhone = [self.mobilePhone copyWithZone:zone];
        copy.schoolLogoPath = [self.schoolLogoPath copyWithZone:zone];
    }
    
    return copy;
}


@end
