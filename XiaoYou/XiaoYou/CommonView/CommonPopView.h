//
//  CommonPopView.h
//  YCPai
//
//  Created by 熊宸 on 15/5/19.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "YView.h"

@interface CommonPopView : YView

@property (nonatomic, assign) id                delegate;
@property (nonatomic, assign) SEL               comAction;
@property (nonatomic, assign) id                params;
@property (nonatomic, assign) id                cancledelegate;
@property (nonatomic, assign) SEL               cancleAction;
@property (nonatomic, assign) id                cancleparams;
@property (nonatomic, assign) BOOL              isTop;
@property (nonatomic, assign) BOOL              showBtn;
@property (strong, nonatomic) UIView    *grayView;          //灰色背景
@property (strong, nonatomic) UIView    *bgView;            //外面view添加在这个上面
@property (nonatomic, assign) BOOL              isAddRootWindow;    //是否添加到root

- (instancetype)initWithFrame:(CGRect)frame
                   showButton:(BOOL)isShowButton
                       addSub:(UIView *)view
                        isTop:(BOOL)top
                       isRoot:(BOOL)addRoot
                      addSelf:(UIView *)superView;

//点击完成按钮时加载
- (void)comSet:(id)delegate action:(SEL)comAction params:(id)params;

//取消显示时加载方法
- (void)cancleSet:(id)delegate action:(SEL)cancleAction params:(id)params;

- (void)showView;

@end
