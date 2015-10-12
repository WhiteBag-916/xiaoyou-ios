//
//  ActivityReleaseAndTypeCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityReleaseAndTypeCell.h"

NSString *const kActivityReleaseAndTypeCell = @"ActivityReleaseAndTypeCellId";

@interface ActivityReleaseAndTypeCell ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) UIPickerView * datePickerView;
@property (nonatomic,strong) NSArray * dataArr;

@end

@implementation ActivityReleaseAndTypeCell

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

-(void)setCellType:(NSInteger) num
{
    if (num == 1)
    {
        _dataArr = @[@"学校活动",@"校友活动",@"个人活动",@"社团活动"];
    }
    else
    {
        _dataArr = @[@"全部",@"综合类",@"学术类",@"公益类",@"教科类"];
    }
    [_datePickerView reloadAllComponents];
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
    dateLabel.text = @"日期";
    dateLabel.font = CONTENT_FONT(17);
    [self.contentView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateImageView.mas_right).offset(5);
        make.centerY.equalTo(dateImageView);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(34);
    }];
    
    _datePickerView = [[UIPickerView alloc] init];
    _datePickerView.delegate = self;
    _datePickerView.dataSource = self;
    [self.contentView addSubview:_datePickerView];
    [_datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(130);
    }];
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataArr.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 22;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _dataArr[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
