//
//  YCommonNoDataView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YCommonNoDataView.h"

@interface YCommonNoDataView ()

@property (nonatomic, assign) NoDataView_Type viewType;

@property (nonatomic, strong) UIImageView *noDataImageView;

@end

@implementation YCommonNoDataView

- (instancetype)initWithType:(NoDataView_Type)type
{
    if (self = [super init])
    {
        self.backgroundColor = KCOLOR_W1;
        _viewType = type;
        
        _noDataImageView = [[UIImageView alloc] init];
        [self addSubview:_noDataImageView];
        [_noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        switch (_viewType) {
            case NoDataView_SearchActivity:
                _noDataImageView.image = [UIImage imageNamed:@"schedule－picture－nosearch"];
                break;
                
            default:
                break;
        }
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
