//
//  SupplierShopImages.m
//
//  Created by 先森 尹 on 15/11/3
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SupplierShopImages.h"


NSString *const kSupplierShopImagesDisplayOrder = @"displayOrder";
NSString *const kSupplierShopImagesId = @"id";
NSString *const kSupplierShopImagesShopId = @"shopId";
NSString *const kSupplierShopImagesImageUrl = @"imageUrl";


@interface SupplierShopImages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SupplierShopImages

@synthesize displayOrder = _displayOrder;
@synthesize supplierShopImagesIdentifier = _supplierShopImagesIdentifier;
@synthesize shopId = _shopId;
@synthesize imageUrl = _imageUrl;


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
            self.displayOrder = [[self objectOrNilForKey:kSupplierShopImagesDisplayOrder fromDictionary:dict] doubleValue];
            self.supplierShopImagesIdentifier = [[self objectOrNilForKey:kSupplierShopImagesId fromDictionary:dict] doubleValue];
            self.shopId = [[self objectOrNilForKey:kSupplierShopImagesShopId fromDictionary:dict] doubleValue];
            self.imageUrl = [self objectOrNilForKey:kSupplierShopImagesImageUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.displayOrder] forKey:kSupplierShopImagesDisplayOrder];
    [mutableDict setValue:[NSNumber numberWithDouble:self.supplierShopImagesIdentifier] forKey:kSupplierShopImagesId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shopId] forKey:kSupplierShopImagesShopId];
    [mutableDict setValue:self.imageUrl forKey:kSupplierShopImagesImageUrl];

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

    self.displayOrder = [aDecoder decodeDoubleForKey:kSupplierShopImagesDisplayOrder];
    self.supplierShopImagesIdentifier = [aDecoder decodeDoubleForKey:kSupplierShopImagesId];
    self.shopId = [aDecoder decodeDoubleForKey:kSupplierShopImagesShopId];
    self.imageUrl = [aDecoder decodeObjectForKey:kSupplierShopImagesImageUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_displayOrder forKey:kSupplierShopImagesDisplayOrder];
    [aCoder encodeDouble:_supplierShopImagesIdentifier forKey:kSupplierShopImagesId];
    [aCoder encodeDouble:_shopId forKey:kSupplierShopImagesShopId];
    [aCoder encodeObject:_imageUrl forKey:kSupplierShopImagesImageUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    SupplierShopImages *copy = [[SupplierShopImages alloc] init];
    
    if (copy) {

        copy.displayOrder = self.displayOrder;
        copy.supplierShopImagesIdentifier = self.supplierShopImagesIdentifier;
        copy.shopId = self.shopId;
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
    }
    
    return copy;
}


@end
