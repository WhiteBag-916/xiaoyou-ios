//
//  NotifyRemindDao.h
//  Component
//
//  Created by sheng on 15/11/4.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YDatabaseDao.h"
#import "YBaseService.h"

#define TABLENAME @"NotifyInfoModel"

@interface YDatabaseDao ()

@property (nonatomic,strong) YBaseService *baseService;

@end

@interface NotifyRemindDao : YDatabaseDao





@end
