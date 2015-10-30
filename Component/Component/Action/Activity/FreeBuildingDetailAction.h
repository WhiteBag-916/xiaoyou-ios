//
//  FreeBuildingDetailAction.h
//  Component
//
//  Created by 熊宸 on 15/10/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface FreeBuildingDetailAction : YHTTPRequestAction<YAction>

@property (nonatomic, strong) NSString *buildName;

@end
