//
//  CurriculumManager.h
//  Component
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YManager.h"
#import "YAction.h"

@interface CurriculumManager : YManager<YManager>
AS_SINGLETON(CurriculumManager);

/*********************************************************************
 函数名称 : courseTimeList
 函数描述 : 获取课程学时对应时间
 参数 : N/A
 返回值 : CourseTimeListModel
 作者 : XiongChen
 *********************************************************************/
- (void)courseTimeList:(ActionCompleteBlock)block;

@end
