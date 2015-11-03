//
//  SupplierShopDiscounts.h
//
//  Created by 先森 尹 on 15/11/3
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModel.h"


@interface SupplierShopDiscounts : YModel <NSCoding, NSCopying>

@property (nonatomic, assign) double displayOrder;
@property (nonatomic, assign) double supplierShopDiscountsIdentifier;
@property (nonatomic, assign) double shopId;
@property (nonatomic, strong) NSString *discountDetail;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
