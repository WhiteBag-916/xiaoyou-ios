//
//  FunnyTopView.h
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableView.h"
/**
 设置文本是否全部展开,不传参数或者传SHORT_BRIEF不展开
 */
typedef enum : NSUInteger {
    SHORT_BRIEF,
    DETAIL_INFO
} TOPVIEWTYPE;

@interface ActivityTopView : UIView
-(instancetype)initWithType:(TOPVIEWTYPE)viewType;
@property (nonatomic,strong) UILabel        *descriptionLabel;//描述,只显示一行;
@end
