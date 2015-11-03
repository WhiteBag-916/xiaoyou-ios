//
//  SupplierShopModel.h
//
//  Created by 先森 尹 on 15/11/3
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SupplierShopModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double supplierShopModelIdentifier;
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, strong) NSString *qrCodeUrl;
@property (nonatomic, assign) double cooperationStartTime;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) double displayOrder;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *shopDetail;
@property (nonatomic, strong) NSString *cooperationMode;
@property (nonatomic, assign) double cooperationEndTime;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *shopLogoUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double updateTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
