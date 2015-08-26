//
//  CNTextController.h
//  CampusNet
//
//  Created by AndLiSoft on 15/6/18.
//  Copyright (c) 2015年 AndLiSoft. All rights reserved.
//

#import "YViewController.h"

typedef NS_ENUM(NSInteger, YCNTextType) {
    TextSchoolOther,                    //其他
    TextTermsOfAgreementType,           //协议条款
};

/*
 该控制器只用来显示一个简单的文本
 */
@interface CNTextController : YViewController

@property (strong, nonatomic) NSString *strText;
@property (assign, nonatomic) YCNTextType textType;

@end
