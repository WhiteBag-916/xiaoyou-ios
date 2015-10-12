//
//  TagsCommonView.h
//  XiaoYou
//
//  Created by 尹先森 on 15/10/8.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileInfo.h"

@interface TagsCommonView : UIView

@property(nonatomic,strong)ProfileInfo * model;

- (void)setData:(ProfileInfo *) model;

@end
