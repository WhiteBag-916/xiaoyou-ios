//
//  CheckLastVersionModel.m
//
//  Created by   on 15/11/18
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CheckLastVersionModel.h"


NSString *const kCheckLastVersionModelReleaseTime = @"releaseTime";
NSString *const kCheckLastVersionModelId = @"id";
NSString *const kCheckLastVersionModelAppName = @"appName";
NSString *const kCheckLastVersionModelCompulsoryRenewal = @"compulsoryRenewal";
NSString *const kCheckLastVersionModelVersion = @"version";
NSString *const kCheckLastVersionModelAppPath = @"appPath";
NSString *const kCheckLastVersionModelAbout = @"about";
NSString *const kCheckLastVersionModelAppPlatform = @"appPlatform";


@interface CheckLastVersionModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CheckLastVersionModel

@synthesize releaseTime = _releaseTime;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize appName = _appName;
@synthesize compulsoryRenewal = _compulsoryRenewal;
@synthesize version = _version;
@synthesize appPath = _appPath;
@synthesize about = _about;
@synthesize appPlatform = _appPlatform;


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
            self.releaseTime = [[self objectOrNilForKey:kCheckLastVersionModelReleaseTime fromDictionary:dict] doubleValue];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kCheckLastVersionModelId fromDictionary:dict] doubleValue];
            self.appName = [self objectOrNilForKey:kCheckLastVersionModelAppName fromDictionary:dict];
            self.compulsoryRenewal = [[self objectOrNilForKey:kCheckLastVersionModelCompulsoryRenewal fromDictionary:dict] boolValue];
            self.version = [self objectOrNilForKey:kCheckLastVersionModelVersion fromDictionary:dict];
            self.appPath = [self objectOrNilForKey:kCheckLastVersionModelAppPath fromDictionary:dict];
            self.about = [self objectOrNilForKey:kCheckLastVersionModelAbout fromDictionary:dict];
            self.appPlatform = [self objectOrNilForKey:kCheckLastVersionModelAppPlatform fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.releaseTime] forKey:kCheckLastVersionModelReleaseTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kCheckLastVersionModelId];
    [mutableDict setValue:self.appName forKey:kCheckLastVersionModelAppName];
    [mutableDict setValue:[NSNumber numberWithBool:self.compulsoryRenewal] forKey:kCheckLastVersionModelCompulsoryRenewal];
    [mutableDict setValue:self.version forKey:kCheckLastVersionModelVersion];
    [mutableDict setValue:self.appPath forKey:kCheckLastVersionModelAppPath];
    [mutableDict setValue:self.about forKey:kCheckLastVersionModelAbout];
    [mutableDict setValue:self.appPlatform forKey:kCheckLastVersionModelAppPlatform];

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

    self.releaseTime = [aDecoder decodeDoubleForKey:kCheckLastVersionModelReleaseTime];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kCheckLastVersionModelId];
    self.appName = [aDecoder decodeObjectForKey:kCheckLastVersionModelAppName];
    self.compulsoryRenewal = [aDecoder decodeBoolForKey:kCheckLastVersionModelCompulsoryRenewal];
    self.version = [aDecoder decodeObjectForKey:kCheckLastVersionModelVersion];
    self.appPath = [aDecoder decodeObjectForKey:kCheckLastVersionModelAppPath];
    self.about = [aDecoder decodeObjectForKey:kCheckLastVersionModelAbout];
    self.appPlatform = [aDecoder decodeObjectForKey:kCheckLastVersionModelAppPlatform];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_releaseTime forKey:kCheckLastVersionModelReleaseTime];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kCheckLastVersionModelId];
    [aCoder encodeObject:_appName forKey:kCheckLastVersionModelAppName];
    [aCoder encodeBool:_compulsoryRenewal forKey:kCheckLastVersionModelCompulsoryRenewal];
    [aCoder encodeObject:_version forKey:kCheckLastVersionModelVersion];
    [aCoder encodeObject:_appPath forKey:kCheckLastVersionModelAppPath];
    [aCoder encodeObject:_about forKey:kCheckLastVersionModelAbout];
    [aCoder encodeObject:_appPlatform forKey:kCheckLastVersionModelAppPlatform];
}

- (id)copyWithZone:(NSZone *)zone
{
    CheckLastVersionModel *copy = [[CheckLastVersionModel alloc] init];
    
    if (copy) {

        copy.releaseTime = self.releaseTime;
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.appName = [self.appName copyWithZone:zone];
        copy.compulsoryRenewal = self.compulsoryRenewal;
        copy.version = [self.version copyWithZone:zone];
        copy.appPath = [self.appPath copyWithZone:zone];
        copy.about = [self.about copyWithZone:zone];
        copy.appPlatform = [self.appPlatform copyWithZone:zone];
    }
    
    return copy;
}


@end
