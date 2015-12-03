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
@property (nonatomic, assign) NSInteger weekNum;
@property (nonatomic, assign) NSInteger nowWeek;

@end

@implementation ChooseWeekView

- (id)initWithBlock:(NSInteger)selectNum
            weekNum:(NSInteger)weekNum
            nowWeek:(NSInteger)nowWeek
              block:(ChooseWeekBlock)block {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor clearColor];
        
        _weekNum = weekNum;
        _nowWeek = nowWeek;
        
        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        [self addSubview:self.backgroundView];
        
        [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(hide)]];
        
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
        make.right.mas_equalTo(-105);
        make.left.mas_equalTo(105);
        make.height.mas_equalTo(190);
    }];
    
    UIImageView *backgroundImageView = [[UIImageView alloc]
                                        initWithImage:[UIImage imageNamed:@"class_tab_putup"]];
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

- (void)show {
    [super show];
    
    NSInteger showNum = (_selectNum-4<0)?0:_selectNum-4;
    
    if (showNum > 0) {
        //移动到可显示位置
        [_weekTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:showNum inSection:0]
                              atScrollPosition:UITableViewScrollPositionNone animated:NO];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _weekNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseWeekCell *cell = [tableView dequeueReusableCellWithIdentifier:kChooseWeekCell];
    
    NSInteger row = indexPath.row;
    
    [cell initData:row+1 selected:(row+1 == _selectNum) isNowWeek:(row+1 == _nowWeek)];
    
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
