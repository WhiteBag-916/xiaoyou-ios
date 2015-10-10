//
//  ContactsInfoThirdTableViewCell.h
//  XiaoYou
//
//  Created by 尹先森 on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"
#import "ProfileInfo.h"

extern NSString *const kContactsInfoThirdTableViewCell;

@protocol ContactsInfoThirdTableViewCellDelegate <NSObject>

-(void)didSelectCool;

@end

@interface ContactsInfoThirdTableViewCell : YTableViewCell

@property(nonatomic,weak)id<ContactsInfoThirdTableViewCellDelegate>myDelegate;
-(void)setCellInfo:(ProfileInfo *) model;

@end
