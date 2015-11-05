//
//  CodeEnlargeView.h
//  XiaoYou
//
//  Created by 尹先森 on 15/11/3.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YCommonDialogView.h"
#import "ProfileInfo.h"
#import "LoginResp.h"

@interface CodeEnlargeView : YCommonDialogView

-(instancetype)initWithModel1:(ProfileInfo *) model1 andModel2:(LoginResp *)model2;

@end
