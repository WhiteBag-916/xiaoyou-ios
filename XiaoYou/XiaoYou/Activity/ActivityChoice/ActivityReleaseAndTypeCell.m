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

@property (nonatomic,strong) GetFilterConditionsModel * model;
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

-(void)setCellType:(GetFilterConditionsModel *) model
{
    _model = model;
    if (_myType == ACTIVITY_CHOICE_TYPE)
    {
        
        if ([model.name isEqualToString:@"空闲"])
        {
            _dataArr = model.tags;
            _releaseAndTypeImageView.image = [UIImage imageNamed:@"havetime－icon_free"];
            _releaseAndTypeLabel.text = model.name;
        }
        else if ([model.name isEqualToString:@"日期"]) {
            _dataArr = model.tags;
            _releaseAndTypeImageView.image = [UIImage imageNamed:@"funny_detail_time"];
            _releaseAndTypeLabel.text = model.name;
        }
        else if ([model.name isEqualToString:@"活动创建来源"])
        {
            _dataArr = model.tags;
            _releaseAndTypeImageView.image = [UIImage imageNamed:@"activity-releaser"];
            _releaseAndTypeLabel.text = model.name;
            
        }
        else
        {
            _dataArr = model.tags;
            _releaseAndTypeImageView.image = [UIImage imageNamed:@"funny_detail_category"];
            _releaseAndTypeLabel.text = model.name;
        }
    }
    else
    {
//        if (num == 0)
//        {
//            _dataArr = @[@"新校区",@"老校区"];
//            _releaseAndTypeImageView.image = [UIImage imageNamed:@"havetime_icon_academy"];
//            _releaseAndTypeLabel.text = @"校区";
//        }
        
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
    _releaseAndTypeLabel.font = CONTENT_FONT(12);
    _releaseAndTypeLabel.textColor = KCOLOR_B3;
    [self.contentView addSubview:_releaseAndTypeLabel];
    [_releaseAndTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_releaseAndTypeImageView.mas_right).offset(SCALE_NUM(5));
        make.centerY.equalTo(_releaseAndTypeImageView);
        make.height.mas_equalTo(SCALE_NUM(12));
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

- (BOOL)needLine
{
    return YES;
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
    Tags * tag = _dataArr[row];
    return tag.name;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.delegate respondsToSelector:@selector(didSelectRow:andType:)])
    {
        [self.delegate didSelectRow:_dataArr[row] andType:_model.param];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = KCOLOR_B4;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:14]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
