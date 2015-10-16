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

@property (nonatomic,strong) UIImageView * releaseAndTypeImageView;
@property (nonatomic,strong) UILabel * releaseAndTypeLabel;
@property (nonatomic,strong) UIPickerView * pickerView;
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
        [self setUpUI];

    return self;
}

-(void)setCellType:(NSInteger) num
{
    if (num == 0) {
        _dataArr = @[@"全部",@"今天",@"一周内",@"两周内"];
        _releaseAndTypeImageView.image = [UIImage imageNamed:@"funny_detail_time"];
        _releaseAndTypeLabel.text = @"时间与日期";
    }
    else if (num == 1)
    {
        _dataArr = @[@"不限",@"学校活动",@"校友活动",@"个人活动",@"社团活动"];
        _releaseAndTypeImageView.image = [UIImage imageNamed:@"activity-releaser"];
        _releaseAndTypeLabel.text = @"发布者";

    }
    else
    {
        _dataArr = @[@"全部",@"综合类",@"学术类",@"公益类",@"教科类"];
        _releaseAndTypeImageView.image = [UIImage imageNamed:@"funny_detail_category"];
        _releaseAndTypeLabel.text = @"类型";
        
    }
    [_pickerView reloadAllComponents];
}

-(void)setUpUI
{
    //图
    _releaseAndTypeImageView = [[UIImageView alloc] init];
    _releaseAndTypeImageView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_releaseAndTypeImageView];
    [_releaseAndTypeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(15));
        make.top.mas_equalTo(SCALE_NUM(22));
        make.height.width.mas_equalTo(SCALE_NUM(17));
    }];
    //字
    _releaseAndTypeLabel = [[UILabel alloc] init];
    _releaseAndTypeLabel.backgroundColor = [UIColor clearColor];
    _releaseAndTypeLabel.font = CONTENT_FONT(14);
    [self.contentView addSubview:_releaseAndTypeLabel];
    [_releaseAndTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_releaseAndTypeImageView.mas_right).offset(SCALE_NUM(5));
        make.centerY.equalTo(_releaseAndTypeImageView);
        make.height.mas_equalTo(SCALE_NUM(17));
        make.width.mas_equalTo(SCALE_NUM(100));
    }];
    
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self.contentView addSubview:_pickerView];
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(SCALE_NUM(150));
        make.height.mas_equalTo(SCALE_NUM(130));
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
