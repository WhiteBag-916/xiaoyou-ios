//
//  ChooseWeekView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ChooseWeekView.h"
#import "ChooseWeekCell.h"

#define K_BACK_LR         SCALE_NUM(15)
#define K_BACK_T         SCALE_NUM(123)
#define K_BACK_H         SCALE_NUM(260)

@interface ChooseWeekView ()
<UITableViewDataSource
,UITableViewDelegate>

@property (nonatomic, strong) UITableView *weekTableView;
@property (nonatomic, copy) ChooseWeekBlock chooseWeekBlock;
@property (nonatomic, assign) NSInteger selectNum;

@end

@implementation ChooseWeekView

- (id)initWithBlock:(NSInteger)selectNum block:(ChooseWeekBlock)block {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        [self addSubview:self.backgroundView];
        
        [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
        
        [self initContentView];
        
        _chooseWeekBlock = block;
        
        _selectNum = selectNum;
    }
    return self;
}


- (void)initContentView {
    self.contentView = [[UIView alloc] init];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(49));
        make.centerX.equalTo(self);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(190);
    }];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"class_tab_putup"]];
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
    [_weekTableView registerClass:[ChooseWeekCell class] forCellReuseIdentifier:kChooseWeekCell];
    [self.contentView addSubview:_weekTableView];
    [_weekTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(12, 0, 0, 0));
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseWeekCell *cell = [tableView dequeueReusableCellWithIdentifier:kChooseWeekCell];
    
    NSInteger row = indexPath.row;
    
    [cell initData:row+1 selected:(row+1 == _selectNum)];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(30);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide];
    
    _chooseWeekBlock(indexPath.row+1);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
