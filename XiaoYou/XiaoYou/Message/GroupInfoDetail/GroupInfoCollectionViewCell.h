//
//  GroupInfoCollectionViewCell.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kGroupInfoCollectionViewCell;

@interface GroupInfoCollectionViewCell : UICollectionViewCell

-(void)setCellInfo:(NSDictionary *) groupDic;

@end
