//
//  ContactsSQLiteManager.h
//  Component
//
//  Created by HuiYin on 15/8/11.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLiteManager : NSObject

+(instancetype)shareSQLiteManager;

-(BOOL)runSQL:(NSString *)sql;

@end
