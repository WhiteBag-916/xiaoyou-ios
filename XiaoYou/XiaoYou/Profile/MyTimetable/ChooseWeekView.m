//
//  ChooseWeekView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ChooseWeekView.h"

#define K_BACK_LR         SCALE_NUM(15)
#define K_BACK_T         SCALE_NUM(123)
#define K_BACK_H         SCALE_NUM(260)

@interface ChooseWeekView ()
<UITableViewDataSource
,UITableViewDelegate>

@property (nonatomic, strong) UITableView *weekTableView;

@end

@implementation ChooseWeekView

- (instancetype)init {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        [self addSubview:self.backgroundView];
        
        [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
        
        [self initContentView];
    }
    return self;
}


- (void)initContentView {
    self.contentView = [[UIView alloc] init];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self).insets(UIEdgeInsetsMake(K_BACK_T, K_BACK_LR, K_BACK_B, K_BACK_LR));
    }];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    backgroundImageView.image = [[UIImage imageNamed:@"build_background"] resizableImageWithCapInsets:UIEdgeInsetsMake(9, 5, 6, 5) resizingMode:UIImageResizingModeStretch];
    [self.contentView addSubview:backgroundImageView];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self initTableView];
}

- (void)initTableView {
    _weekTableView = [[UITableView alloc] init];
    _weekTableView.delegate = self;
    _weekTableView.dataSource = self;
    _weekTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(90);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
