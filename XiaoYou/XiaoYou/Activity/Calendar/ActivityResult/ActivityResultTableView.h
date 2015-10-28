//
//  ActivityResultTableView.h
//  XiaoYou
//
//  Created by 尹先森 on 15/10/16.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableView.h"

typedef enum : NSUInteger {
    DEFAULT,
    SEARCH_TYPE,
} RESUTLT_TYPE;

@interface ActivityResultTableView : YTableView

@property(nonatomic,strong)NSMutableArray * dataSouceArr;
@property(nonatomic,strong)NSDictionary * requestDic;

-(instancetype)initWithResultType:(RESUTLT_TYPE)type;

- (void)sendRequest;

- (void)sendRequestBySearchDataByKey:(NSString*)key;

@end
