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
#import "YCommonShare.h"
#import "ContactManager.h"
#import "MessageManager.h"

static const NSUInteger kYActionSheetButtonHeight = 50;
static const NSUInteger kYActionSheetTitleHeight = 37;
static const NSUInteger kYActionSheetCancelHeight = 49;


@interface YActionSheetItem()
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) YCommonActionItemSheetType type;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL isGroup;
@property (nonatomic,copy) ActionSheetItemBlock block;
@property (nonatomic,copy) NSDictionary *extraData;
@end


@implementation YActionSheetItem
+(instancetype)itemWithTitle:(NSString *)title type:(YCommonActionItemSheetType)type block:(ActionSheetItemBlock)block
{
    YActionSheetItem *item = [[self alloc] init];
    item.title = title;
    item.block = block;
    item.type = type;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title type:(YCommonActionItemSheetType)type isGroup:(BOOL)isGroup open:(BOOL)isOpen extraData:(NSDictionary *)extraData block:(ActionSheetItemBlock)block {
    YActionSheetItem *item = [YActionSheetItem itemWithTitle:title
                                                        type:type
                                                     isGroup:isGroup
                                                        open:isOpen
                                                   extraData:extraData];
    item.block = block;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title type:(YCommonActionItemSheetType)type isGroup:(BOOL)isGroup open:(BOOL)isOpen extraData:(NSDictionary *)extraData
{
    YActionSheetItem *item = [YActionSheetItem itemWithTitle:title
                                                        type:type
                                                       block:nil];
    item.isOpen = isOpen;
    item.isGroup = isGroup;
    item.extraData = extraData;
    return item;
}
+ (instancetype)itemWithType:(YCommonActionItemSheetType)type title:(NSString *)title extraData:(NSDictionary *)extraData {
    YActionSheetItem *item = [YActionSheetItem itemWithTitle:title
                                                        type:type
                                                       block:nil];
    item.extraData = extraData;
    return item;
}
@end

@interface YActionSheetView : UIView
@property (nonatomic,strong) YActionSheetItem *item;
@property (nonatomic,copy)  void(^clickedBlock)(void);
@end

@implementation YActionSheetView
- (void)setItem:(YActionSheetItem *)item
{
    _item = item;
    if (YCommonActionSheetItemTypeCommon == item.type) {
        [self initCommon];
    } else if (YCommonActionSheetItemTypeShareFeed == item.type || YCommonActionSheetItemTypeSharePerson == item.type || YCommonActionSheetItemTypeShareOrganization == item.type || YCommonActionSheetItemTypeShareActivity == item.type) {
        [self initShare];
    } else if (YCommonActionSheetItemTypeSwitch == item.type) {
        [self initSwitch];
    } else if (YCommonActionSheetItemTypeCenterCommon == item.type) {
        [self initCenterCommon];
    }
}

- (void)initCenterCommon {
    UIButton *button = [self addButton:0 frame:self.bounds image:nil title:_item.title];
    [self addSubview:button];
}

- (void)initCommon {
    //1
    UILabel *label = [self addLabel:_item.title];
    [self addSubview:label];
    
    //2
    UIButton *button = [self addButton:0 frame:self.bounds image:nil title:@""];
    [self addSubview:button];
}

- (void)initShare {
    //1
    UILabel *label = [self addLabel:_item.title];
    [self addSubview:label];
    
    //2
    UIButton *button = [self addButton:YShareTypeToWechatSession frame:CGRectMake(self.width-90, 0, 37, self.height) image:@"wechat" title:@""];
    [self addSubview:button];
    
    //3
    UIButton *button2 = [self addButton:YShareTypeToWechatTimeline frame:CGRectMake(self.width-46, 0, 37, self.height) image:@"wechat_friends" title:@""];
    [self addSubview:button2];
}

- (void)initSwitch {
    //1
    UILabel *label = [self addLabel:_item.title];
    [self addSubview:label];
    
    //2
    UIButton *switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    switchButton.backgroundColor = [UIColor clearColor];
//    switchButton.frame = CGRectMake(self.width-43, 0, 27, self.height);
    switchButton.frame = CGRectMake(self.width-55, 0, 54, self.height);

    switchButton.tag = 10001;
    [switchButton addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:switchButton];
    
    [self updateSwitchButton];
}

- (void)updateSwitchButton {
    UIButton *switchButton = (UIButton *)[self viewWithTag:10001];
    if (_item.isOpen)
    {
        [switchButton setImage:[UIImage imageNamed:@"toggle-on"] forState:UIControlStateNormal];
        [switchButton setImage:[UIImage imageNamed:@"toggle-on"] forState:UIControlStateHighlighted];
    }
    else
    {
        [switchButton setImage:[UIImage imageNamed:@"toggle-off"] forState:UIControlStateNormal];
        [switchButton setImage:[UIImage imageNamed:@"toggle-off"] forState:UIControlStateHighlighted];
    }
}

- (UILabel *)addLabel:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(23, 0, self.width-23*2, self.height)];
    label.text = text;
    label.textColor = KCOLORWHITE;
    label.font = CONTENT_FONT(12);
    return label;
}

