//
//  SchoolDetailModel.m
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SchoolDetailModel.h"


NSString *const kSchoolDetailModelIntroduce = @"introduce";
NSString *const kSchoolDetailModelHistory = @"history";
NSString *const kSchoolDetailModelSchoolCode = @"schoolCode";
NSString *const kSchoolDetailModelId = @"id";
NSString *const kSchoolDetailModelInformation = @"information";
NSString *const kSchoolDetailModelIntroduceImagePath = @"introduceImagePath";
NSString *const kSchoolDetailModelSchoolName = @"schoolName";
NSString *const kSchoolDetailModelHistoryImagePath = @"historyImagePath";
NSString *const kSchoolDetailModelDepartmentImagePath = @"departmentImagePath";
NSString *const kSchoolDetailModelSchoolLogoPath = @"schoolLogoPath";


@interface SchoolDetailModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SchoolDetailModel

@synthesize introduce = _introduce;
@synthesize history = _history;
@synthesize schoolCode = _schoolCode;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize information = _information;
@synthesize introduceImagePath = _introduceImagePath;
@synthesize schoolName = _schoolName;
@synthesize historyImagePath = _historyImagePath;
@synthesize departmentImagePath = _departmentImagePath;
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
            self.introduce = [self objectOrNilForKey:kSchoolDetailModelIntroduce fromDictionary:dict];
            self.history = [self objectOrNilForKey:kSchoolDetailModelHistory fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kSchoolDetailModelSchoolCode fromDictionary:dict];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kSchoolDetailModelId fromDictionary:dict] doubleValue];
            self.information = [self objectOrNilForKey:kSchoolDetailModelInformation fromDictionary:dict];
            self.introduceImagePath = [self objectOrNilForKey:kSchoolDetailModelIntroduceImagePath fromDictionary:dict];
            self.schoolName = [self objectOrNilForKey:kSchoolDetailModelSchoolName fromDictionary:dict];
            self.historyImagePath = [self objectOrNilForKey:kSchoolDetailModelHistoryImagePath fromDictionary:dict];
            self.departmentImagePath = [self objectOrNilForKey:kSchoolDetailModelDepartmentImagePath fromDictionary:dict];
            self.schoolLogoPath = [self objectOrNilForKey:kSchoolDetailModelSchoolLogoPath fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.introduce forKey:kSchoolDetailModelIntroduce];
    [mutableDict setValue:self.history forKey:kSchoolDetailModelHistory];
    [mutableDict setValue:self.schoolCode forKey:kSchoolDetailModelSchoolCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kSchoolDetailModelId];
    [mutableDict setValue:self.information forKey:kSchoolDetailModelInformation];
    [mutableDict setValue:self.introduceImagePath forKey:kSchoolDetailModelIntroduceImagePath];
    [mutableDict setValue:self.schoolName forKey:kSchoolDetailModelSchoolName];
    [mutableDict setValue:self.historyImagePath forKey:kSchoolDetailModelHistoryImagePath];
    [mutableDict setValue:self.departmentImagePath forKey:kSchoolDetailModelDepartmentImagePath];
    [mutableDict setValue:self.schoolLogoPath forKey:kSchoolDetailModelSchoolLogoPath];

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

    self.introduce = [aDecoder decodeObjectForKey:kSchoolDetailModelIntroduce];
    self.history = [aDecoder decodeObjectForKey:kSchoolDetailModelHistory];
    self.schoolCode = [aDecoder decodeObjectForKey:kSchoolDetailModelSchoolCode];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kSchoolDetailModelId];
    self.information = [aDecoder decodeObjectForKey:kSchoolDetailModelInformation];
    self.introduceImagePath = [aDecoder decodeObjectForKey:kSchoolDetailModelIntroduceImagePath];
    self.schoolName = [aDecoder decodeObjectForKey:kSchoolDetailModelSchoolName];
    self.historyImagePath = [aDecoder decodeObjectForKey:kSchoolDetailModelHistoryImagePath];
    self.departmentImagePath = [aDecoder decodeObjectForKey:kSchoolDetailModelDepartmentImagePath];
    self.schoolLogoPath = [aDecoder decodeObjectForKey:kSchoolDetailModelSchoolLogoPath];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_introduce forKey:kSchoolDetailModelIntroduce];
    [aCoder encodeObject:_history forKey:kSchoolDetailModelHistory];
    [aCoder encodeObject:_schoolCode forKey:kSchoolDetailModelSchoolCode];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kSchoolDetailModelId];
    [aCoder encodeObject:_information forKey:kSchoolDetailModelInformation];
    [aCoder encodeObject:_introduceImagePath forKey:kSchoolDetailModelIntroduceImagePath];
    [aCoder encodeObject:_schoolName forKey:kSchoolDetailModelSchoolName];
    [aCoder encodeObject:_historyImagePath forKey:kSchoolDetailModelHistoryImagePath];
    [aCoder encodeObject:_departmentImagePath forKey:kSchoolDetailModelDepartmentImagePath];
    [aCoder encodeObject:_schoolLogoPath forKey:kSchoolDetailModelSchoolLogoPath];
}

- (id)copyWithZone:(NSZone *)zone
{
    SchoolDetailModel *copy = [[SchoolDetailModel alloc] init];
    
    if (copy) {

        copy.introduce = [self.introduce copyWithZone:zone];
        copy.history = [self.history copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.information = [self.information copyWithZone:zone];
        copy.introduceImagePath = [self.introduceImagePath copyWithZone:zone];
        copy.schoolName = [self.schoolName copyWithZone:zone];
        copy.historyImagePath = [self.historyImagePath copyWithZone:zone];
        copy.departmentImagePath = [self.departmentImagePath copyWithZone:zone];
        copy.schoolLogoPath = [self.schoolLogoPath copyWithZone:zone];
    }
    
    return copy;
}


@end
