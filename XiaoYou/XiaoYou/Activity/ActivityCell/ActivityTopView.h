//
//  FunnyTopView.h
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableView.h"
#import "ActivityDetailModel.h"
/**
 设置文本是否全部展开,不传参数或者传SHORT_BRIEF不展开
 */
typedef enum : NSUInteger {
    SHORT_BRIEF1,
    DETAIL_INFO1
} TOPVIEWTYPE1;

@interface ActivityTopView : UIView
-(instancetype)initWithType:(TOPVIEWTYPE1)viewType;
@property (nonatomic,strong) UILabel        *descriptionLabel;//描述,只显示一行;

-(void)setData:(ActivityDetailModel*)model;

@end
