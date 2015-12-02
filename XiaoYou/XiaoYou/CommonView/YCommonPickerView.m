//
//  YCommonPickerView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YCommonPickerView.h"

NSString *const kPickerViewCalendarRemind = @"PickerViewCalendarRemindC";

@interface YCommonPickerView ()
<UIPickerViewDataSource
,UIPickerViewDelegate>

@property (nonatomic, assign) PickerView_Type viewType;

//一般数据
@property (strong, nonatomic) NSMutableArray *commonArray;

@end

@implementation YCommonPickerView

- (instancetype)initWithType:(PickerView_Type)type commonArray:(NSArray *)commonArray
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)])
    {
        _viewType = type;
        
        self.commonArray = [commonArray mutableCopy];
        
        self.delegate = self;
        self.dataSource = self;
    }
    
    return self;
}

#pragma mark - 获取数据
- (NSDictionary *)getData
{
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    NSInteger row1 = [self selectedRowInComponent:0];
    if (PickerView_CalendarRemind == _viewType)
    {
        [data setValue:self.commonArray[row1] forKey:kPickerViewCalendarRemind];
    }
    
    return data;
}

#pragma mark:重载地点数组
- (void)reloadArr:(NSInteger)row inComponent:(NSInteger)component
{
//    if (PageView_City == _viewType)
//    {
//        NSString *selectedLeft = self.districtLeftID[row];
//        NSDictionary *citys = [[NSDictionary alloc] initWithDictionary:self.cityArr[@"city"]];
//        NSArray *result = [[NSArray alloc] initWithArray:citys[selectedLeft]];
//        self.rightArr = [[NSMutableArray alloc] init];
//        self.districtRightID = [[NSMutableArray alloc] init];
//        int i = 0;
//        for (i = 0; i < result.count; i++) {
//            NSDictionary *item = result[i];
//            [self.rightArr addObject:item[@"name"]];
//            [self.districtRightID addObject:item[@"id"]];
//        }
//    }
//    else if (PageView_CaseRole == _viewType)
//    {
//        NSDictionary *dataDic = [YShareData defaultData][kShareData_YCP_GetTypeApi];
//        self.rightArr = [NSMutableArray arrayWithArray:dataDic[kPerson_case_position][row+1]];
//        [self.rightArr removeObjectAtIndex:0];
//    }
    
    [self reloadComponent:1];
    [self selectRow:0 inComponent:1 animated:true];
    
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
//    if (PageView_City == _viewType || PageView_DateYM == _viewType || PageView_CaseRole == _viewType)
//    {
//        return 2;
//    }
//    else
//    {
//        return 1;
//    }
    return 1;     //这个picker里的组键数
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
//    if (PageView_City == _viewType || PageView_DateYM == _viewType || PageView_CaseRole == _viewType)
//    {
//        if (0 == component) {
//            return self.leftArr.count;
//        }
//        else if(1 == component)
//        {
//            return self.rightArr.count;
//        }
//    }
//    else if (PageView_Industry == _viewType)
//    {
//        return _industryArray.count-1;
//    }
    
    return _commonArray.count;  //数组个数
    
}


#pragma mark UIPickerViewDelegate
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    if (0 == component && (PageView_City == _viewType || PageView_CaseRole == _viewType)) {
//        [self reloadArr:row inComponent:component];
//    }
//}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
//    if (PageView_City == _viewType
//    || PageView_DateYM == _viewType
//    || PageView_CaseRole == _viewType)
//    {
//        if (0 == component) {
//            return self.leftArr[row];
//        }
//        else
//        {
//            return self.rightArr[row];
//        }
//    }
//    else if (PageView_Industry == _viewType)
//    {
//        return _industryArray[row+1];
//    }
    return _commonArray[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    CGFloat componentWidth = 0.0;
    
//    if (PageView_City == _viewType)
//    {
//        if (component == 0)
//        {
//            componentWidth = 100.0; // 第一个组键的宽度
//        }
//        else
//        {
//            componentWidth = 180.0; // 第2个组键的宽度
//        }
//    }
//    else if (PageView_DateYM == _viewType)
//    {
//        componentWidth = self.width/2;
//    }
//    else if (PageView_CaseRole == _viewType)
//    {
//        if (component == 0)
//        {
//            componentWidth = self.width/2 - 10;
//        }
//        else
//        {
//            componentWidth = self.width/2 + 10;
//        }
//    }
//    else
    {
        componentWidth = self.width;
    }
    
    return componentWidth;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.f;
}

@end
