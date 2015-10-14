//
//  CommonPopView.m
//  YCPai
//
//  Created by 熊宸 on 15/5/19.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "CommonPopView.h"
#import "YCPDefine.h"

@implementation CommonPopView

- (instancetype)initWithFrame:(CGRect)frame
                   showButton:(BOOL)isShowButton
                       addSub:(UIView *)view
                        isTop:(BOOL)top
                       isRoot:(BOOL)addRoot
                      addSelf:(UIView *)superView
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isTop = top;
        self.isAddRootWindow = addRoot;
        
        self.grayView = [[UIView alloc] initWithFrame:frame];
        self.grayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self addSubview:self.grayView];
        UITapGestureRecognizer *tapgest = [[UITapGestureRecognizer alloc] init];
        [tapgest addTarget:self action:@selector(clickCancel)];
        [self.grayView addGestureRecognizer:tapgest];
        
        //根据view计算背景高度  上下间隔20
        NSInteger bgHeight = view.height+40*2;
        if (isShowButton)
        {
            bgHeight += 20;
        }
        
        CGRect begainFrame = self.isTop ? CGRectMake(0, 0-bgHeight, self.width, bgHeight) : CGRectMake(0, self.bottomY, self.width, bgHeight);
        self.bgView = [[UIView alloc] initWithFrame:begainFrame];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.grayView addSubview:self.bgView];
        
        if (isShowButton)
        {
            //view上加入按钮
            UIButton *backCancel = [self setButton:0];
            [backCancel addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchDown];
            [self.bgView addSubview:backCancel];
            UIButton *btnOk = [self setButton:1];
            [btnOk addTarget:self action:@selector(clickOk) forControlEvents:UIControlEventTouchDown];
            [self.bgView addSubview:btnOk];
            
            view.originY = 40;
        }
        else
        {
            view.originY = 0;
        }
        
        [self.bgView addSubview:view];
        
        [superView addSubview:self];
    }
    return self;
}

//点击完成按钮时加载
- (void)comSet:(id)delegate action:(SEL)comAction params:(id)params
{
    self.delegate = delegate;
    self.comAction = comAction;
    self.params = params;
}

//取消显示时加载方法
- (void)cancleSet:(id)delegate action:(SEL)cancleAction params:(id)params
{
    self.cancledelegate = delegate;
    self.cancleAction = cancleAction;
    self.cancleparams = params;
}

- (void)showView
{
    [UIView animateWithDuration:0.25 animations:^{
        if (self.isTop)
        {
            self.bgView.originY = 0;
        }
        else
        {
            self.bgView.originY = self.height - self.bgView.height;
            if (!self.isAddRootWindow)
            {
                //减去顶部高度
                self.bgView.originY -= KNavigationBarheight;
            }
        }
    }];
}

//创建按钮
- (UIButton *)setButton:(NSInteger)btnType
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (1 == btnType)
    {
        button.frame = CGRectMake(self.width-45, 8, 40, 40);
        [button setImage:[UIImage imageNamed:@"night_share_send"] forState:UIControlStateNormal];
    }
    else
    {
        button.frame = CGRectMake(5, 8, 40, 40);
        [button setImage:[UIImage imageNamed:@"night_share_cancel"] forState:UIControlStateNormal];
    }
    
    button.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    return button;
}

- (void)clickCancel
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect endFrame = self.isTop ? CGRectMake(0, 0, self.width, 0) : CGRectMake(0, self.height-5, self.width, 0);
        self.bgView.frame = endFrame;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)clickOk
{
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self.delegate selector:self.comAction userInfo:self.params repeats:NO];
    [self clickCancel];
}

@end
