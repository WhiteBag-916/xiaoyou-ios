//
//  ChooseWeekCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ChooseWeekCell.h"

NSString *const kChooseWeekCell = @"ChooseWeekCellId";

@interface ChooseWeekCell ()

@property (nonatomic, strong) UILabel *weekLabel;

@end

@implementation ChooseWeekCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initView];
        
        self.contentView.backgroundColor = KCOLORWHITE;
    }
    
    return self;
}

- (void)initView {
    _weekLabel = [YUtils initLabel:CONTENT_FONT(15)
                             color:KCOLOR_g1
                              text:@"第8周(本周)"
                         alignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_weekLabel];
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)initData:(NSInteger)num selected:(BOOL)selected isNowWeek:(BOOL)isNowWeek {
    _weekLabel.text = [NSString stringWithFormat:@"第%ld周", (long)num];
    if (isNowWeek) {
        _weekLabel.text = [_weekLabel.text stringByAppendingString:@"(本周)"];
    }
    if (selected) {
        _weekLabel.backgroundColor = KCOLOR_g1;
        _weekLabel.textColor = KCOLOR_W1;
    } else {
        _weekLabel.backgroundColor = KCOLOR_W1;
        _weekLabel.textColor = KCOLOR_g1;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
