//
//  SchoolListModel.m
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SchoolListModel.h"


NSString *const kSchoolListModelIntroduce = @"introduce";
NSString *const kSchoolListModelHistory = @"history";
NSString *const kSchoolListModelSchoolCode = @"schoolCode";
NSString *const kSchoolListModelId = @"id";
NSString *const kSchoolListModelIntroduceImagePath = @"introduceImagePath";
NSString *const kSchoolListModelDepartmentImagePath = @"departmentImagePath";
NSString *const kSchoolListModelSchoolName = @"schoolName";
NSString *const kSchoolListModelHistoryImagePath = @"historyImagePath";
NSString *const kSchoolListModelSchoolLogoPath = @"schoolLogoPath";
NSString *const kSchoolListModelSchoolLocation = @"schoolLocation";


@interface SchoolListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SchoolListModel

@synthesize introduce = _introduce;
@synthesize history = _history;
@synthesize schoolCode = _schoolCode;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize introduceImagePath = _introduceImagePath;
@synthesize departmentImagePath = _departmentImagePath;
@synthesize schoolName = _schoolName;
@synthesize historyImagePath = _historyImagePath;
@synthesize schoolLogoPath = _schoolLogoPath;
@synthesize schoolLocation = _schoolLocation;


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
            self.introduce = [self objectOrNilForKey:kSchoolListModelIntroduce fromDictionary:dict];
            self.history = [self objectOrNilForKey:kSchoolListModelHistory fromDictionary:dict];
            self.schoolCode = [self objectOrNilForKey:kSchoolListModelSchoolCode fromDictionary:dict];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kSchoolListModelId fromDictionary:dict] doubleValue];
            self.introduceImagePath = [self objectOrNilForKey:kSchoolListModelIntroduceImagePath fromDictionary:dict];
            self.departmentImagePath = [self objectOrNilForKey:kSchoolListModelDepartmentImagePath fromDictionary:dict];
            self.schoolName = [self objectOrNilForKey:kSchoolListModelSchoolName fromDictionary:dict];
            self.historyImagePath = [self objectOrNilForKey:kSchoolListModelHistoryImagePath fromDictionary:dict];
            self.schoolLogoPath = [self objectOrNilForKey:kSchoolListModelSchoolLogoPath fromDictionary:dict];
            self.schoolLocation = [self objectOrNilForKey:kSchoolListModelSchoolLocation fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.introduce forKey:kSchoolListModelIntroduce];
    [mutableDict setValue:self.history forKey:kSchoolListModelHistory];
    [mutableDict setValue:self.schoolCode forKey:kSchoolListModelSchoolCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kSchoolListModelId];
    [mutableDict setValue:self.introduceImagePath forKey:kSchoolListModelIntroduceImagePath];
    [mutableDict setValue:self.departmentImagePath forKey:kSchoolListModelDepartmentImagePath];
    [mutableDict setValue:self.schoolName forKey:kSchoolListModelSchoolName];
    [mutableDict setValue:self.historyImagePath forKey:kSchoolListModelHistoryImagePath];
    [mutableDict setValue:self.schoolLogoPath forKey:kSchoolListModelSchoolLogoPath];
    [mutableDict setValue:self.schoolLocation forKey:kSchoolListModelSchoolLocation];

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

    self.introduce = [aDecoder decodeObjectForKey:kSchoolListModelIntroduce];
    self.history = [aDecoder decodeObjectForKey:kSchoolListModelHistory];
    self.schoolCode = [aDecoder decodeObjectForKey:kSchoolListModelSchoolCode];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kSchoolListModelId];
    self.introduceImagePath = [aDecoder decodeObjectForKey:kSchoolListModelIntroduceImagePath];
    self.departmentImagePath = [aDecoder decodeObjectForKey:kSchoolListModelDepartmentImagePath];
    self.schoolName = [aDecoder decodeObjectForKey:kSchoolListModelSchoolName];
    self.historyImagePath = [aDecoder decodeObjectForKey:kSchoolListModelHistoryImagePath];
    self.schoolLogoPath = [aDecoder decodeObjectForKey:kSchoolListModelSchoolLogoPath];
    self.schoolLocation = [aDecoder decodeObjectForKey:kSchoolListModelSchoolLocation];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_introduce forKey:kSchoolListModelIntroduce];
    [aCoder encodeObject:_history forKey:kSchoolListModelHistory];
    [aCoder encodeObject:_schoolCode forKey:kSchoolListModelSchoolCode];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kSchoolListModelId];
    [aCoder encodeObject:_introduceImagePath forKey:kSchoolListModelIntroduceImagePath];
    [aCoder encodeObject:_departmentImagePath forKey:kSchoolListModelDepartmentImagePath];
    [aCoder encodeObject:_schoolName forKey:kSchoolListModelSchoolName];
    [aCoder encodeObject:_historyImagePath forKey:kSchoolListModelHistoryImagePath];
    [aCoder encodeObject:_schoolLogoPath forKey:kSchoolListModelSchoolLogoPath];
    [aCoder encodeObject:_schoolLocation forKey:kSchoolListModelSchoolLocation];
}

- (id)copyWithZone:(NSZone *)zone
{
    SchoolListModel *copy = [[SchoolListModel alloc] init];
    
    if (copy) {

        copy.introduce = [self.introduce copyWithZone:zone];
        copy.history = [self.history copyWithZone:zone];
        copy.schoolCode = [self.schoolCode copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.introduceImagePath = [self.introduceImagePath copyWithZone:zone];
        copy.departmentImagePath = [self.departmentImagePath copyWithZone:zone];
        copy.schoolName = [self.schoolName copyWithZone:zone];
        copy.historyImagePath = [self.historyImagePath copyWithZone:zone];
        copy.schoolLogoPath = [self.schoolLogoPath copyWithZone:zone];
        copy.schoolLocation = [self.schoolLocation copyWithZone:zone];
    }
    
    return copy;
}


@end
