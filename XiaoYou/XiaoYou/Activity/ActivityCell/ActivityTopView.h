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


#pragma mark 暂时移动到这里
@property (nonatomic,strong) UIImageView    *headImageView; //公告图
@property (nonatomic,strong) UIView         *sepLineView;   //分割线
@property (nonatomic,strong) UILabel        *nameLabel;     //名称
@property (nonatomic,strong) UILabel        *titleLabel;    //标题(校级活动公告)
@property (nonatomic,strong) UILabel        *staticNameLabel;//静态name
@property (nonatomic,strong) UILabel        *staticDesLabel;
@end
