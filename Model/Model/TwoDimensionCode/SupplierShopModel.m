//
//  SupplierShopModel.m
//
//  Created by 先森 尹 on 15/11/3
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SupplierShopModel.h"


NSString *const kSupplierShopModelId = @"id";
NSString *const kSupplierShopModelDiscount = @"discount";
NSString *const kSupplierShopModelQrCodeUrl = @"qrCodeUrl";
NSString *const kSupplierShopModelCooperationStartTime = @"cooperationStartTime";
NSString *const kSupplierShopModelTags = @"tags";
NSString *const kSupplierShopModelAddress = @"address";
NSString *const kSupplierShopModelDisplayOrder = @"displayOrder";
NSString *const kSupplierShopModelCreateTime = @"createTime";
NSString *const kSupplierShopModelShopDetail = @"shopDetail";
NSString *const kSupplierShopModelCooperationMode = @"cooperationMode";
NSString *const kSupplierShopModelCooperationEndTime = @"cooperationEndTime";
NSString *const kSupplierShopModelTelephone = @"telephone";
NSString *const kSupplierShopModelShopLogoUrl = @"shopLogoUrl";
NSString *const kSupplierShopModelName = @"name";
NSString *const kSupplierShopModelUpdateTime = @"updateTime";


@interface SupplierShopModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SupplierShopModel

