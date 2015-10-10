//
//  ProfilePersonListTableViewCell.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"
extern NSString *const kProfilePersonListTableViewCell;
//todo:此处隐藏一个bug,当下面的88设为90的时候,第一次加载的时候底下会有多余显示不全的一行
#define KCELLHEIGHT SCALE_NUM(88)
#define KFIND_CELLHEIGHT SCALE_NUM(120)

@class Author;
@interface ProfilePersonListTableViewCell : YTableViewCell

- (void)setData:(Author *)author needShowGender:(BOOL)needShowGender;

@end
