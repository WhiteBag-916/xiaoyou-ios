//
//  ProfilePersonListTableViewCell.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"
extern NSString *const kProfilePersonListTableViewCell;
#define KCELLHEIGHT SCALE_NUM(90)
#define KFIND_CELLHEIGHT SCALE_NUM(120)

@class Author;
@interface ProfilePersonListTableViewCell : YTableViewCell

- (void)setData:(Author *)author needShowGender:(BOOL)needShowGender;

@end
