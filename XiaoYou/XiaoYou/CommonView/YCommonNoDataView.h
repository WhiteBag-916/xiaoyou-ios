//
//  YCommonNoDataView.h
//  XiaoYou
//
//  Created by 熊宸 on 15/10/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YView.h"

typedef enum
{
    NoDataView_SearchActivity,          //搜索活动
}NoDataView_Type;

@interface YCommonNoDataView : YView

- (instancetype)initWithType:(NoDataView_Type)type;

@end
