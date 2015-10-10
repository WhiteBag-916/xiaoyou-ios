//
//  ContactsInfoSecondTableViewCell.h
//  XiaoYou
//
//  Created by 尹先森 on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"
#import "ProfileInfo.h"

extern NSString *const kContactsInfoSecondTableViewCell;

@interface ContactsInfoSecondTableViewCell : YTableViewCell

-(void)setCellInfo:(ProfileInfo *) model;

@end
