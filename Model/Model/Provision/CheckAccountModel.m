//
//  CheckAccountModel.m
//
//  Created by HuiYin  on 15/8/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CheckAccountModel.h"


NSString *const kCheckAccountModelMobileBindMessage = @"mobile_bind_message";
NSString *const kCheckAccountModelMobileBindFlg = @"mobile_bind_flg";
NSString *const kCheckAccountModelAccountCheckMessage = @"account_check_message";
NSString *const kCheckAccountModelAccountCheckFlg = @"account_check_flg";


@interface CheckAccountModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CheckAccountModel

@synthesize mobileBindMessage = _mobileBindMessage;
@synthesize mobileBindFlg = _mobileBindFlg;
@synthesize accountCheckMessage = _accountCheckMessage;
@synthesize accountCheckFlg = _accountCheckFlg;


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
            self.mobileBindMessage = [self objectOrNilForKey:kCheckAccountModelMobileBindMessage fromDictionary:dict];
            self.mobileBindFlg = [[self objectOrNilForKey:kCheckAccountModelMobileBindFlg fromDictionary:dict] boolValue];
            self.accountCheckMessage = [self objectOrNilForKey:kCheckAccountModelAccountCheckMessage fromDictionary:dict];
            self.accountCheckFlg = [[self objectOrNilForKey:kCheckAccountModelAccountCheckFlg fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.mobileBindMessage forKey:kCheckAccountModelMobileBindMessage];
    [mutableDict setValue:[NSNumber numberWithBool:self.mobileBindFlg] forKey:kCheckAccountModelMobileBindFlg];
    [mutableDict setValue:self.accountCheckMessage forKey:kCheckAccountModelAccountCheckMessage];
    [mutableDict setValue:[NSNumber numberWithBool:self.accountCheckFlg] forKey:kCheckAccountModelAccountCheckFlg];

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

    self.mobileBindMessage = [aDecoder decodeObjectForKey:kCheckAccountModelMobileBindMessage];
    self.mobileBindFlg = [aDecoder decodeBoolForKey:kCheckAccountModelMobileBindFlg];
    self.accountCheckMessage = [aDecoder decodeObjectForKey:kCheckAccountModelAccountCheckMessage];
    self.accountCheckFlg = [aDecoder decodeBoolForKey:kCheckAccountModelAccountCheckFlg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mobileBindMessage forKey:kCheckAccountModelMobileBindMessage];
    [aCoder encodeBool:_mobileBindFlg forKey:kCheckAccountModelMobileBindFlg];
    [aCoder encodeObject:_accountCheckMessage forKey:kCheckAccountModelAccountCheckMessage];
    [aCoder encodeBool:_accountCheckFlg forKey:kCheckAccountModelAccountCheckFlg];
}

- (id)copyWithZone:(NSZone *)zone
{
    CheckAccountModel *copy = [[CheckAccountModel alloc] init];
    
    if (copy) {

        copy.mobileBindMessage = [self.mobileBindMessage copyWithZone:zone];
        copy.mobileBindFlg = self.mobileBindFlg;
        copy.accountCheckMessage = [self.accountCheckMessage copyWithZone:zone];
        copy.accountCheckFlg = self.accountCheckFlg;
    }
    
    return copy;
}


@end
