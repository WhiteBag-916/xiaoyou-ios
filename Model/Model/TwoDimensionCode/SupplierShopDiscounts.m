//
//  SupplierShopDiscounts.m
//
//  Created by 先森 尹 on 15/11/3
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SupplierShopDiscounts.h"


NSString *const kSupplierShopDiscountsDisplayOrder = @"displayOrder";
NSString *const kSupplierShopDiscountsId = @"id";
NSString *const kSupplierShopDiscountsShopId = @"shopId";
NSString *const kSupplierShopDiscountsDiscountDetail = @"discountDetail";


@interface SupplierShopDiscounts ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SupplierShopDiscounts

@synthesize displayOrder = _displayOrder;
@synthesize supplierShopDiscountsIdentifier = _supplierShopDiscountsIdentifier;
@synthesize shopId = _shopId;
@synthesize discountDetail = _discountDetail;


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
            self.displayOrder = [[self objectOrNilForKey:kSupplierShopDiscountsDisplayOrder fromDictionary:dict] doubleValue];
            self.supplierShopDiscountsIdentifier = [[self objectOrNilForKey:kSupplierShopDiscountsId fromDictionary:dict] doubleValue];
            self.shopId = [[self objectOrNilForKey:kSupplierShopDiscountsShopId fromDictionary:dict] doubleValue];
            self.discountDetail = [self objectOrNilForKey:kSupplierShopDiscountsDiscountDetail fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.displayOrder] forKey:kSupplierShopDiscountsDisplayOrder];
    [mutableDict setValue:[NSNumber numberWithDouble:self.supplierShopDiscountsIdentifier] forKey:kSupplierShopDiscountsId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shopId] forKey:kSupplierShopDiscountsShopId];
    [mutableDict setValue:self.discountDetail forKey:kSupplierShopDiscountsDiscountDetail];

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

    self.displayOrder = [aDecoder decodeDoubleForKey:kSupplierShopDiscountsDisplayOrder];
    self.supplierShopDiscountsIdentifier = [aDecoder decodeDoubleForKey:kSupplierShopDiscountsId];
    self.shopId = [aDecoder decodeDoubleForKey:kSupplierShopDiscountsShopId];
    self.discountDetail = [aDecoder decodeObjectForKey:kSupplierShopDiscountsDiscountDetail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_displayOrder forKey:kSupplierShopDiscountsDisplayOrder];
    [aCoder encodeDouble:_supplierShopDiscountsIdentifier forKey:kSupplierShopDiscountsId];
    [aCoder encodeDouble:_shopId forKey:kSupplierShopDiscountsShopId];
    [aCoder encodeObject:_discountDetail forKey:kSupplierShopDiscountsDiscountDetail];
}

- (id)copyWithZone:(NSZone *)zone
{
    SupplierShopDiscounts *copy = [[SupplierShopDiscounts alloc] init];
    
    if (copy) {

        copy.displayOrder = self.displayOrder;
        copy.supplierShopDiscountsIdentifier = self.supplierShopDiscountsIdentifier;
        copy.shopId = self.shopId;
        copy.discountDetail = [self.discountDetail copyWithZone:zone];
    }
    
    return copy;
}


@end
