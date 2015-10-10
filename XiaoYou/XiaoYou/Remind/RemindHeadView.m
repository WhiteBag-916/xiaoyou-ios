//
//  RemindHeadView.m
//  XiaoYou
//
//  Created by sheng on 15/9/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RemindHeadView.h"

#define REUSERID @"ReminHeadView"
@interface RemindHeadView ()
@property (nonatomic,strong) UILabel    *timeLabel;
@end

@implementation RemindHeadView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}

+(RemindHeadView *)remindHeadViewWithTableView:(UITableView *)tableView
{
    UITableViewHeaderFooterView *remindHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:REUSERID];
    if (!remindHeadView) {
        remindHeadView = [[RemindHeadView alloc]initWithReuseIdentifier:REUSERID];
    }
    remindHeadView.contentView.backgroundColor = [UIColor colorWithRed:247/255 green:247/255 blue:247/255 alpha:0];
    return (RemindHeadView*)remindHeadView;
}

-(void)initView {
    _timeLabel = [[UILabel alloc]init];
    [self addSubview:_timeLabel];
    _timeLabel.font = [UIFont systemFontOfSize:11];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    _timeLabel.text = @"今天 18:22";
}

@end
