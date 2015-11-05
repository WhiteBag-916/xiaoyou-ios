//
//  MerchantListTableViewCell.h
//  XiaoYou
//
//  Created by 尹先森 on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"
#import "ShopList.h"

extern NSString *const kMerchantListTableViewCell;

@interface MerchantListTableViewCell : YTableViewCell

-(void)setCellData:(ShopList *) model;

@end
