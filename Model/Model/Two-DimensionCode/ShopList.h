//
//  ShopList.h
//
//  Created by 先森 尹 on 15/11/3
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SupplierShopModel;

@interface ShopList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *supplierShopImages;
@property (nonatomic, strong) NSArray *supplierShopDiscounts;
@property (nonatomic, strong) SupplierShopModel *supplierShopModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
