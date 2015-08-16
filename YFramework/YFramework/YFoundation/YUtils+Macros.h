//
//  YUtils+Macros.h
//  YFramework
//
//  Created by abc on 15/4/13.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#ifndef YFramework_YUtils_Macros_h
#define YFramework_YUtils_Macros_h

//定义弱引用宏
#ifndef WS
#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self;
#endif

//定义强引用宏
#ifndef SS
#define SS(strongSelf, weakSelf) __strong __typeof(&*self) strongSelf = weakSelf;
#endif

//声明和定义单类宏
#undef AS_SINGLETON
#define AS_SINGLETON(__class)    \
-(__class *) sharedInstance; \
+(__class *) sharedInstance;

#undef DEF_SINGLETON
#define DEF_SINGLETON(__class)                                                   \
-(__class *) sharedInstance                                                  \
{                                                                            \
return [__class sharedInstance];                                         \
}                                                                            \
+(__class *) sharedInstance                                                  \
{                                                                            \
static dispatch_once_t once;                                             \
static __class *__singleton__;                                           \
dispatch_once(&once, ^{ __singleton__ = [[[self class] alloc] init]; }); \
return __singleton__;                                                    \
}
#endif

//Safe String
#define SStr(str) (nil == str? @"":str)
#define D2IStr(ddata) ([NSString stringWithFormat:@"%ld",(NSInteger)(ddata)])

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