@synthesize supplierShopModelIdentifier = _supplierShopModelIdentifier;
@synthesize discount = _discount;
@synthesize qrCodeUrl = _qrCodeUrl;
@synthesize cooperationStartTime = _cooperationStartTime;
@synthesize tags = _tags;
@synthesize address = _address;
@synthesize displayOrder = _displayOrder;
@synthesize createTime = _createTime;
@synthesize shopDetail = _shopDetail;
@synthesize cooperationMode = _cooperationMode;
@synthesize cooperationEndTime = _cooperationEndTime;
@synthesize telephone = _telephone;
@synthesize shopLogoUrl = _shopLogoUrl;
@synthesize name = _name;
@synthesize updateTime = _updateTime;


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
            self.supplierShopModelIdentifier = [[self objectOrNilForKey:kSupplierShopModelId fromDictionary:dict] doubleValue];
            self.discount = [self objectOrNilForKey:kSupplierShopModelDiscount fromDictionary:dict];
            self.qrCodeUrl = [self objectOrNilForKey:kSupplierShopModelQrCodeUrl fromDictionary:dict];
            self.cooperationStartTime = [[self objectOrNilForKey:kSupplierShopModelCooperationStartTime fromDictionary:dict] doubleValue];
            self.tags = [self objectOrNilForKey:kSupplierShopModelTags fromDictionary:dict];
            self.address = [self objectOrNilForKey:kSupplierShopModelAddress fromDictionary:dict];
            self.displayOrder = [[self objectOrNilForKey:kSupplierShopModelDisplayOrder fromDictionary:dict] doubleValue];
            self.createTime = [[self objectOrNilForKey:kSupplierShopModelCreateTime fromDictionary:dict] doubleValue];
            self.shopDetail = [self objectOrNilForKey:kSupplierShopModelShopDetail fromDictionary:dict];
            self.cooperationMode = [self objectOrNilForKey:kSupplierShopModelCooperationMode fromDictionary:dict];
            self.cooperationEndTime = [[self objectOrNilForKey:kSupplierShopModelCooperationEndTime fromDictionary:dict] doubleValue];
            self.telephone = [self objectOrNilForKey:kSupplierShopModelTelephone fromDictionary:dict];
            self.shopLogoUrl = [self objectOrNilForKey:kSupplierShopModelShopLogoUrl fromDictionary:dict];
            self.name = [self objectOrNilForKey:kSupplierShopModelName fromDictionary:dict];
            self.updateTime = [[self objectOrNilForKey:kSupplierShopModelUpdateTime fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.supplierShopModelIdentifier] forKey:kSupplierShopModelId];
    [mutableDict setValue:self.discount forKey:kSupplierShopModelDiscount];
    [mutableDict setValue:self.qrCodeUrl forKey:kSupplierShopModelQrCodeUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cooperationStartTime] forKey:kSupplierShopModelCooperationStartTime];
    [mutableDict setValue:self.tags forKey:kSupplierShopModelTags];
    [mutableDict setValue:self.address forKey:kSupplierShopModelAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.displayOrder] forKey:kSupplierShopModelDisplayOrder];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kSupplierShopModelCreateTime];
    [mutableDict setValue:self.shopDetail forKey:kSupplierShopModelShopDetail];
    [mutableDict setValue:self.cooperationMode forKey:kSupplierShopModelCooperationMode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cooperationEndTime] forKey:kSupplierShopModelCooperationEndTime];
    [mutableDict setValue:self.telephone forKey:kSupplierShopModelTelephone];
    [mutableDict setValue:self.shopLogoUrl forKey:kSupplierShopModelShopLogoUrl];
    [mutableDict setValue:self.name forKey:kSupplierShopModelName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateTime] forKey:kSupplierShopModelUpdateTime];

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

    self.supplierShopModelIdentifier = [aDecoder decodeDoubleForKey:kSupplierShopModelId];
    self.discount = [aDecoder decodeObjectForKey:kSupplierShopModelDiscount];
    self.qrCodeUrl = [aDecoder decodeObjectForKey:kSupplierShopModelQrCodeUrl];
    self.cooperationStartTime = [aDecoder decodeDoubleForKey:kSupplierShopModelCooperationStartTime];
    self.tags = [aDecoder decodeObjectForKey:kSupplierShopModelTags];
    self.address = [aDecoder decodeObjectForKey:kSupplierShopModelAddress];
    self.displayOrder = [aDecoder decodeDoubleForKey:kSupplierShopModelDisplayOrder];
    self.createTime = [aDecoder decodeDoubleForKey:kSupplierShopModelCreateTime];
    self.shopDetail = [aDecoder decodeObjectForKey:kSupplierShopModelShopDetail];
    self.cooperationMode = [aDecoder decodeObjectForKey:kSupplierShopModelCooperationMode];
    self.cooperationEndTime = [aDecoder decodeDoubleForKey:kSupplierShopModelCooperationEndTime];
    self.telephone = [aDecoder decodeObjectForKey:kSupplierShopModelTelephone];
    self.shopLogoUrl = [aDecoder decodeObjectForKey:kSupplierShopModelShopLogoUrl];
    self.name = [aDecoder decodeObjectForKey:kSupplierShopModelName];
    self.updateTime = [aDecoder decodeDoubleForKey:kSupplierShopModelUpdateTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_supplierShopModelIdentifier forKey:kSupplierShopModelId];
    [aCoder encodeObject:_discount forKey:kSupplierShopModelDiscount];
    [aCoder encodeObject:_qrCodeUrl forKey:kSupplierShopModelQrCodeUrl];
    [aCoder encodeDouble:_cooperationStartTime forKey:kSupplierShopModelCooperationStartTime];
    [aCoder encodeObject:_tags forKey:kSupplierShopModelTags];
    [aCoder encodeObject:_address forKey:kSupplierShopModelAddress];
    [aCoder encodeDouble:_displayOrder forKey:kSupplierShopModelDisplayOrder];
    [aCoder encodeDouble:_createTime forKey:kSupplierShopModelCreateTime];
    [aCoder encodeObject:_shopDetail forKey:kSupplierShopModelShopDetail];
    [aCoder encodeObject:_cooperationMode forKey:kSupplierShopModelCooperationMode];
    [aCoder encodeDouble:_cooperationEndTime forKey:kSupplierShopModelCooperationEndTime];
    [aCoder encodeObject:_telephone forKey:kSupplierShopModelTelephone];
    [aCoder encodeObject:_shopLogoUrl forKey:kSupplierShopModelShopLogoUrl];
    [aCoder encodeObject:_name forKey:kSupplierShopModelName];
    [aCoder encodeDouble:_updateTime forKey:kSupplierShopModelUpdateTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    SupplierShopModel *copy = [[SupplierShopModel alloc] init];
    
    if (copy) {

        copy.supplierShopModelIdentifier = self.supplierShopModelIdentifier;
        copy.discount = [self.discount copyWithZone:zone];
        copy.qrCodeUrl = [self.qrCodeUrl copyWithZone:zone];
        copy.cooperationStartTime = self.cooperationStartTime;
        copy.tags = [self.tags copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.displayOrder = self.displayOrder;
        copy.createTime = self.createTime;
        copy.shopDetail = [self.shopDetail copyWithZone:zone];
        copy.cooperationMode = [self.cooperationMode copyWithZone:zone];
        copy.cooperationEndTime = self.cooperationEndTime;
        copy.telephone = [self.telephone copyWithZone:zone];
        copy.shopLogoUrl = [self.shopLogoUrl copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.updateTime = self.updateTime;
    }
    
    return copy;
}


@end
