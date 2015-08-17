//
//  YCommonActionSheet.m
//  YCPai
//
//  Created by abc on 15/6/18.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "YCommonActionSheet.h"
#import "YFoundation.h"
#import "YControlsDefine.h"

static const NSUInteger kYActionSheetButtonHeight = 44;
static const NSUInteger kYActionSheetTitleHeight = 37;
static const NSUInteger kYActionSheetCancelSpace = 5;
static const NSUInteger kYActionSheetShareHeight = 15 + 46 + 5 + 14 + 15;


@interface YActionSheetItem()
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,copy) void (^block)();
@end


@implementation YActionSheetItem
+(instancetype)itemWithTitle:(NSString *)title block:(void(^)(void))block
{
    YActionSheetItem *item = [[self alloc] init];
    item.title = title;
    item.block = block;
    return item;
}


+(instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image block:(void(^)(void))block
{
    YActionSheetItem *item = [self itemWithTitle:title block:block];
    item.image = image;
    return item;
}

@end


@interface YActionSheetButton : UIButton
@property (nonatomic,strong) YActionSheetItem *item;
@property (nonatomic,copy)  void(^clickedBlock)(void);
@end

@implementation YActionSheetButton

- (instancetype)initWithFrame:(CGRect)frame;
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setTitle:@"" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1.0] forState:UIControlStateNormal];
        self.titleLabel.font = CONTENT_FONT(15);
    }
    return self;
}

- (void)setItem:(YActionSheetItem *)item
{
    _item = item;
    [self setTitle:item.title forState:UIControlStateNormal];
    if ([item.title isEqualToString:@"广告"]) {
        [self setTitleColor:[UIColor hexChangeFloat:@"f4453C"] forState:UIControlStateNormal];
    }
    [self addTarget:self action:@selector(actionClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (item.image) {
        [self setImage:item.image forState:UIControlStateNormal];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        self.imageEdgeInsets = UIEdgeInsetsMake(0,16,0,0);
        CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
        self.titleEdgeInsets = UIEdgeInsetsMake(46 + 4,(self.width - textSize.width)/2 - 46, 0, 0);
    }
}

- (void)actionClicked:(YActionSheetButton *)sender
{
    if (_clickedBlock) {
        _clickedBlock();
    }
    if (sender.item.block) {
        sender.item.block();
    }
}

@end


@interface YCommonActionSheet()
@property (nonatomic,strong) UIView *sheetViewBackgroundView;
@property (nonatomic,strong) UIView *backgroundView;
@end

@implementation YCommonActionSheet

- (instancetype)initWithType:(YCommonActionSheetType)type items:(NSArray *)items title:(NSString *)title {
    
    if (self = [super initWithFrame:[[UIScreen mainScreen] bounds]]) {
        self.backgroundColor = [UIColor clearColor];
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0;
        [self addSubview:_backgroundView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        CGFloat sheetViewBackgroundViewHeight = (title.length > 0? kYActionSheetTitleHeight:0) + (YCommonActionSheetTypeShare == type ? kYActionSheetShareHeight:items.count * 44) + kYActionSheetCancelSpace + kYActionSheetButtonHeight;
        
        _sheetViewBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, sheetViewBackgroundViewHeight)];
        
        CGFloat height = 0;
        
        if (title.length > 0) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height, self.width, kYActionSheetTitleHeight)];
            titleLabel.text = title;
            titleLabel.textColor = [UIColor hexChangeFloat:@"acacac"];
            titleLabel.backgroundColor = [UIColor whiteColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = CONTENT_FONT(13);
            
            [_sheetViewBackgroundView addSubview:titleLabel];
            
            UIImageView *lineImageHView = [[UIImageView alloc] initWithFrame:CGRectMake(8, kYActionSheetTitleHeight - 1, self.width - (8 * 2) , 1)];
            lineImageHView.image = [UIImage imageNamed:@"Public_px_line"];
            
            [_sheetViewBackgroundView addSubview:lineImageHView];
            
            height += kYActionSheetTitleHeight;
        }
        
        if (YCommonActionSheetTypeShare == type)
        {
            UIView *buttonContentView = [[UIView alloc] initWithFrame:CGRectMake(0, height, self.width, kYActionSheetShareHeight)];
            buttonContentView.backgroundColor = [UIColor whiteColor];
            [_sheetViewBackgroundView addSubview:buttonContentView];
        }
        
        for (int i = 0; i < items.count; i++) {
            YActionSheetItem *item = items[i];
            if (YCommonActionSheetTypeCommon == type) {
                YActionSheetButton *actionButton = [[YActionSheetButton alloc] initWithFrame:CGRectMake(0,height + kYActionSheetButtonHeight * i, self.width, kYActionSheetButtonHeight)];
                actionButton.item = item;
                WS(weakSelf);
                actionButton.clickedBlock = ^{
                    [weakSelf dismiss];
                };
                
                [_sheetViewBackgroundView addSubview:actionButton];
                if (i < items.count - 1) {
                    UIImageView *lineImageHView = [[UIImageView alloc] initWithFrame:CGRectMake(8, kYActionSheetButtonHeight - 1, self.width - (8 * 2) , 1)];
                    lineImageHView.image = [UIImage imageNamed:@"Public_lpx_line"];
                    [actionButton addSubview:lineImageHView];
                }
            }
            else if (YCommonActionSheetTypeShare == type)
            {
                NSUInteger with = self.width - 4;
                NSUInteger buttonWith = 46 + 16*2;
                NSUInteger splitWith = (with/items.count - buttonWith)/2;
                
                YActionSheetButton *actionButton = [[YActionSheetButton alloc] initWithFrame:CGRectMake(4 + (with/items.count) * i + splitWith,height + 15, buttonWith, 46 + 5 + 13)];
                actionButton.item = item;
                WS(weakSelf);
                actionButton.clickedBlock = ^{
                    [weakSelf dismiss];
                };
                [_sheetViewBackgroundView addSubview:actionButton];
            }
        }
        
        _sheetViewBackgroundView.backgroundColor = [UIColor clearColor];
        YActionSheetButton *cancelButton = [[YActionSheetButton alloc] initWithFrame:CGRectMake(0, sheetViewBackgroundViewHeight - kYActionSheetButtonHeight, self.width, kYActionSheetButtonHeight)];
        [cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor hexChangeFloat:@"494949"] forState:UIControlStateNormal];
        [_sheetViewBackgroundView addSubview:cancelButton];
        [self addSubview:_sheetViewBackgroundView];
        
    }
    return self;
}


- (void)show
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        _backgroundView.alpha = .4f;
        _sheetViewBackgroundView.originY = self.height - _sheetViewBackgroundView.height;
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}

- (void)dismiss
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.25 animations:^{
        _backgroundView.alpha = 0;
        _sheetViewBackgroundView.originY = self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}

@end
