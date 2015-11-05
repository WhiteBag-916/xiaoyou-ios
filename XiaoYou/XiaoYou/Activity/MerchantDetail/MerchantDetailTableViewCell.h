//
//  MerchantDetailTableViewCell.h
//  XiaoYou
//
//  Created by 尹先森 on 15/10/22.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"
#import "SupplierShopDiscounts.h"

extern NSString *const kMerchantDetailTableViewCell;

@interface MerchantDetailTableViewCell : YTableViewCell

-(void)setCellInfo:(SupplierShopDiscounts *) model isHeader:(BOOL) isHeader;

@end