- (UIButton *)addButton:(NSInteger)tag frame:(CGRect)frame image:(NSString *)imageName title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (nil != imageName)
    {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    }
    else
    {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:KCOLORWHITE forState:UIControlStateNormal];
        button.titleLabel.font = CONTENT_FONT(12);
    }
    
    button.tag = tag;
    [button addTarget:self action:@selector(actionClicked:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)actionClicked:(UIButton *)sender
{
    if (_clickedBlock) {
        _clickedBlock();
    }
    if (_item.block) {
        _item.block(sender.tag);
    }
    if (_item.type == YCommonActionSheetItemTypeShareFeed) {
        [[YCommonShare sharedInstance] shareForViewControllerWithType:YCommonShareDetailTypeFeed dataModel:_item.extraData shareType:sender.tag];
    }
    if (_item.type == YCommonActionSheetItemTypeShareOrganization) {
        [[YCommonShare sharedInstance] shareForViewControllerWithType:YCommonShareDetailTypeAssociation dataModel:_item.extraData shareType:sender.tag];
    }
    if (_item.type == YCommonActionSheetItemTypeSharePerson) {
        [[YCommonShare sharedInstance] shareForViewControllerWithType:YCommonShareDetailTypePerson dataModel:_item.extraData shareType:sender.tag];
    }
    if (YCommonActionSheetItemTypeShareActivity == _item.type) {
        [[YCommonShare sharedInstance] shareForViewControllerWithType:YCommonShareDetailTypeActivity dataModel:_item.extraData shareType:sender.tag];
    }
}

-(void)switchAction
{
    if (!_item.isGroup) {
        [YUtils showHUDWithTitle];
        [[ContactManager sharedInstance] forbiddenLinkMan:_item.extraData[@"uid"] block:^(YActionMessage *message) {
            [YUtils hiddenProgressHUD];
            if (message.isSuccess) {
                _item.isOpen = !_item.isOpen;
                
                [self updateSwitchButton];
            }
            
            [YUtils showTitle:message.desc];
        }];
    } else {
        [[MessageManager sharedInstance] forbiddenGroupByThirdCode:_item.extraData[@"thirdCode"] block:^(BOOL isSuccess) {
            NSString *str;
            if (isSuccess)
            {
                _item.isOpen = !_item.isOpen;
                
                [self updateSwitchButton];
                
                if (_item.isOpen) {
                    [YUtils showTitle:@"屏蔽成功"];
                } else {
                    [YUtils showTitle:@"取消屏蔽成功"];
                }
            }
            else
            {
                if (_item.isOpen) {
                    [YUtils showTitle:@"取消屏蔽失败"];
                } else {
                    [YUtils showTitle:@"屏蔽失败"];
                }
            }
            
            [YUtils showTitle:str];
        }];
    }
}

@end

@interface YCommonActionSheet()
@property (nonatomic,strong) UIView *sheetViewBackgroundView;
@property (nonatomic,strong) UIView *backgroundView;
@end

@implementation YCommonActionSheet

- (instancetype)initWithType:(NSArray *)items title:(NSString *)title {
    
    if (self = [super initWithFrame:[[UIScreen mainScreen] bounds]]) {
        self.backgroundColor = [UIColor clearColor];
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0;
        [self addSubview:_backgroundView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        CGFloat sheetViewBackgroundViewHeight = (title.length > 0? kYActionSheetTitleHeight:0) + items.count * kYActionSheetButtonHeight + kYActionSheetCancelHeight;
        
        _sheetViewBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, sheetViewBackgroundViewHeight)];
        _sheetViewBackgroundView.backgroundColor = KCOLOR_455A64;
        
        CGFloat height = 0;
        
        if (title.length > 0) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height, self.width, kYActionSheetTitleHeight)];
            titleLabel.text = title;
            titleLabel.textColor = [UIColor hexChangeFloat:@"acacac"];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = CONTENT_FONT(13);
            
            [_sheetViewBackgroundView addSubview:titleLabel];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kYActionSheetButtonHeight - 1, self.width, 1)];
            lineView.backgroundColor = [UIColor whiteColor];
            
            [_sheetViewBackgroundView addSubview:lineView];
            
            height += kYActionSheetTitleHeight;
        }
        
        for (int i = 0; i < items.count; i++) {
            YActionSheetItem *item = items[i];
            YActionSheetView *actionView = [[YActionSheetView alloc] initWithFrame:CGRectMake(0,height + kYActionSheetButtonHeight * i, self.width, kYActionSheetButtonHeight)];
            actionView.item = item;
            WS(weakSelf);
            actionView.clickedBlock = ^{
                [weakSelf dismiss];
            };
            
            [_sheetViewBackgroundView addSubview:actionView];
//            if (i < items.count - 1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kYActionSheetButtonHeight - 1, self.width, 1)];
                lineView.backgroundColor = [UIColor whiteColor];
                [actionView addSubview:lineView];
//            }
        }
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, sheetViewBackgroundViewHeight - kYActionSheetCancelHeight, self.width, kYActionSheetCancelHeight)];
        [cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setImage:[UIImage imageNamed:@"sheet_delete"] forState:UIControlStateNormal];
        [cancelButton setImage:[UIImage imageNamed:@"sheet_delete"] forState:UIControlStateHighlighted];
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
//        _backgroundView.alpha = .4f;
        _sheetViewBackgroundView.originY = self.height - _sheetViewBackgroundView.height;
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}

- (void)dismiss
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.25 animations:^{
//        _backgroundView.alpha = 0;
        _sheetViewBackgroundView.originY = self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}

@end
