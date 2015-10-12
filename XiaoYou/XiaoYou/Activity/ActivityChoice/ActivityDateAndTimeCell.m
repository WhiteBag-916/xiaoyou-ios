//
//  ActivityDateAndTimeCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityDateAndTimeCell.h"

NSString *const kActivityDateAndTimeCell = @"ActivityDateAndTimeCellId";

@interface ActivityDateAndTimeCell ()

@property (nonatomic,strong) UIDatePicker * datePickerView;

@end

@implementation ActivityDateAndTimeCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setUpUI];

    }
    return self;
}

-(void)setUpUI
{
    UIImageView * dateImageView = [[UIImageView alloc] init];
    dateImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:dateImageView];
    [dateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.top.mas_equalTo(22);
        make.height.width.mas_equalTo(17);
    }];
    
    UILabel * dateLabel = [[UILabel alloc] init];
    dateLabel.backgroundColor = [UIColor blueColor];
    dateLabel.text = @"时间与日期";
    dateLabel.font = CONTENT_FONT(17);
    [self.contentView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateImageView.mas_right).offset(5);
        make.centerY.equalTo(dateImageView);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(85);
    }];
    
    _datePickerView = [[UIDatePicker alloc] init];
    [self.contentView addSubview:_datePickerView];
    [_datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(dateLabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(120);
    }];
    [_datePickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];

}

-(void)dateChanged:(id)sender{
    /*添加你自己响应代码*/
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
