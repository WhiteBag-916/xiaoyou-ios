//
//  ShopList.m
//
//  Created by 先森 尹 on 15/11/3
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ShopList.h"
#import "SupplierShopImages.h"
#import "SupplierShopDiscounts.h"
#import "SupplierShopModel.h"


NSString *const kShopListSupplierShopImages = @"supplierShopImages";
NSString *const kShopListSupplierShopDiscounts = @"supplierShopDiscounts";
NSString *const kShopListSupplierShopModel = @"supplierShopModel";


@interface ShopList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ShopList

@synthesize supplierShopImages = _supplierShopImages;
@synthesize supplierShopDiscounts = _supplierShopDiscounts;
@synthesize supplierShopModel = _supplierShopModel;


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
    NSObject *receivedSupplierShopImages = [dict objectForKey:kShopListSupplierShopImages];
    NSMutableArray *parsedSupplierShopImages = [NSMutableArray array];
    if ([receivedSupplierShopImages isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSupplierShopImages) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSupplierShopImages addObject:[SupplierShopImages modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSupplierShopImages isKindOfClass:[NSDictionary class]]) {
       [parsedSupplierShopImages addObject:[SupplierShopImages modelObjectWithDictionary:(NSDictionary *)receivedSupplierShopImages]];
    }

    self.supplierShopImages = [NSArray arrayWithArray:parsedSupplierShopImages];
    NSObject *receivedSupplierShopDiscounts = [dict objectForKey:kShopListSupplierShopDiscounts];
    NSMutableArray *parsedSupplierShopDiscounts = [NSMutableArray array];
    if ([receivedSupplierShopDiscounts isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSupplierShopDiscounts) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSupplierShopDiscounts addObject:[SupplierShopDiscounts modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSupplierShopDiscounts isKindOfClass:[NSDictionary class]]) {
       [parsedSupplierShopDiscounts addObject:[SupplierShopDiscounts modelObjectWithDictionary:(NSDictionary *)receivedSupplierShopDiscounts]];
    }

    self.supplierShopDiscounts = [NSArray arrayWithArray:parsedSupplierShopDiscounts];
            self.supplierShopModel = [SupplierShopModel modelObjectWithDictionary:[dict objectForKey:kShopListSupplierShopModel]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForSupplierShopImages = [NSMutableArray array];
    for (NSObject *subArrayObject in self.supplierShopImages) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSupplierShopImages addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSupplierShopImages addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSupplierShopImages] forKey:kShopListSupplierShopImages];
    NSMutableArray *tempArrayForSupplierShopDiscounts = [NSMutableArray array];
    for (NSObject *subArrayObject in self.supplierShopDiscounts) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSupplierShopDiscounts addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSupplierShopDiscounts addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSupplierShopDiscounts] forKey:kShopListSupplierShopDiscounts];
    [mutableDict setValue:[self.supplierShopModel dictionaryRepresentation] forKey:kShopListSupplierShopModel];

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

    self.supplierShopImages = [aDecoder decodeObjectForKey:kShopListSupplierShopImages];
    self.supplierShopDiscounts = [aDecoder decodeObjectForKey:kShopListSupplierShopDiscounts];
    self.supplierShopModel = [aDecoder decodeObjectForKey:kShopListSupplierShopModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_supplierShopImages forKey:kShopListSupplierShopImages];
    [aCoder encodeObject:_supplierShopDiscounts forKey:kShopListSupplierShopDiscounts];
    [aCoder encodeObject:_supplierShopModel forKey:kShopListSupplierShopModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    ShopList *copy = [[ShopList alloc] init];
    
    if (copy) {

        copy.supplierShopImages = [self.supplierShopImages copyWithZone:zone];
        copy.supplierShopDiscounts = [self.supplierShopDiscounts copyWithZone:zone];
        copy.supplierShopModel = [self.supplierShopModel copyWithZone:zone];
    }
    
    return copy;
}


@end
