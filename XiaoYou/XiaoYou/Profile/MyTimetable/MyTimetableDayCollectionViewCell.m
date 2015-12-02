//
//  MyTimetableDayCollectionViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MyTimetableDayCollectionViewCell.h"

NSString *const kMyTimetableDayCollectionViewCell = @"MyTimetableDayCollectionViewCellId";

#define K_NUM_T    SCALE_NUM(11)   //数字上
#define K_TIME_B    SCALE_NUM(3)   //时间下

@interface MyTimetableDayCollectionViewCell ()

@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *rightLine;
@property (nonatomic, strong) UIView *bottomLine;


@end

@implementation MyTimetableDayCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //数字
        _numLabel = [YUtils initLabel:CONTENT_FONT(16)
                                color:KCOLOR_B4
                                 text:@"1"
                            alignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_numLabel];
        
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
//            make.top.mas_equalTo(K_NUM_T);
        }];
        
        //时间
        _timeLabel = [YUtils initLabel:CONTENT_FONT(10)
                                color:KCOLOR_B5
                                 text:@"8:00"
                            alignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_numLabel.mas_bottom).offset(K_TIME_B);
            make.left.right.equalTo(_numLabel);
            make.bottom.mas_equalTo(-K_TIME_B);
        }];
        
        //右边的线
        _rightLine = [UIView new];
        _rightLine.backgroundColor = KCOLOR_B2;
        [self.contentView addSubview:_rightLine];
        [_rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.width.mas_equalTo(1);
            make.right.mas_equalTo(-1);
        }];
        
        //下面的线
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = KCOLOR_B2;
        [self.contentView addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(-1);
        }];
    }
    
    return self;
}

- (void)initData:(NSString *)numText
        timeText:(NSString *)timeText
   showRightLine:(BOOL)showRightLine
  showBottomLine:(BOOL)showBottomLine {
    if (nil != numText) {
        _numLabel.text = numText;
        _numLabel.hidden = NO;
    } else {
        _numLabel.hidden = YES;
    }
    if (nil != timeText) {
        _timeLabel.text = timeText;
        _timeLabel.hidden = NO;
    } else {
        _timeLabel.hidden = YES;
    }
    
    _rightLine.hidden = showRightLine;
    _bottomLine.hidden = showBottomLine;
}

@end
