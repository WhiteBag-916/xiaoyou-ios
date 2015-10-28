//
//  MyTimetableHeadView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MyTimetableHeadView.h"

#define K_LABEL_TAG          600000
#define K_LABEL_T            SCALE_NUM(5)
#define K_LABEL_L            SCALE_NUM(40)
#define K_LABEL_WH            SCALE_NUM(30)

@interface MyTimetableHeadView ()

@property (nonatomic, assign) NSInteger selectDay;

@end

@implementation MyTimetableHeadView

- (instancetype)init {
    if (self = [super init]) {
        
        self.backgroundColor = KCOLOR_455A64;
        
        NSArray *dayArr = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
        
        UILabel *mas_Label = nil;
        
        for (int i = 0; i < 7; ++i) {
            UILabel *label = [UILabel new];
            label.tag = K_LABEL_TAG + i;
            label.text = dayArr[i];
            label.layer.cornerRadius = K_LABEL_WH/2;
            label.layer.masksToBounds = YES;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = KCOLORWHITE;
            label.userInteractionEnabled = YES;
            label.font = CONTENT_FONT(13);
//            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseDay:)]];
            [self addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                if (nil == mas_Label) {
                    //第一个
                    make.left.mas_equalTo(K_LABEL_L);
                } else {
                    make.left.equalTo(mas_Label.mas_left).offset(K_LABEL_L);
                }
                make.width.height.mas_equalTo(K_LABEL_WH);
                make.top.mas_equalTo(K_LABEL_T);
            }];
            
            mas_Label = label;
        }
        
        _selectDay = -1;
    }
    
    return self;
}

- (void)resetSelectDay:(NSInteger)selectDay {
    if (_selectDay >= 0) {
        //先取消选中
        UILabel *label = (UILabel *)[self viewWithTag:K_LABEL_TAG+_selectDay];
        label.textColor = KCOLORWHITE;
        label.backgroundColor = [UIColor clearColor];
    } else {
        //选中
        UILabel *label = (UILabel *)[self viewWithTag:K_LABEL_TAG+selectDay];
        label.textColor = KCOLOR_B4;
        label.backgroundColor = [UIColor whiteColor];
    }
    
    _selectDay = selectDay;
}

//选择天
- (void)chooseDay:(UIGestureRecognizer *)res {
    NSInteger dayNum = res.view.tag-K_LABEL_TAG;
    [self resetSelectDay:dayNum];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
